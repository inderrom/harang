package com.harang.flight.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.harang.flight.service.FlightServiceImpl;
import com.harang.flight.service.IFlightService;
import com.harang.vo.AirportVO;
import com.harang.vo.FlightVO;
import com.harang.vo.MemberVO;

@WebServlet("/flight.do")
public class FlightController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private IFlightService service;
	
	@Override
	public void init() throws ServletException {
		service = FlightServiceImpl.getInstance();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String job = request.getParameter("job");
		
		switch(job) {
		case "list":
			getFlightList(request, response);
			break;
		case "port":
			getPort(request, response);
			break;
		case "toBooking":
			toBooking(request, response);
			break;
		case "flight":
			getFlight(request, response);
			break;
		case "cheap":
			getCheapFlight(request,response);
			break;
		}
	}
	
	// 최저가 항공편 가져오기
	private void getCheapFlight(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String arrport = request.getParameter("arrport");
		
		List<FlightVO> flightList = service.getCheapFlight(arrport);
		
		Gson gson = new Gson();
		String jsonData = gson.toJson(flightList);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}
	
	// 하나의 항공편 가져오기
	private void getFlight(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fliId = request.getParameter("fliId");
		FlightVO flightVo = service.getFlight(fliId);
		
		Gson gson = new Gson();
		String jsonData = gson.toJson(flightVo);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}
	
	// 예매페이지로 이동
	private void toBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션에 현재 회원 정보를 가져오기
		HttpSession session = request.getSession();
		session.removeAttribute("goFlight");
		session.removeAttribute("comeFlight");
		session.removeAttribute("bookInfo");
		session.removeAttribute("pssgList");
		session.removeAttribute("goSeat");
		session.removeAttribute("comeSeat");
//		session.removeAttribute("seatInfo");
		
		MemberVO memVo = (MemberVO) session.getAttribute("memInfo");
		
		// 입력받은 예매 정보 가져오기
		String goFlightId = request.getParameter("goFlightId");
		String goDate = request.getParameter("goDate");
		
		String comeFlightId = request.getParameter("comeFlightId");
		String comeDate = request.getParameter("comeDate");
		
		// 탑승객 수
		int count = Integer.parseInt(request.getParameter("count"));
		
		// 입력받은 항공편 정보 가져오기
		FlightVO goFlight = service.getFlight(goFlightId);
		FlightVO comeFlight = service.getFlight(comeFlightId);
		
		goFlight.setDate(goDate);
		goFlight.setCount(count);
		
		// 예매 정보가 왕복편일 경우
		if(comeFlight != null) {
			comeFlight.setDate(comeDate);
			comeFlight.setCount(count);
		}
		
		
		// 예매 정보를 세션에 저장
		session.setAttribute("goFlight", goFlight);
		session.setAttribute("comeFlight", comeFlight);
		
		// 로그인하지 않았을 경우
		if(memVo == null) {
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().write("<script>alert('로그인이 필요합니다.'); location.href='" + request.getContextPath() + "/view/login/login.jsp' </script>");
			return;
		}
		
		request.getRequestDispatcher("/view/ticket/booking.jsp").forward(request, response);
	}
	
	// 공항 목록
	private void getPort(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String airportName = request.getParameter("airportName");
		
		List<AirportVO> airportList = service.getAirportList(airportName);
		
		Gson gson = new Gson();
		String jsonData = gson.toJson(airportList);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}
	
	// 항공편 목록
	private void getFlightList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String depport = request.getParameter("fli_depport");
		String arrport = request.getParameter("fli_arrport");
		String goDate = request.getParameter("goDate");
		String comeDate = request.getParameter("comeDate");
		String adult = request.getParameter("adult");
		String child = request.getParameter("child");
		
		int flightCount = 1;
		if(comeDate != null) flightCount = 2;
		
		
		Date date = null;
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat simDate = new SimpleDateFormat("yyyy-MM-dd");
		String [] dayArr = {"일","월","화","수","목","금","토"};
		
		String weekStr = "";
		
		// 항공편 목록이 담기는 List 객체
		// schedule.get(0) -> 가는 편
		// schedule.get(1) -> 오는 편
		List<List<FlightVO>> schedule = new ArrayList<>();
		
		// i = 0 가는 편
		// i = 1 오는 편
		for(int i = 0; i < flightCount; i++) {
			String targetDate = "";
			String dep = "";
			String arr = "";
			
			switch(i) {
			case 0:
				targetDate = goDate;
				dep = depport;
				arr = arrport;
				break;
			case 1:
				targetDate = comeDate;
				dep = arrport;
				arr = depport;
				break;
			}
			
			// 입력받은 날짜를 Date 타입으로 변환
			try {
				date = simDate.parse(targetDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			// 입력받은 날짜에서 요일을 가져온다.
			cal.setTime(date);
			weekStr = dayArr[cal.get(Calendar.DAY_OF_WEEK) - 1];
			
			// 가져올 항공편 목록의 조건을 지정
			FlightVO flightVo = new FlightVO();
			flightVo.setFli_depport(dep);
			flightVo.setFli_arrport(arr);
			flightVo.setFli_dayofweek(weekStr);
			
			schedule.add(service.getFlightList(flightVo));
		}
		
		// 사용자가 입력한 정보가 담기는 Map
		Map<String, String> searchInfo = new HashMap<>();
		searchInfo.put("flightCount", String.valueOf(flightCount)); // 편도 : 1 / 왕복 : 2
		searchInfo.put("fliDepport", depport); // 출발지
		searchInfo.put("fliArrport", arrport); // 도착지
		searchInfo.put("goDate", goDate); // 가는날
		searchInfo.put("comeDate", comeDate); // 오는날
		searchInfo.put("adult", adult); // 어른
		searchInfo.put("child", child); // 영유아 / 청소년
		
		request.setAttribute("searchInfo", searchInfo);
		request.setAttribute("flightList", schedule);
		
		request.getRequestDispatcher("/view/ticket/searchAirplane.jsp").forward(request, response);
	}

}
