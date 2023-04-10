package kr.or.ddit.harang.airline.service;

import java.util.List;

import kr.or.ddit.harang.airline.dao.AirlineDAOImpl;
import kr.or.ddit.harang.airline.dao.IAirlineDAO;
import kr.or.ddit.harang.vo.AirlineVO;

public class AirlineServiceImpl implements IAirlineService {
	
	private static AirlineServiceImpl instance;
	private AirlineServiceImpl() {
		dao = AirlineDAOImpl.getInstance();
	}
	
	public static AirlineServiceImpl getInstance() {
		if(instance == null) instance = new AirlineServiceImpl();
		return instance;
	}
	
	
	private IAirlineDAO dao;
	
	@Override
	public int insertAirline(AirlineVO airlineVo) {
		return dao.insertAirline(airlineVo);
	}

	@Override
	public List<AirlineVO> selectAll() {
		return dao.selectAll();
	}

}
