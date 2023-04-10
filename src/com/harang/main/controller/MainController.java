package com.harang.main.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.harang.main.service.IMainService;
import com.harang.main.service.MainServiceImpl;
import com.harang.vo.AirportVO;


@MultipartConfig
@WebServlet("/main.do")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private IMainService service;
	
	@Override
	public void init() throws ServletException {
		service = MainServiceImpl.getInstance();
	}
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String job = request.getParameter("job");
		
		switch(job) {
		case "airportList":
			getAirportList(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	// 공항 목록 조회
	private void getAirportList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String airportName = request.getParameter("airport_name");
		List<AirportVO> airportVo = service.getAirportList(airportName);
		
		Gson gson = new Gson();
		String jsonData = gson.toJson(airportVo);
		
		response.setContentType("application/json;charset=utf-8");
		
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}

}
