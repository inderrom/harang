package com.harang.blacklist.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.harang.util.SqlMapClientFactory;
import com.harang.vo.BlkVO;
import com.harang.vo.ReportVO;
import com.ibatis.sqlmap.client.SqlMapClient;

public class BlacklistDAOImpl implements IBlacklistDAO {
	private static BlacklistDAOImpl instance;
	private BlacklistDAOImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static BlacklistDAOImpl getInstance(){
		if(instance == null) instance = new BlacklistDAOImpl();
		return instance;
	}
	
	
	private SqlMapClient smc;
	// 블랙리스트 회원 조회 메서드
	@Override
	public List<BlkVO> getBlklist(BlkVO blkVo) {
		
		List<BlkVO> blkList = new ArrayList<>();
		
	try {
			
			List<?> tempList = smc.queryForList("blk.getBlklist", blkVo);
			for(Object obj : tempList) {
				if(obj instanceof BlkVO) {
					blkList.add((BlkVO) obj);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getBlkList() 메서드 에러");
		}
		
		return blkList;
	}
	
	// 블랙리스트 회원 추가 메서드
	@Override
	public int insertBlklist(BlkVO blkVo) {
		
		int result = 0;
		
		try {
			
			Object obj = smc.insert("blk.insertBlklist", blkVo);
			if(obj == null) result = 1;
			
		} catch (SQLException e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("insertBlklist() 메서드 에러");
		}
		
		return result;
	}
	// 블랙리스트 회원 수정 메서드
	@Override
	public int updateBlklist(BlkVO blkVo) {
		
		int result = 0;
		
		try {
			
			result = smc.update("blk.updateBlklist", blkVo);
			
		} catch (SQLException e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("updateBlklist() 메서드 에러");
		}
		
		return result;
	}
	
	// 블랙리스트 회원 삭제 메서드
	@Override
	public int deleteBlklist(BlkVO blkVo) {
		
		int result = 0;
		
		try {
			
			result = smc.delete("blk.deleteBlklist", blkVo);
			
		} catch (SQLException e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("deleteBlklist() 메서드 에러");
		}
		
		return result;
	}
	
	// 신고 회원 목록 조회 메서드
	@Override
	public List<ReportVO> getReport(ReportVO reportVo) {
		
		List<ReportVO> reportList = new ArrayList<>();
		
		try {
			List<?> tempList = smc.queryForList("blk.getReport", reportVo);
			for(Object obj : tempList) {
				if(obj instanceof ReportVO) {
					reportList.add((ReportVO) obj);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getReport() 메서드 에러");
		}
		
		return reportList;
	}
	
	// 신고 내역을 삭제
	@Override
	public int deleteReport(int repNum) {
		
		int result = 0;
		
		try {
			
			result = smc.delete("blk.deleteReport", repNum);
			
		} catch (SQLException e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("deleteReport() 메서드 에러");
		}
		
		return result;
	}
	
	// 신고 등록
	@Override
	public int insertReport(ReportVO reportVo) {
		
		int result = 0;
		
		try {
			
			Object obj = smc.insert("blk.insertReport", reportVo);
			if(obj == null) result = 1;
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("insertReport() 메서드 에러");
		}
		
		return result;
	}
	
	// 하루에 한 번씩 블랙리스트 목록을 점검하는 메서드
	@Override
	public int checkBlkList() {
		
		int result = 0;
		
		try {
			
			result = smc.update("blk.checkBlkList");
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("checkBlkList() 메서드 에러");
		}
		
		return result;
	}
}

	
