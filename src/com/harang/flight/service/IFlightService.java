package com.harang.flight.service;

import java.util.List;

import com.harang.vo.AirportVO;
import com.harang.vo.FlightVO;

public interface IFlightService {

	/**
	 * DB에 저장된 항공편 정보를 조회하는 메서드
	 * 
	 * @param flightVo 입력받은 flightVo가 담긴 객체
	 * @return FlightVO 객체가 담긴 List 객체
	 */
	public List<FlightVO> getFlightList(FlightVO flightVo);
	
	/**
	 * DB에 저장된 공항 정보를 조회하는 메서드
	 * 
	 * @param airportName 검색할 공항 이름
	 * @return 검색 조건에 일치하는 공항 정보가 저장된 AirportVO 객체를 담은 List 객체 
	 */
	public List<AirportVO> getAirportList(String airportName);
	
	/**
	 * 항공편명을 입력받아 해당 항공편의 정보를 가져오는 메서드
	 * 
	 * @param fliId 정보를 가져올 항공편명
	 * @return 항공편 정보가 담긴 FlightVO
	 */
	public FlightVO getFlight(String fliId);
	
	/**
	 * 도착 공항을 입력받아 항공편을 가격 오름순으로 가져오는 메서드
	 * 
	 * @param airportId 도착 공항 코드
	 * @return FlightVO 객체가 가격 오름순으로 정렬된 List 객체
	 */
	public List<FlightVO> getCheapFlight(String airportId);
}
