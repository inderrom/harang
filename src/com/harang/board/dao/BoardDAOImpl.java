package com.harang.board.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.harang.util.SqlMapClientFactory;
import com.harang.vo.BoardVO;
import com.harang.vo.CommentVO;
import com.harang.vo.FileVO;
import com.ibatis.sqlmap.client.SqlMapClient;

public class BoardDAOImpl implements IBoardDAO {
	
	private static BoardDAOImpl instance;
	private BoardDAOImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static BoardDAOImpl getInstance() {
		if(instance == null) instance = new BoardDAOImpl();
		return instance;
	}
	
	
	private SqlMapClient smc;
	
	// DB INDEX REBUILD 메서드
	@Override
	public int updateIndex(List<String> boardTypeList) {
		
		int result = 0;
		
		try {
			for(String boardType : boardTypeList) {
				result = smc.update("board.updateIndex", boardType);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("updateIndex() 메서드 에러");
		}
		
		return result;
	}
	
	// 게시물 조회 메서드
	@Override
	public List<BoardVO> getBoardList(BoardVO boardVo) {
		
		List<BoardVO> boardList = new ArrayList<>();
		
		try {
			
			List<?> tempList = smc.queryForList("board.getBoardList", boardVo);
			
			for(Object obj : tempList) {
				if(obj instanceof BoardVO) {
					boardList.add((BoardVO) obj);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getBoardList() 메서드 에러");
		}
		
		return boardList;
	}
	
	// 게시물 추가 메서드
	@Override
	public int insertBoard(BoardVO boardVo) {
		
		int result = 0;
		
		try {
			
			result = (Integer) smc.insert("board.insertBoard", boardVo);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("insertBoard() 메서드 에러");
		}
		
		return result;
	}
	
	// 게시물 수정 메서드
	@Override
	public int updateBoard(BoardVO boardVo) {
		
		int result = 0;
		
		try {
			
			result = smc.update("board.updateBoard", boardVo);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("updateBoard() 메서드 에러");
		}
		
		return result;
	}
	
	// 게시물 삭제 메서드
	@Override
	public int deleteBoard(BoardVO boardVo) {

		int result = 0;
		
		try {
			
			result = smc.delete("board.deleteBoard", boardVo);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("deleteBoard() 메서드 에러");
		}
		
		return result;
	}
	
	
	// 파일 추가 메서드
	@Override
	public int insertFile(FileVO fileVo) {
		
		int result = 0;
		
		try {
			
			Object obj = smc.insert("board.insertFile", fileVo);
			if(obj == null) result = 1;
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("insertFile() 메서드 에러");
		}
		
		return result;
	}
	
	
	// 게시물 상세보기 메서드
	@Override
	public BoardVO getBoardDetail(BoardVO boardVo) {
		
		BoardVO detailBoardVo = new BoardVO();
		
		try {
			
			detailBoardVo = (BoardVO) smc.queryForObject("board.getBoardDetail", boardVo);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getBoardDetail() 메서드 에러");
		}
		
		return detailBoardVo;
	}
	
	// 조회수 증가 메서드
	@Override
	public int updateHit(BoardVO boardVo) {
		
		int result = 0;
		
		try {
			
			result = smc.update("board.updateHit", boardVo);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("updateHit() 메서드 에러");
		}
		
		return result;
	}
	
	// 게시글 총 개수를 가져오는 메서드
	@Override
	public int getTotalCount(BoardVO boardVo) {
		
		int result = 0;
		
		try {
			
			result = (Integer) smc.queryForObject("board.getTotalCount", boardVo);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getTotalCount() 메서드 에러");
		}
		
		return result;
	}
	
	// 댓글 목록을 가져오는 메서드
	@Override
	public List<CommentVO> getCommtList(CommentVO commtVo) {
		
		List<CommentVO> commentList = new ArrayList<>();
		
		try {
			
			List<?> tempList = smc.queryForList("board.getCommtList", commtVo);
			for(Object obj : tempList) {
				if(obj instanceof CommentVO) {
					commentList.add((CommentVO) obj);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getCommtList() 메서드 에러");
		}
		
		return commentList;
	}
	
	// 댓글을 추가하는 메서드
	@Override
	public int insertCommt(CommentVO commtVo) {
		
		int result = 0;
		
		try {
			
			Object obj = smc.insert("board.insertCommt", commtVo);
			if(obj == null) result = 1;
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("insertCommt() 메서드 에러");
		}
		
		return result;
	}
	
	// 댓글을 수정하는 메서드
	@Override
	public int updateCommt(CommentVO commtVo) {
		
		int result = 0;
		
		try {
			
			result = smc.update("board.updateCommt", commtVo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 댓글을 삭제하는 메서드
	@Override
	public int deleteCommt(CommentVO commtVo) {
		
		int result = 0;
		
		try {
			// 댓글 삭제
			result = smc.update("board.deleteCommt", commtVo);
			// 댓글 연쇄 삭제
			result = smc.update("board.deleteCommtCascade", commtVo);
			result *= -1;
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("deleteCommt() 메서드 에러");
		}
		
		return result;
	}
	
	// 특정 회원의 전체 게시글 목록 조회
	@Override
	public Map<String, List<BoardVO>> getMemBoardList(String memId) {
		
		Map<String, List<BoardVO>> boardMap = new HashMap<>();
		List<BoardVO> freeboardList = new ArrayList<>();
		List<BoardVO> reviewboardList = new ArrayList<>();
		List<BoardVO> quesboardList = new ArrayList<>();
		
		try {
			
			List<?> tempFreeList = smc.queryForList("board.getMemFreeBoardList", memId);
			for(Object obj : tempFreeList) {
				if (obj instanceof BoardVO) {
					freeboardList.add((BoardVO) obj);
				}
			}
			List<?> tempReviewList = smc.queryForList("board.getMemReviewBoardList", memId);
			for(Object obj : tempReviewList) {
				if (obj instanceof BoardVO) {
					reviewboardList.add((BoardVO) obj);
				}
			}
			List<?> tempQuesList = smc.queryForList("board.getMemQuesBoardList", memId);
			for(Object obj : tempQuesList) {
				if (obj instanceof BoardVO) {
					quesboardList.add((BoardVO) obj);
				}
			}
			
			boardMap.put("free", freeboardList);
			boardMap.put("review", reviewboardList);
			boardMap.put("ques", quesboardList);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getMemBoardList() 메서드 에러");
		}
		
		return boardMap;
	}
	
	// 특정 회원의 전체 댓글 목록 조회
	@Override
	public Map<String, List<CommentVO>> getMemCommtList(String memId) {

		Map<String, List<CommentVO>> commtMap = new HashMap<>();
		List<CommentVO> freecommtList = new ArrayList<>();
		List<CommentVO> reviewcommtList = new ArrayList<>();
		
		try {
			
			List<?> tempFreeList = smc.queryForList("board.getMemFreeCommtList", memId);
			for(Object obj : tempFreeList) {
				if (obj instanceof CommentVO) {
					freecommtList.add((CommentVO) obj);
				}
			}
			List<?> tempReviewList = smc.queryForList("board.getMemReviewCommtList", memId);
			for(Object obj : tempReviewList) {
				if (obj instanceof CommentVO) {
					reviewcommtList.add((CommentVO) obj);
				}
			}
			
			commtMap.put("free", freecommtList);
			commtMap.put("review", reviewcommtList);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getMemCommtList() 메서드 에러");
		}
		
		return commtMap;
	}
	
	// 여행 가이드 게시물 중 최근 5개만 조회 (게시판 대문용도)
	@Override
	public List<BoardVO> getRecentGuideboard() {
		
		List<BoardVO> boardList = new ArrayList<>();
		
		try {
			List<?> tempList = smc.queryForList("board.getRecentGuideboard");
			for(Object obj : tempList) {
				if(obj instanceof BoardVO) {
					boardList.add((BoardVO) obj);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getRecentGuideboard() 메서드 에러");
		}
		
		return boardList;
	}
	
	
	// 특정 게시판의 전체 게시물 조회
	@Override
	public List<BoardVO> getBoardAll(String boardType) {
		
		List<BoardVO> boardList = new ArrayList<>();
		
		try {
			List<?> tempList = smc.queryForList("board.getBoardAll", boardType);
			for(Object obj : tempList) {
				if(obj instanceof BoardVO) {
					boardList.add((BoardVO) obj);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getBoardAll() 메서드 에러");
		}
		
		return boardList;
	}
	
	// 특정 게시판의 전체 댓글 조회
	@Override
	public List<CommentVO> getCommtAll(String commtType) {

		List<CommentVO> commtList = new ArrayList<>();
		
		try {
			List<?> tempList = smc.queryForList("board.getCommtAll", commtType);
			for(Object obj : tempList) {
				if(obj instanceof CommentVO) {
					commtList.add((CommentVO) obj);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getCommtAll() 메서드 에러");
		}
		
		return commtList;
	}
}
