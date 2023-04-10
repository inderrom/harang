package datagetter;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import kr.or.ddit.harang.airline.service.AirlineServiceImpl;
import kr.or.ddit.harang.airline.service.IAirlineService;
import kr.or.ddit.harang.vo.AirlineVO;

public class AirlineDataGetter {

	public static void main(String[] args) {
		new AirlineDataGetter().getAirline();
	}
	
	
	private IAirlineService airlineService = AirlineServiceImpl.getInstance();
	
	public void getAirline() {
		
		StringBuilder urlBuilder = null;
		
		URL url = null;
		HttpURLConnection conn = null;
		
		BufferedReader rd = null;
		StringBuilder sb = null;
		
		try {
			
			urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getAirmanList"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + "9TscTEWwoFUI2OzuPJWp%2Bk1FmhozUx8gk32WztJ7sxLUQrGgyzqRMHQ2rpqRjXB8l2mugEiOBXovV%2FSs9nBv9g%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); /*데이터 타입(xml, json)*/
	        
	        url = new URL(urlBuilder.toString());
	        conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        
	        System.out.println("Response code: " + conn.getResponseCode());
	        
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
//	        System.out.println(sb.toString());
	        insertAirline(sb);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insertAirline(StringBuilder sb) {
		
		DocumentBuilderFactory dbf = null;
		DocumentBuilder db = null;
		Document doc = null;
		
		NodeList airlineId = null;
		NodeList airlineNm = null;
		
		try {
			
			dbf = DocumentBuilderFactory.newInstance();
			db = dbf.newDocumentBuilder();
			
			doc = db.parse(new InputSource(new StringReader(sb.toString())));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		airlineId = doc.getElementsByTagName("airlineId");
		airlineNm = doc.getElementsByTagName("airlineNm");
		
		for(int i = 0; i < airlineId.getLength(); i++) {
			
			String airline_id = airlineId.item(i).getChildNodes().item(0).getNodeValue();
			String airline_name = airlineNm.item(i).getChildNodes().item(0).getNodeValue();
			
			AirlineVO airlineVo = new AirlineVO();
			airlineVo.setAirline_id(airline_id);
			airlineVo.setAirline_name(airline_name);
			
			airlineService.insertAirline(airlineVo);
		}
		
		
		
	}
	
}
