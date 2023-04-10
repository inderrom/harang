package kr.or.ddit.harang.airline.service;

import java.util.List;

import kr.or.ddit.harang.vo.AirlineVO;

public interface IAirlineService {

	/**
	 * DB에 항공사 정보를 추가하는 메서드
	 * 
	 * @param airlineVo 항공사 정보가 담긴 AirlineVO 객체
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int insertAirline(AirlineVO airlineVo);
	
	/**
	 * DB에 저장된 항공사 정보를 가져오는 메서드
	 * 
	 * @return AirlineVO 객체가 담긴 List 객체
	 */
	public List<AirlineVO> selectAll();
}
