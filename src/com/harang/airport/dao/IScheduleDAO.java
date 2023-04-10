package com.harang.airport.dao;

import java.util.List;

import com.harang.vo.FlightVO;

public interface IScheduleDAO {
	
	/**
	 * 출발/ 도착 선택에 따라 선택한 시간 이후에 모든 항공 스케줄을 받는 메서드 
	 * 출발/ 도착 선택은 필수이고 항공사는 선택할 수 있다.
	 * 
	 * @param vo departure(출발) vo.setFli_depport(공항명) arrival(도착)
	 *           vo.setFli_arrport(공항명) AIRLINE_NAME(항공사) 선택 사항
	 * @return 조회 성공 : List<FlightVO> 출력 / 없거나 실패시 : null
	 */
	public List<FlightVO> getScheduleList(FlightVO vo);
}
