package com.harang.blacklist.service;

import java.util.List;

import com.harang.vo.BlkVO;
import com.harang.vo.ReportVO;

public interface IBlacklistService {

	/**
	 * DB에 저장된 회원 블랙리스트 목록을 가져오는 메서드
	 * 
	 * @param 
	 * @return BlkVo 객체가 담긴 List 객체
	 */
	public List<BlkVO> getBlklist(BlkVO blkVo);
	
	/**
	 * DB에서 블랙리스트 회원을 추가하는 메서드
	 * 
	 * @param blkVo
	 * @return
	 */
	public int insertBlklist(BlkVO blkVo);
	
	/**
	 * DB에 저장된 블랙리스트 회원 정보를 수정하는 메서드
	 *
	 * @param blkVo 수정한 블랙리스트 회원 정보가 담긴 BlkVO 객
	 * @return 작업 성공 : 1, 작업 실패 :0
	 */
	public int updateBlklist(BlkVO blkVo);
	
	/**
	 * DB에 저장된 블랙리스트 회원 정보를 삭제하는 메서드
	 * 
	 * @param blkVo 삭제할 블랙리스트 회원 정보가 담긴 BlkVO 객체
	 * @return 작업 성공 : 1, 작업 실패 0
	 */
	public int deleteBlklist(BlkVO blkVo);
	
	/**
	 * DB에 저장된 신고 회원 목록을 가져오는 메서드
	 * 
	 * @param reportVo 
	 * @return ReportVO 객체가 담긴 List 객체
	 */
	public List<ReportVO> getReport(ReportVO reportVo);

	/**
	 * 신고 내역을 삭제하는 메서드
	 * 
	 * @param repNum 삭제할 신고 내역의 신고 번호
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int deleteReport (int repNum);

	/**
	 * 회원을 신고하는 메서드
	 * 
	 * @param reportVo 신고 대상 회원 ID와 신고 내용이 담긴 ReportVO 객체
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int insertReport (ReportVO reportVo);
	
	/**
	 * DB에 등록된 블랙리스트의 정지기간을 정기적으로 확인하고 감소시키는 메서드
	 * 
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int checkBlkList();
}
