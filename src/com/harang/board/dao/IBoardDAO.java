package com.harang.board.dao;

import java.util.List;
import java.util.Map;

import com.harang.vo.BoardVO;
import com.harang.vo.CommentVO;
import com.harang.vo.FileVO;

public interface IBoardDAO {
	
	/**
	 * 주기적으로 DB의 INDEX를 REBUILD하는 메서드
	 * 
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int updateIndex(List<String> boardTypeList);
	
	/**
	 * DB에서 각 게시판의 게시물 목록을 가져오는 메서드
	 * <br><br>
	 * <b>중요!</b><br>
	 * <b>board_type</b> : 게시판의 종류를 가리키는 BoardVO 객체의 멤버변수
	 * 
	 * @param boardVo 가져올 게시물의 조건이 담긴 BoardVO 객체
	 * @return BoardVO 객체가 담긴 List 객체
	 */
	public List<BoardVO> getBoardList(BoardVO boardVo);
	
	/**
	 * DB에서 각 게시판에 게시물을 추가하고 추가된 게시물의 번호를 가져오는 메서드
	 * 
	 * @param boardVo 추가할 게시물 정보가 담긴 BoardVO 객체
	 * @return 작업 성공 : 추가된 게시물의 번호, 작업 실패 : 0
	 */
	public int insertBoard(BoardVO boardVo);
	
	/**
	 * DB에 저장된 게시물 정보를 수정하는 메서드
	 * 
	 * @param boardVo 수정한 게시물 정보가 담긴 BoardVO 객체
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int updateBoard(BoardVO boardVo);
	
	/**
	 * DB에 저장된 게시물 정보를 삭제하는 메서드
	 * 
	 * @param boardVo 삭제할 게시물 번호와 게시판 종류가 담긴 BoardVO 객체
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int deleteBoard(BoardVO boardVo);
	
	/**
	 * DB에 파일 정보를 추가하는 메서드
	 * <br><br>
	 * <b>중요!</b><br>
	 * <b>board_type</b> : 게시판의 종류를 가리키는 FileVO 객체의 멤버변수<br><br>
	 * 예) 이미지 파일이 작성된 곳이 FREEBOARD일 경우
	 * board_type.substring(0, 1) + "boardfile"; 을 통해 FileVO의 board_type 변수에 들어갈 값을 만들 수 있다.
	 * 
	 * @param fileVo 추가할 파일 정보가 담긴 FileVO 객체
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int insertFile(FileVO fileVo);
	
	/**
	 * 게시물 번호를 입력받아 DB에서 해당 게시물의 정보를 가져오는 메서드
	 * 
	 * @param boardVo 가져올 게시물 번호와 게시판 종류가 담긴 BoardVO 객체
	 * @return 게시물 정보가 담긴 BoardVO 객체
	 */
	public BoardVO getBoardDetail(BoardVO boardVo);
	
	/**
	 * 회원이 게시물을 조회할 때 게시물 조회수를 1 증가시키는 메서드
	 * 
	 * @param boardVo 조회수를 증가시킬 게시물의 번호와 게시판 종류가 담긴 BoardVO 객체
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int updateHit(BoardVO boardVo);
	
	/**
	 * 특정 게시판에 작성된 게시글의 총 개수를 가져오는 메서드
	 * 
	 * @param boardVo 게시판의 종류가 담긴 BoardVO 객체
	 * @return 해당 게시판에 작성된 게시글의 총 개수
	 */
	public int getTotalCount(BoardVO boardVo);
	
	/**
	 * 특정 게시글에 작성된 댓글 목록을 가져오는 메서드
	 * 
	 * @param commtVo 게시판의 종류와 게시글 번호가 담긴 CommentVO 객체
	 * @return CommentVO 객체가 담긴 List 객체
	 */
	public List<CommentVO> getCommtList(CommentVO commtVo);
	
	/**
	 * 특정 게시글에 댓글을 추가하는 메서드
	 * 
	 * @param commtVo 추가할 댓글 정보가 담긴 CommentVO 객체
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int insertCommt(CommentVO commtVo);
	
	/**
	 * 댓글을 수정하는 메서드
	 * 
	 * @param commtVo 수정할 댓글의 정보가 담긴 CommentVO 객체
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int updateCommt(CommentVO commtVo);
	
	/**
	 * 댓글을 삭제하는 메서드
	 * 
	 * @param commtVo 삭제할 댓글의 번호, 댓글이 작성된 게시판 종류가 담긴 CommentVO 객체
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int deleteCommt(CommentVO commtVo);
	
	/**
	 * 특정 회원이 작성한 게시글을 모두 가져오는 메서드
	 * 
	 * @param memId 회원 ID
	 * @return BoardVO 객체가 담긴 List 객체를 저장한 Map 객체<br>각 게시판마다 key값은 free, review, ques 이다.
	 */
	public Map<String, List<BoardVO>> getMemBoardList(String memId);
	
	/**
	 * 특정 회원이 작성한 댓글을 모두 가져오는 메서드
	 * 
	 * @param memId 회원 ID
	 * @return CommentVO 객체가 담긴 List 객체를 저장한 Map 객체<br>각 게시판마다 key값은 free, review 이다.
	 */
	public Map<String, List<CommentVO>> getMemCommtList(String memId);

	/**
	 * 여행 가이드에서 최근 5개의 게시물만 가져오는 메서드
	 * 
	 * @return BoardVO 객체가 담긴 List 객체
	 */
	public List<BoardVO> getRecentGuideboard();
	
	/**
	 * 특정 게시판의 게시물 목록을 모두 가져오는 메서드
	 * 
	 * @param boardType 게시판 종류
	 * @return BoardVO 객체가 담긴 List 객체
	 */
	public List<BoardVO> getBoardAll(String boardType);
	
	/**
	 * 특정 게시판의 댓글 목록을 모두 가져오는 메서드
	 * 
	 * @param commtType 댓글 종류
	 * @return CommentVO 객체가 담긴 List 객체
	 */
	public List<CommentVO> getCommtAll(String commtType);
}
