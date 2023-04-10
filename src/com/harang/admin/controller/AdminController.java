package com.harang.admin.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.harang.board.service.BoardServiceImpl;
import com.harang.board.service.IBoardService;
import com.harang.member.service.IMemberService;
import com.harang.member.service.MemberServiceImpl;
import com.harang.ticket.service.ITicketService;
import com.harang.ticket.service.TicketServiceImpl;
import com.harang.vo.BoardVO;
import com.harang.vo.CommentVO;
import com.harang.vo.MemberVO;
import com.harang.vo.TicketVO;

@WebServlet("/admin.do")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	IMemberService memService;
	ITicketService ticketService;
	IBoardService boardService;
	
	@Override
	public void init() throws ServletException {
		memService = MemberServiceImpl.getInstance();
		ticketService = TicketServiceImpl.getInstance();
		boardService = BoardServiceImpl.getInstance();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String job = request.getParameter("job");
		
		switch(job) {
		case "memInfo":
			getMemInfo(request, response);
			break;
		case "memDelete":
			deleteMember(request, response);
			break;
		case "allBoard":
			getBoardAll(request, response);
			break;
		}
		
	}
	
	// 특정 게시판의 전체 게시글, 댓글 조회
	private void getBoardAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<String> boardTypes = new ArrayList<>();
		boardTypes.add("freeboard");
		boardTypes.add("reviewboard");
		boardTypes.add("quesboard");
		
		// 가져온 boardType이 옳지 못한 타입일 경우
		String boardType = request.getParameter("board_type");
		if(!boardTypes.contains(boardType)) {
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().write("<script> alert('잘못된 접근입니다.'); location.href=history.back(); </script>");
			return;
		}
		
		List<BoardVO> boardList = boardService.getBoardAll(boardType);
		
		String commtType = boardType.substring(0, boardType.indexOf("board")) + "commt";
		
		List<CommentVO> commtList = boardService.getCommtAll(commtType);
		
		request.setAttribute("boardType", boardType);
		request.setAttribute("boardList", boardList);
		request.setAttribute("commtList", commtList);
		request.getRequestDispatcher("/view/admin/adminBoard.jsp").forward(request, response);
	}
	
	// 회원 탈퇴 처리
	private void deleteMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String memId = request.getParameter("memId");
		int result = memService.deleteMember(memId);
		
		if(result > 0) {
			response.sendRedirect(request.getContextPath() + "/member.do?job=list");
			return;
		}
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().print("<script> alert('잠시 후 다시 시도해주세요.'); location.href='" + request.getContextPath() + "/member.do?job=list'; </script>");
	}

	
	// 특정 회원의 회원정보, 예매 / 게시글 / 댓글 목록 조회
	private void getMemInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memId = request.getParameter("memId");
		
		// 회원 정보
		MemberVO memVo = memService.getMemInfo(memId);
		
		// 게시글 정보
		Map<String, List<BoardVO>> boardMap = boardService.getMemBoardList(memId);
		
		List<BoardVO> freeList = boardMap.get("free");     
		List<BoardVO> reviewList = boardMap.get("review");
		List<BoardVO> quesList = boardMap.get("ques");
		
		// 댓글 목록
		Map<String, List<CommentVO>> commtMap = boardService.getMemCommtList(memId);
		
		List<CommentVO> freeCommentList = commtMap.get("free");
		List<CommentVO> reviewCommentList = commtMap.get("review");
		
		// 예매 목록
		TicketVO ticketVo = new TicketVO();
		ticketVo.setMem_id(memId);
		
		List<TicketVO> ticketList = ticketService.getTicketList(ticketVo);
		
		// 넘겨줄 데이터 설정
		request.setAttribute("memVo", memVo);
		
		request.setAttribute("ticketList", ticketList);
		
		request.setAttribute("freeList", freeList);
		request.setAttribute("reviewList", reviewList);
		request.setAttribute("quesList", quesList);
		
		request.setAttribute("freeCommentList", freeCommentList);
		request.setAttribute("reviewCommentList", reviewCommentList);
		
		request.getRequestDispatcher("/view/admin/adminMemDetail.jsp").forward(request, response);
	}
}
