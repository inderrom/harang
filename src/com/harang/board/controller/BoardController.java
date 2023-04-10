package com.harang.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.harang.board.service.BoardServiceImpl;
import com.harang.board.service.IBoardService;
import com.harang.vo.BoardVO;
import com.harang.vo.CommentVO;
import com.harang.vo.PageVO;

@WebServlet("/board.do")
public class BoardController extends HttpServlet {
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
		case "list":
			getBoardList(request, response);
			break;
		case "insert":
			insertBoard(request, response);
			break;
		case "update":
			updateBoard(request, response);
			break;
		case "delete":
			deleteBoard(request, response);
			break;
		case "detail":
			detailBoard(request, response);
			break;
		case "form":
			formBoard(request, response);
			break;
		}
	}
	
	// 게시물 수정하기를 눌렀을 때 수정 폼으로 이동시키는 메서드
	private void formBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BoardVO boardVo = useBeanUtils(request);
		BoardVO detailBoardVo = service.getBoardDetail(boardVo);
		
		request.setAttribute("boardVo", detailBoardVo);
		request.getRequestDispatcher("/view/board/insertboard.jsp").forward(request, response);
	}
	
	
	// 게시물을 선택했을 때 게시물 상세보기를 처리하는 메서드
	private void detailBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BoardVO boardVo = useBeanUtils(request);
		BoardVO detailBoardVo = service.getBoardDetail(boardVo);
		
		// 해당하는 게시글이 없을 경우
		if(detailBoardVo == null) {
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().print("<script> alert('삭제된 게시글입니다.'); location.href = history.back(); </script>");
			return;
		}
		
		detailBoardVo.setBoard_type(boardVo.getBoard_type());
		
		// 쿠키 조회
		Cookie[] cookies = request.getCookies();
		Cookie historyCookie = null;
		
		String board_id = String.valueOf(detailBoardVo.getBoard_id());
		String board_type = boardVo.getBoard_type();
		
		// 쿠키가 하나라도 있을 경우
		if(cookies != null) {
			
			for(Cookie cookie : cookies) {
				// 쿠키 목록 중 해당 게시글을 조회한 쿠키가 있는지 확인
				if(cookie.getName().equals(board_type + "_" + board_id)) {
					historyCookie = cookie;
				}
			}
		}
		
		// 해당 게시글을 조회한 쿠키가 없을 경우
		if(historyCookie == null) {
			
			// 조회수 중복 증가 방지용 쿠키 생성
			// 게시판종류_게시글번호
			Cookie viewCookie = new Cookie(board_type + "_" + board_id, board_type + "_" + board_id);
			viewCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(viewCookie);
			
			// 조회수 증가 처리
			service.updateHit(boardVo);
		}
		List<CommentVO> commtList = null;
		
		if(!board_type.equals("noticeboard") && !board_type.equals("guideboard")) {
			String commtType = board_type.substring(0, board_type.indexOf("board")) + "commt";
			
			CommentVO commtVo = new CommentVO();
			commtVo.setBoard_id(detailBoardVo.getBoard_id());
			commtVo.setCommt_type(commtType);
			
			// 댓글 목록 가져오기
			commtList = service.getCommtList(commtVo);
		}
		
		request.setAttribute("boardVo", detailBoardVo);
		request.setAttribute("commtList", commtList);
		request.getRequestDispatcher("/view/board/detailBoard.jsp").forward(request, response);
	}
	
	
	// 게시물 추가, 수정, 삭제 후 redirect 처리를 담당하는 메서드
	private void redirectToPage(HttpServletRequest request, HttpServletResponse response, int result) throws ServletException, IOException {
		
		if(result == 0) {
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().print("<script>alert(\'잠시 후 다시 시도해주세요.\');location.href=\'"
										+ request.getContextPath() + "/board.do?job=list&board_type=freeboard\'</script>");
		} else {
			response.sendRedirect(request.getContextPath() + "/board.do?job=list&board_type=" + request.getParameter("board_type") + "&page=1");
		}
	}
	
	
	// 게시물 삭제 메서드
	private void deleteBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BoardVO boardVo = useBeanUtils(request);
		
		int result = service.deleteBoard(boardVo);
		
		redirectToPage(request, response, result);
	}
	
	
	// 게시물 수정 메서드
	private void updateBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BoardVO boardVo = useBeanUtils(request);
		
		int result = service.updateBoard(boardVo);
		
		redirectToPage(request, response, result);
	}
	
	
	// 게시물 추가 메서드
	private void insertBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BoardVO boardVo = useBeanUtils(request);
		
		int result = service.insertBoard(boardVo);
		
		redirectToPage(request, response, result);
	}
	
	
	// 게시물 조회 메서드
	private void getBoardList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String pageStr = request.getParameter("page");
		
		// 페이지 초기값 : 1
		int page = 1;
		
		// 지정된 페이지가 있을 경우 해당 페이지의 값을 가져온다.
		if(pageStr != null) page = Integer.parseInt(pageStr);
		
		
		BoardVO boardVo = useBeanUtils(request);
		PageVO pageVo = service.getPageInfo(boardVo, page);
		
		boardVo.setStart(pageVo.getStart());
		boardVo.setEnd(pageVo.getEnd());
		
		List<BoardVO> boardList = service.getBoardList(boardVo);
		
		// 만약 불러오는 게시판이 여행 가이드일 경우 최신 5개 게시물도 함께 보낸다. (게시판 대문용)
		if(boardVo.getBoard_type().equals("guideboard")) {
			List<BoardVO> guideList = service.getRecentGuideboard();
			request.setAttribute("guideList", guideList);
		}
		
		request.setAttribute("pageVo", pageVo);
		request.setAttribute("boardList", boardList);
		request.getRequestDispatcher("/view/board/" + boardVo.getBoard_type() + ".jsp").forward(request, response);
	}
	
	
	// 입력받은 정보를 BoardVO 객체에 담아주는 메서드
	private BoardVO useBeanUtils(HttpServletRequest request) {
		
		// 입력받은 정보를 담을 BoardVO 객체
		BoardVO boardVo = new BoardVO();
		
		// 입력받은 정보를 BeanUtils를 이용해 BoardVO 객체에 담는다.
		try {
			BeanUtils.populate(boardVo, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
//				_DebugHarang.logger.error("/board.do 서블릿 BeanUtils 에러");
		}
		
		return boardVo;
	}
}
