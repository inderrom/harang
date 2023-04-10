package com.harang.facility.dao;

import java.util.List;
import java.util.Map;

import com.harang.vo.AirlineVO;
import com.harang.vo.AirportVO;
import com.harang.vo.FacilityVO;
import com.harang.vo.ParkVO;
import com.harang.vo.RouteVO;
import com.harang.vo.TransportVO;

public interface IFacilityDAO {
	
	/**
	 * DB에 저장된 공항별 시설목록을 가져오는 메서드
	 * 
	 * @param facVo 시설 목록을 가져올 공항과 시설 종류 정보가 담긴 FacilityVO 객체
	 * @return FacilityVO 객체가 담긴 List 객체
	 */
	public List<FacilityVO> getFacList(FacilityVO facVo);
	
	
	/**
	 *  DB에 저장된 항공사목록을 가져오는 메서드  
	 * @return AirlineVO 객체가 담긴 List 객체
	 */

	public List<AirlineVO> getAirlineList();
	
	/**
	 * 	DB에 저장된 공항과 공항이 있는 도시 목록을 가져오는 메서드 
	 * @return AirportVO 객체가 담긴 List 객체
	 */
	public List<AirportVO> getAirportList();
	
	/**
	 * 	공항별 교통 정보(택시,버스,지하철) 가져오는 메서드
	 * @param airportName 공항이름
	 * @return TransportVO 객체가 담긴 List 객체
	 */
	public List<TransportVO> getSelectTransportList(String airportName);
	
	/**
	 * 	공항내 시설정보를 가져오는 메서드
	 * @param airportName 공항이름
	 * @return FacilityVO 객체가 담긴 List 객체
	 */
	public List<FacilityVO> getSelectFacilityList(String airportName);

	/**
	 * 	공항별 시설정보 분류리스트를 가져오는 메서드
	 * @param airportName 공항이름
	 * @return FacilityVO 객체가 담긴 List 객체
	 */
	public List<FacilityVO> getSelectFacilityClassifyList(String airportName);



	/**
	 * 공항의 시설 분류를 선택시 시설 목록을 가져오는 메서드 
	 * @param map ariportName : 공항명, classify : 시설분류(카페,식당 etc)
	 * @return FacilityVO 객체가 담긴 List 객체
	 */
	public List<FacilityVO> getclassifyFile(Map<String, String> map);
	
	/**
	 * 모든 공항 교통 종류,가격 가져오는 메서드
	 * @return RouteVO 객체가 담긴 List 객체
	 */
	public List<RouteVO> getTransportPriceList(String airport_name);
	
	
	/**
	 * 	DB에 저장된 공항별 주차장 사진 및 정보를 찾는 메서드
	 * 
	 * @param AIRPORT_ID로 구분해서 주차장 사진 및 정보를 ParkVO객체에 담음
	 * @return  ParkVO가 담긴 List
	 */
	public List<ParkVO> getParkInfo(String airport_name);
}
