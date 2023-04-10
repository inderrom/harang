package kr.or.ddit.harang.airport.dao;

import java.util.List;

import kr.or.ddit.harang.vo.AirportVO;

public interface IAirportDAO {
	
	/**
	 * DB에 저장된 모든 공항 목록을 불러오는 메서드
	 * 
	 * @return AirportVO 객체가 담긴 List 객체
	 */
	public List<AirportVO> selectAll();
}
