package com.harang.flight.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.harang.util.SqlMapClientFactory;
import com.harang.vo.AirportVO;
import com.harang.vo.FlightVO;
import com.ibatis.sqlmap.client.SqlMapClient;

public class FlightDAOImpl implements IFlightDAO {
	private static FlightDAOImpl instance;
	private FlightDAOImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static FlightDAOImpl getInstance() {
		if(instance == null) instance = new FlightDAOImpl();
		return instance;
	}
	
	private SqlMapClient smc;
	
	// 항공편 조회 메서드
	@Override
	public List<FlightVO> getFlightList(FlightVO flightVo) {
		
		List<FlightVO> fliList = new ArrayList<>();
		
		try {
			List<?> tempList = smc.queryForList("flight.getFlightList", flightVo);
			for(Object obj : tempList) {
				if(obj instanceof FlightVO) {
					fliList.add((FlightVO) obj);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getFlightList() 메서드 에러");
		}
		
		return fliList;
	}
	
	@Override
	public List<AirportVO> getAirportList(String airportName) {
		
		List<AirportVO> airportList = new ArrayList<>();
		
		try {
			
			List<?> tempList = smc.queryForList("flight.getAirportList", airportName);
			for(Object obj : tempList) {
				if(obj instanceof AirportVO) {
					airportList.add((AirportVO) obj);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getAirportList() 메서드 에러");
		}
		
		return airportList;
	}
	
	@Override
	public FlightVO getFlight(String fliId) {
		
		FlightVO flightVo = null;
		
		try {
			
			flightVo = (FlightVO) smc.queryForObject("flight.getFlight", fliId);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getFlight() 메서드 에러");
		}
		
		return flightVo;
	}
	
	// 주어진 공항에 도착하는 항공편을 가격 오름차순으로 정렬해 반환하는 메서드
	@Override
	public List<FlightVO> getCheapFlight(String airportId) {
		
		List<FlightVO> flightList = new ArrayList<>();
		
		try {
			
			List<?> tempList = smc.queryForList("flight.getCheapFlight", airportId);
			for(Object obj : tempList) {
				if(obj instanceof FlightVO) {
					flightList.add((FlightVO) obj);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getCheapFlight() 메서드 에러");
		}
		
		return flightList;
	}
}
