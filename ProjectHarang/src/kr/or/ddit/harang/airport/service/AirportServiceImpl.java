package kr.or.ddit.harang.airport.service;

import java.util.List;

import kr.or.ddit.harang.airport.dao.AirportDAOImpl;
import kr.or.ddit.harang.airport.dao.IAirportDAO;
import kr.or.ddit.harang.vo.AirportVO;

public class AirportServiceImpl implements IAirportService {
	
	private static AirportServiceImpl instance;
	private AirportServiceImpl() {
		dao = AirportDAOImpl.getInstance();
	}
	
	public static AirportServiceImpl getInstance() {
		if(instance == null) instance = new AirportServiceImpl();
		return instance;
	}
	
	
	private IAirportDAO dao;

	@Override
	public List<AirportVO> selectAll() {
		return dao.selectAll();
	}

}
