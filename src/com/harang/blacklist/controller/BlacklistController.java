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
import com.harang.vo.BlkVO;

@WebServlet("/blacklist.do")
public class BlacklistController extends HttpServlet {
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
		response.setContentType("application/json; charset=utf-8");
		
		String job = request.getParameter("job");
		
		switch(job) {
		case "list":
			getBlklist(request, response);
			break;
		case "insert":
			insertBlklist(request, response);
			break;
		case "update":
			updateBlklist(request, response);
			break;
		case "delete":
			deleteBlklist(request, response);
			break;
		case "insertFromDetail":
			insertBlkFromDetail(request, response);
			break;
		
		}
	}
	
	// 블랙리스트에서 삭제하는 메서드
	private void deleteBlklist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BlkVO blkVo = useBeanUtils(request);
		
		int result = service.deleteBlklist(blkVo);
		
		String jsonData = "";
		Gson gson = new Gson();
		response.setContentType("application/json;charset=utf-8");
		
		if(result > 0) {
			jsonData = gson.toJson("SUCCESS");
		} else {
			jsonData = gson.toJson("FAILED");
		}
		
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}
	
	// 블랙리스트의 정지 기간을 수정하는 메서드
	private void updateBlklist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BlkVO blkVo = useBeanUtils(request);
		int result = service.updateBlklist(blkVo);
		
		String jsonData = "";
		Gson gson = new Gson();
		response.setContentType("application/json;charset=utf-8");
		
		if(result > 0) {
			jsonData = gson.toJson("SUCCESS");
		} else {
			jsonData = gson.toJson("FAILED");
		}
		
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}
	
	
	// 회원 상세에서 회원을 블랙리스트에 추가하는 메서드
	private void insertBlkFromDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BlkVO blkVo = useBeanUtils(request);
		int result = service.insertBlklist(blkVo);
		
		
		String jsonData = "";
		Gson gson = new Gson();
		response.setContentType("application/json;charset=utf-8");
		
		// 블랙 리스트 추가에 성공했을 경우
		if(result > 0) {
			jsonData = gson.toJson("SUCCESS");
		} else {
			jsonData = gson.toJson("SUCCESS");
		}
		
		response.getWriter().write(jsonData);
	}
	
	
	// 회원을 블랙리스트에 추가하는 메서드
	private void insertBlklist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BlkVO blkVo = useBeanUtils(request);
		int repNum = Integer.parseInt(request.getParameter("repNum"));
		int result = service.insertBlklist(blkVo);
		
		// 블랙 리스트 추가에 성공했을 경우
		if(result > 0) {
			service.deleteReport(repNum); // 해당 신고 건은 삭제한다.
		}
		
		response.sendRedirect(request.getContextPath()+"/report.do?job=list");
	}
	
	// 블랙리스트를 가져오는 메서드
	private void getBlklist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		BlkVO blkVo = useBeanUtils(request);
		List<BlkVO> blkList = service.getBlklist(blkVo);
		
		request.setAttribute("blkList", blkList);
		request.getRequestDispatcher("/view/admin/adminBlklist.jsp").forward(request, response);
	}
	
	private BlkVO useBeanUtils(HttpServletRequest request) {
		
		// 입력받은 정보를 담을 BlkVO 객체
		BlkVO blkVo = new BlkVO();
		
		// 입력받은 정보를 BeanUtils를 이용해 BlkVO 객체에 담는다.
		try {
			BeanUtils.populate(blkVo, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("/board.do 서블릿 BeanUtils 에러");
		}
		
		return blkVo;
	}

}
