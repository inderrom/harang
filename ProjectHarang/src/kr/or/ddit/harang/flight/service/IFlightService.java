package kr.or.ddit.harang.flight.service;

import kr.or.ddit.harang.vo.FlightVO;

public interface IFlightService {
	
	/**
	 * DB에 새로운 항공편 정보를 추가하는 메서드
	 * 
	 * @param flightVo 항공편 정보가 담긴 FlightVO 객체
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int insertFlight(FlightVO flightVo);
}
