package com.harang.airport.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.harang.airport.service.IScheduleService;
import com.harang.airport.service.ScheduleServiceImpl;
import com.harang.vo.FlightVO;

@WebServlet("/schedule.do")
public class ScheduleController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	IScheduleService service;
	
	@Override
	public void init() throws ServletException {
		service = ScheduleServiceImpl.getInstance();
	}
	
    // 공항별 항공기 출도착 정보를 가져오는 메서드
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		// way = departure / arrival
	    //           출발  /  도착
		// 웹에서 way로 회원이 선택한 값을 받는데 
		String way = request.getParameter("way");
		
		// 값
		String airlineName= request.getParameter("airlineName");
		String airportName= request.getParameter("airportName");
		
		//객체 생성
		FlightVO vo = new FlightVO();
		
		// 구분
		switch (way) {
		case "출발":
			vo.setFli_depport(airportName);
			break;
		case "도착":
			vo.setFli_arrport(airportName);
			break;
		}
		
		vo.setAirline_name(airlineName);
		
		
		// DB에 데이터 가져오기
		List<FlightVO> flightList = service.getScheduleList(vo);
		
		
		Gson gson = new Gson();
		String jsonData = gson.toJson(flightList);
		response.setContentType("application/json;charset=utf-8");
		
		// 데이터 담기
		response.getWriter().write(jsonData);
		response.flushBuffer();
		
	}
}
