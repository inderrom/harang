package com.harang.blacklist.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.google.gson.Gson;
import com.harang.blacklist.service.BlacklistServiceImpl;
import com.harang.blacklist.service.IBlacklistService;
import com.harang.vo.ReportVO;


@WebServlet("/report.do")
public class ReportController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private IBlacklistService service;
	
	@Override
	public void init() throws ServletException {
		service = BlacklistServiceImpl.getInstance();
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
			getReport(request, response);
			break;
		case "delete":
			deleteReport(request, response);
			break;
		case "report":
			insertReport(request, response);
			break;
		}
	}
	
	// 회원을 신고하는 메서드
	private void insertReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ReportVO reportVo = useBeanUtils(request);
		int result = service.insertReport(reportVo);
		
		response.setContentType("application/json;charset=utf-8");
		Gson gson = new Gson();
		
		String jsonData = "";
		
		if(result > 0) {
			jsonData = gson.toJson("SUCCESS");
		} else {
			jsonData = gson.toJson("FAILED");
		}
			
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}

	// 신고 건을 삭제하는 메서드
	private void deleteReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int repNum = Integer.parseInt(request.getParameter("repNum"));
		int result = service.deleteReport(repNum);
		
		if(result > 0) {
			response.sendRedirect(request.getContextPath() + "/report.do?job=list");
			return;
		}
		
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().print("<script> alert('잠시 후 다시 시도해주세요.'); location.href = '" + request.getContextPath() + "/report.do?job=list'; </script>");
	}
	
	// 신고 목록을 가져오는 메서드
	private void getReport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		ReportVO reportVo = useBeanUtils(request);
		
		List<ReportVO> reportList = service.getReport(reportVo);
		
		request.setAttribute("reportList", reportList);
		request.getRequestDispatcher("/view/admin/adminReport.jsp").forward(request, response);
	}

	private ReportVO useBeanUtils(HttpServletRequest request) {
		
		// 입력받은 정보를 담을 reportVO 객체
		ReportVO reportVo = new ReportVO();
		
		// 입력받은 정보를 BeanUtils를 이용해 reportVO 객체에 담는다.
		try {
			BeanUtils.populate(reportVo, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reportVo;
	}
}
