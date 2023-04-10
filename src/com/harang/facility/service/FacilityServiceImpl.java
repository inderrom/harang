package com.harang.facility.service;

import java.util.List;
import java.util.Map;

import com.harang.facility.dao.FacilityDAOImpl;
import com.harang.facility.dao.IFacilityDAO;
import com.harang.vo.AirlineVO;
import com.harang.vo.AirportVO;
import com.harang.vo.FacilityVO;
import com.harang.vo.ParkVO;
import com.harang.vo.RouteVO;
import com.harang.vo.TransportVO;

public class FacilityServiceImpl implements IFacilityService {
	
	private static FacilityServiceImpl instance;
	private FacilityServiceImpl() {
		dao = FacilityDAOImpl.getInstance();
	}
	
	public static FacilityServiceImpl getInstance() {
		if(instance == null) instance = new FacilityServiceImpl();
		return instance;
	}
	
	
	private IFacilityDAO dao;
	
	@Override
	public List<FacilityVO> getFacList(FacilityVO facVo) {
		return dao.getFacList(facVo);
	}

	@Override
	public List<AirlineVO> getAirlineList() {
		return dao.getAirlineList();
	}

	@Override
	public List<AirportVO> getAirportList() {
		return dao.getAirportList();
	}

	@Override
	public List<TransportVO> getSelectTransportList(String airportName) {
		return dao.getSelectTransportList(airportName);
	}

	@Override
	public List<FacilityVO> getSelectFacilityList(String airportName) {
		return dao.getSelectFacilityList(airportName);
	}

	public List<FacilityVO> getSelectFacilityClassifyList(String airportName) {
		return dao.getSelectFacilityClassifyList(airportName);
	}

	public List<FacilityVO> getclassifyFile(Map<String, String> map) { 
		return dao.getclassifyFile(map);
	}

	@Override
	public List<RouteVO> getTransportPriceList(String airport_name) {
		return dao.getTransportPriceList(airport_name);
	}

	@Override
	public List<ParkVO> getParkInfo(String airport_name) {
		return dao.getParkInfo(airport_name);
	}




}
