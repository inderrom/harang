package com.harang.main.service;

import java.util.List;

import com.harang.vo.AirportVO;

public interface IMainService {
	
	/**
	 * 검색창에 입력받은 문자열과 비슷한 이름을 가지고 있는 공항의 정보를 DB에서 찾아 반환하는 메서드
	 * 
	 * @param airportName airportName 검색창에 입력받은 문자열
	 * @return AirportVO 객체가 담긴 List 객체
	 */
	public List<AirportVO> getAirportList(String airportName);
}
