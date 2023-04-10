package com.harang.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.google.gson.Gson;
import com.harang.board.service.BoardServiceImpl;
import com.harang.board.service.IBoardService;
import com.harang.vo.CommentVO;

@WebServlet("/comment.do")
public class CommentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private IBoardService service;
	
	@Override
	public void init() throws ServletException {
		service = BoardServiceImpl.getInstance();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String job = request.getParameter("job");
		
		switch(job) {
		case "insert":
			insertCommt(request, response);
			break;
		case "update":
			updateCommt(request, response);
			break;
		case "delete":
			deleteCommt(request, response);
			break;
		}
	}
	
	// 댓글 삭제
	private void deleteCommt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		CommentVO commtVo = useBeanUtils(request);
		int result = service.deleteCommt(commtVo);
		
		sendResultJSON(response, result);
	}
	
	// 댓글 수정
	private void updateCommt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		CommentVO commtVo = useBeanUtils(request);
		int result = service.updateCommt(commtVo);
		
		sendResultJSON(response, result);
	}
	
	// 댓글 등록
	private void insertCommt(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		CommentVO commtVo = useBeanUtils(request);
		int result = service.insertCommt(commtVo);
		
		sendResultJSON(response, result);
	}
	
	
	// 작업 결과에 따라 SUCCESS 또는 FAILED 메시지를 JSON 타입으로 응답하는 메서드
	private void sendResultJSON(HttpServletResponse response, int result) throws ServletException, IOException {
		
		// result가 1일 경우 성공
		String resultMsg = result == 1 ? "SUCCESS" : "FAILED";
		
		Gson gson = new Gson();
		String jsonData = gson.toJson(resultMsg);
		
		// JSON 타입으로 결과를 응답
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}
	
	// 입력받은 정보를 CommentVO 객체에 담아주는 메서드
	private CommentVO useBeanUtils(HttpServletRequest request) {
		
		// 입력받은 정보를 담을 CommentVO 객체
		CommentVO commtVo = new CommentVO();
		
		// 입력받은 정보를 BeanUtils를 이용해 CommentVO 객체에 담는다.
		try {
			BeanUtils.populate(commtVo, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("/comment.do 서블릿 BeanUtils 에러");
		}
		
		return commtVo;
	}
	
}
