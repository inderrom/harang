package kr.or.ddit.harang.flight.service;

import kr.or.ddit.harang.flight.dao.FlightDAOImpl;
import kr.or.ddit.harang.flight.dao.IFlightDAO;
import kr.or.ddit.harang.vo.FlightVO;

public class FlightServiceImpl implements IFlightService {
	
	private static FlightServiceImpl instance;
	private FlightServiceImpl() {
		dao = FlightDAOImpl.getInstance();
	}
	
	public static FlightServiceImpl getInstance() {
		if(instance == null) instance = new FlightServiceImpl();
		return instance;
	}

	
	private IFlightDAO dao;
	
	@Override
	public int insertFlight(FlightVO flightVo) {
		return dao.insertFlight(flightVo);
	}

}
