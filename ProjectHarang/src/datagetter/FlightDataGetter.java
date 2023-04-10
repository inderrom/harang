package datagetter;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import kr.or.ddit.harang.airline.service.AirlineServiceImpl;
import kr.or.ddit.harang.airline.service.IAirlineService;
import kr.or.ddit.harang.airport.service.AirportServiceImpl;
import kr.or.ddit.harang.airport.service.IAirportService;
import kr.or.ddit.harang.flight.service.FlightServiceImpl;
import kr.or.ddit.harang.flight.service.IFlightService;
import kr.or.ddit.harang.vo.AirlineVO;
import kr.or.ddit.harang.vo.AirportVO;
import kr.or.ddit.harang.vo.FlightVO;

public class FlightDataGetter {
	
	
	public static void main(String[] args) {
		new FlightDataGetter().start();
	}
	
	
	private IAirlineService airlineService = AirlineServiceImpl.getInstance();
	private IAirportService airportService = AirportServiceImpl.getInstance();
	private IFlightService flightService = FlightServiceImpl.getInstance();
	
	public void start() {
		
		List<AirportVO> airportList = airportService.selectAll();
		List<AirlineVO> airlineList = airlineService.selectAll();
		
		String depPort = "";
		String arrPort = "";
		
		String depPortName = "";
		String arrPortName = "";
		
		String airline = "";
		String airlineName = "";
		
		for(AirportVO depvo : airportList) {
			depPort = depvo.getAirport_id();
			depPortName = depvo.getAirport_name();
			
			for(AirportVO arrvo : airportList) {
				arrPort = arrvo.getAirport_id();
				arrPortName = arrvo.getAirport_name();
				
				if(arrPort.equals(depPort)) continue;
				
				for(AirlineVO airlineVo : airlineList) {
					airline = airlineVo.getAirline_id();
					airlineName = airlineVo.getAirline_name();
					
					getFlightData(depPort, depPortName, arrPort, arrPortName, airline, airlineName);
					
				}
			}
		}
	}
	
	public void getFlightData(String depPort, String depPortName, String arrPort, String arrPortName, String airline, String airlineName) {
		
		StringBuilder urlBuilder = null;
		
		URL url = null;
		HttpURLConnection conn = null;
		
		BufferedReader rd = null;
		StringBuilder sb = null;
		
		int day = 24; // 일자
		String fli_dayofweek = "토";
		
		try {
			
			urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getFlightOpratInfoList"); /*URL*/
//	        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + "c7ERR5E4Zy2gt20RPRVO3JFjwVk5xVcoSFZp2b%2BoRhtYA7pw%2BGVi6WHHaRz41byWh%2FNNzwvkdRzV84Xqw4NGdA%3D%3D"); /*Service Key*/
	        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + "9TscTEWwoFUI2OzuPJWp%2Bk1FmhozUx8gk32WztJ7sxLUQrGgyzqRMHQ2rpqRjXB8l2mugEiOBXovV%2FSs9nBv9g%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("3000", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); /*데이터 타입(xml, json)*/
	        urlBuilder.append("&" + URLEncoder.encode("depAirportId","UTF-8") + "=" + URLEncoder.encode(depPort, "UTF-8")); /*출발공항ID*/
	        urlBuilder.append("&" + URLEncoder.encode("arrAirportId","UTF-8") + "=" + URLEncoder.encode(arrPort, "UTF-8")); /*도착공항ID*/
	        urlBuilder.append("&" + URLEncoder.encode("depPlandTime","UTF-8") + "=" + URLEncoder.encode("202212" + String.valueOf(day), "UTF-8")); /*출발일(YYYYMMDD)*/
	        urlBuilder.append("&" + URLEncoder.encode("airlineId","UTF-8") + "=" + URLEncoder.encode(airline, "UTF-8")); /*항공사ID*/
	        
	        url = new URL(urlBuilder.toString());
	        
	        conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        
	        System.out.println("[" + conn.getResponseCode() + "] " + depPortName + " -> " + arrPortName + "  :  <" + airlineName + ">");
	        
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        
	        sb = new StringBuilder();
	        
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        
	        rd.close();
	        conn.disconnect();
			
		} catch (Exception e) {
			System.out.println("!--- 서버와의 연결이 끊겼습니다. ---!");
			return;
		}
		
		printList(sb, airline, fli_dayofweek);
//		System.out.println(sb.toString());

	}
	
	public void printList(StringBuilder sb, String airline_id, String fli_dayofweek) {
		
		DocumentBuilderFactory dbf = null;
		DocumentBuilder db = null;
		Document doc = null;
		
		NodeList vihicleId = null;
		NodeList airlineNm = null;
		
		NodeList depAirportNm = null;
		NodeList arrAirportNm = null;
		
		NodeList depPlandTime = null;
		NodeList arrPlandTime = null;
		NodeList economyCharge = null;
		
		try {
			dbf = DocumentBuilderFactory.newInstance();
			db = dbf.newDocumentBuilder();
			doc = db.parse(new InputSource(new StringReader(sb.toString())));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		vihicleId = doc.getElementsByTagName("vihicleId");
		airlineNm = doc.getElementsByTagName("airlineNm");
		
		depAirportNm = doc.getElementsByTagName("depAirportNm");
		arrAirportNm = doc.getElementsByTagName("arrAirportNm");
		
		depPlandTime = doc.getElementsByTagName("depPlandTime");
		arrPlandTime = doc.getElementsByTagName("arrPlandTime");
		
		economyCharge = doc.getElementsByTagName("economyCharge");
		
		for(int i = 0; i < vihicleId.getLength(); i++) {
			String fli_id = vihicleId.item(i).getChildNodes().item(0).getNodeValue();
			// airline_id
			String fli_airline = airlineNm.item(i).getChildNodes().item(0).getNodeValue();
			String fli_depport = depAirportNm.item(i).getChildNodes().item(0).getNodeValue();
			String fli_arrport = arrAirportNm.item(i).getChildNodes().item(0).getNodeValue();
			
			String fli_deptime = depPlandTime.item(i).getChildNodes().item(0).getNodeValue();
			fli_deptime = fli_deptime.substring(8);
			String fli_arrtime = arrPlandTime.item(i).getChildNodes().item(0).getNodeValue();
			fli_arrtime = fli_arrtime.substring(8);
			
			int fli_price = 0;
			try {
				fli_price = Integer.parseInt(economyCharge.item(i).getChildNodes().item(0).getNodeValue());
				
			} catch (Exception e) {
				fli_price = 0;
			}
			// 월
			
			System.out.print(fli_id + "   " + airline_id + "   " + fli_airline + "   " + fli_depport + "   " + fli_arrport + "   " + fli_deptime + "   " + fli_arrtime + "   " + fli_price);
			System.out.println();
			
			FlightVO flightVo = new FlightVO();
			flightVo.setFli_id(fli_id);
			flightVo.setAirline_id(airline_id);
			flightVo.setFli_airline(fli_airline);
			flightVo.setFli_depport(fli_depport);
			flightVo.setFli_arrport(fli_arrport);
			flightVo.setFli_deptime(fli_deptime);
			flightVo.setFli_arrtime(fli_arrtime);
			flightVo.setFli_price(fli_price);
			flightVo.setFli_dayofweek(fli_dayofweek);
			
			flightService.insertFlight(flightVo);
		}
	}

}
