package com.harang.flight.service;

import java.util.List;

import com.harang.flight.dao.FlightDAOImpl;
import com.harang.flight.dao.IFlightDAO;
import com.harang.vo.AirportVO;
import com.harang.vo.FlightVO;

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
	public List<FlightVO> getFlightList(FlightVO flightVo) {
		return dao.getFlightList(flightVo);
	}
	
	@Override
	public List<AirportVO> getAirportList(String airportName) {
		return dao.getAirportList(airportName);
	}
	
	@Override
	public FlightVO getFlight(String fliId) {
		return dao.getFlight(fliId);
	}
	
	@Override
	public List<FlightVO> getCheapFlight(String airportId) {
		return dao.getCheapFlight(airportId);
	}
}
