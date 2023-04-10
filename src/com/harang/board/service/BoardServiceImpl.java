package com.harang.board.service;

import java.util.List;
import java.util.Map;

import com.harang.board.dao.BoardDAOImpl;
import com.harang.board.dao.IBoardDAO;
import com.harang.vo.BoardVO;
import com.harang.vo.CommentVO;
import com.harang.vo.FileVO;
import com.harang.vo.PageVO;

public class BoardServiceImpl implements IBoardService {
	
	private static BoardServiceImpl instance;
	private BoardServiceImpl() {
		
		dao = BoardDAOImpl.getInstance();
		
	}
	
	public static BoardServiceImpl getInstance() {
		if(instance == null) instance = new BoardServiceImpl();
		return instance;
	}
	
	
	private IBoardDAO dao;
	
	@Override
	public List<BoardVO> getBoardList(BoardVO boardVo) {
		return dao.getBoardList(boardVo);
	}

	@Override
	public int insertBoard(BoardVO boardVo) {
		return dao.insertBoard(boardVo);
	}

	@Override
	public int updateBoard(BoardVO boardVo) {
		return dao.updateBoard(boardVo);
	}

	@Override
	public int deleteBoard(BoardVO boardVo) {
		return dao.deleteBoard(boardVo);
	}
	
	@Override
	public int insertFile(FileVO fileVo) {
		return dao.insertFile(fileVo);
	}
	
	@Override
	public BoardVO getBoardDetail(BoardVO boardVo) {
		return dao.getBoardDetail(boardVo);
	}
	
	@Override
	public int updateHit(BoardVO boardVo) {
		return dao.updateHit(boardVo);
	}
	
	@Override
	public int getTotalCount(BoardVO boardVo) {
		return dao.getTotalCount(boardVo);
	}
	
	@Override
	public PageVO getPageInfo(BoardVO boardVo, int page) {
		
		int count = getTotalCount(boardVo);
		
		
		int start = (page - 1) * PageVO.getPerList() + 1;
		int end = start + PageVO.getPerList() - 1;
		if(end > count) end = count;
		
		int totalPage = (int) Math.ceil((double) count / PageVO.getPerList());
		
		int startPage = ((page - 1) / PageVO.getPerPage() * PageVO.getPerPage()) + 1;
		int endPage = startPage + PageVO.getPerPage() - 1;
		if(endPage > totalPage) endPage = totalPage;
		
		PageVO pageVo = new PageVO();
		
		pageVo.setCount(count);
		pageVo.setStart(start);
		pageVo.setEnd(end);
		pageVo.setTotalPage(totalPage);
		pageVo.setStartPage(startPage);
		pageVo.setEndPage(endPage);
		
		return pageVo;
	}
	
	@Override
	public List<CommentVO> getCommtList(CommentVO commtVo) {
		return dao.getCommtList(commtVo);
	}
	
	@Override
	public int insertCommt(CommentVO commtVo) {
		return dao.insertCommt(commtVo);
	}
	
	@Override
	public int updateCommt(CommentVO commtVo) {
		return dao.updateCommt(commtVo);
	}
	
	@Override
	public int deleteCommt(CommentVO commtVo) {
		return dao.deleteCommt(commtVo);
	}
	
	@Override
	public Map<String, List<BoardVO>> getMemBoardList(String memId) {
		return dao.getMemBoardList(memId);
	}
	
	@Override
	public Map<String, List<CommentVO>> getMemCommtList(String memId) {
		return dao.getMemCommtList(memId);
	}
	
	@Override
	public List<BoardVO> getRecentGuideboard() {
		return dao.getRecentGuideboard();
	}
	
	@Override
	public List<BoardVO> getBoardAll(String boardType) {
		return dao.getBoardAll(boardType);
	}
	
	@Override
	public List<CommentVO> getCommtAll(String commtType) {
		return dao.getCommtAll(commtType);
	}
}
