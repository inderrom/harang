package com.harang.blacklist.service;

import java.util.List;

import com.harang.blacklist.dao.BlacklistDAOImpl;
import com.harang.blacklist.dao.IBlacklistDAO;
import com.harang.vo.BlkVO;
import com.harang.vo.ReportVO;

public class BlacklistServiceImpl implements IBlacklistService {
	private static BlacklistServiceImpl instance;
	private BlacklistServiceImpl() {
		dao = BlacklistDAOImpl.getInstance();
	}
	public static BlacklistServiceImpl getInstance() {
		if(instance == null) instance = new BlacklistServiceImpl();
		return instance;
	}
	
	
	private IBlacklistDAO dao;
	
	@Override
	public List<BlkVO> getBlklist(BlkVO blkVo) {
		return dao.getBlklist(blkVo);
	}

	@Override
	public int insertBlklist(BlkVO blkVo) {
		return dao.insertBlklist(blkVo);
	}
	@Override
	public int updateBlklist(BlkVO blkVo) {
		return dao.updateBlklist(blkVo);
	}
	@Override
	public int deleteBlklist(BlkVO blkVo) {
		return dao.deleteBlklist(blkVo);
	}
	@Override
	public List<ReportVO> getReport(ReportVO reportVo) {
		return dao.getReport(reportVo);
	}
	@Override
	public int deleteReport(int repNum) {
		return dao.deleteReport(repNum);
	}
	@Override
	public int insertReport(ReportVO reportVo) {
		return dao.insertReport(reportVo);
	}
	
	@Override
	public int checkBlkList() {
		return dao.checkBlkList();
	}
}
