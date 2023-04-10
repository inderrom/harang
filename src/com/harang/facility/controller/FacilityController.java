package com.harang.facility.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.harang.facility.service.FacilityServiceImpl;
import com.harang.facility.service.IFacilityService;
import com.harang.vo.AirlineVO;
import com.harang.vo.AirportVO;
import com.harang.vo.FacilityVO;
import com.harang.vo.ParkVO;
import com.harang.vo.RouteVO;
import com.harang.vo.TransportVO;


@WebServlet("/facility.do")
public class FacilityController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private IFacilityService service;
	
	@Override
	public void init() throws ServletException {
		service = FacilityServiceImpl.getInstance();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		response.setContentType("application/json;charset=utf-8");
		
		String category = request.getParameter("category");
		
		switch (category) {
		case "airline":
			getAirlineList(request,response);
			return;
		case "airport":
			getAirportList(request,response);
			return;
		case "transport":
			getSelectTransportList(request,response);
			return;
		case "facility":
			getSelectFacilityList(request,response);
			return;
		case "classify":
			getSelectFacilityClassify(request,response);
			return;
		case "getclassifyFile":
			getclassifyFile(request,response);
			return;
		case "route":
			getTransportPriceList(request,response);
			return;
		case "parking":
			getParkList(request,response);
			return;

		}

	}
	
	// 공항별 주차장 정보메서드 
	private void getParkList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String airport_name = request.getParameter("park");
		
		List<ParkVO> parkList = service.getParkInfo(airport_name);
		
		Gson gson= new Gson();
		String parkData = gson.toJson(parkList);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(parkData);
		response.flushBuffer();
	}

	// 모든공항 교통시설 가져오기
	private void getTransportPriceList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 공항 목록 가져오기
		List<AirportVO> airportList= service.getAirportList();
		
		// 공항별 대중교통 노선 목록을 담을 Map 객체
		Map<String, List<RouteVO>> map = new HashMap<String, List<RouteVO>>();
		
		for (int i = 0; i < airportList.size(); i++) {
			String airportName = airportList.get(i).getAirport_name(); // 공항명을 가져온다.
			
			// 해당 공항의 노선 목록을 가져온다.
			List<RouteVO> routePriceList = service.getTransportPriceList(airportName);
			map.put(airportName, routePriceList);
		}
		
		Gson gson = new Gson();
		String routePriceListData = gson.toJson(map);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(routePriceListData);
		response.flushBuffer();
	}

	// 공항별 이미지 파일 가져오는
	private void getclassifyFile(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 공항 이름과 시설 분류를 가져온다.
		String airportName = request.getParameter("airportName");
		String classify = request.getParameter("classify");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("ariportName", airportName);
		map.put("classify", classify);
		
		// 해당 공항의 시설 분류에 속하는 시설만 가져온다.
		List<FacilityVO> classifyList= service.getclassifyFile(map);
		
		Gson gson = new Gson();
		String facilityListData = gson.toJson(classifyList);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(facilityListData);
		response.flushBuffer();
	}

	//공항 시설분류 메서드
	private void getSelectFacilityClassify(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String airportName = request.getParameter("ariportName");
		
		// 시설의 분류명을 담을 List 객체
		List<String> classify = new ArrayList<String>();
		
		// 해당 공항의 시설 분류명 목록을 가져온다.
		List<FacilityVO> classifyList= service.getSelectFacilityClassifyList(airportName);
		
		for (FacilityVO facvo : classifyList) {
			classify.add(facvo.getFac_type());
		}
		
		Gson gson = new Gson();
		String facilityClassifyData = gson.toJson(classify);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(facilityClassifyData);
		response.flushBuffer();
	}

	// 공항별 시설 안내 메서드
	private void getSelectFacilityList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 공항 목록 가져오기
		List<AirportVO> airportList= service.getAirportList();
		
		Map<String, List<FacilityVO>> map = new HashMap<>();
		
		for(int i = 0; i < airportList.size(); i++) {
			String airportName = airportList.get(i).getAirport_name(); // 공항명 꺼내기
			
			// 해당 공항의 시설 정보를 가져온다.
			List<FacilityVO> facilityList = service.getSelectFacilityList(airportName);
			map.put(airportName, facilityList); // 공항별로 시설 목록을 저장한다.
		}
		
		Gson gson = new Gson();
		String selectFacilityData = gson.toJson(map);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(selectFacilityData);
		response.flushBuffer();
		
	}
	
	// 공항별 대중교통 안내 메서드
	private void getSelectTransportList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		List<AirportVO> airportList= service.getAirportList();
		
		Map<String, List<TransportVO>> map = new HashMap<>();
		
		for(int i = 0; i < airportList.size(); i++) {
			String airportName = airportList.get(i).getAirport_name(); // 공항명 꺼내기
			
			// 해당 공항의 대중교통 종류를 가져온다.
			List<TransportVO> transportList = service.getSelectTransportList(airportName);
			map.put(airportName, transportList); // 공항별로 대중교통 종류를 저장한다.
		}
		
		Gson gson = new Gson();
		String transportData = gson.toJson(map);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(transportData);
		response.flushBuffer();
		
	}
	
	//공항 목록 구하는 메서드
	private void getAirportList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		List<AirportVO> airportList= service.getAirportList();
		
		Gson gson = new Gson();
		String airlineData= gson.toJson(airportList);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(airlineData);
		response.flushBuffer();
	}

	//항공사 목록 메서드
	private void getAirlineList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		List<AirlineVO> airlineList = service.getAirlineList();
		
		Gson gson = new Gson();
		String airlineData= gson.toJson(airlineList);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(airlineData);
		response.flushBuffer();
	}
}
