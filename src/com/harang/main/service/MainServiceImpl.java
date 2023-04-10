package com.harang.main.service;

import java.util.List;

import com.harang.main.dao.IMainDAO;
import com.harang.main.dao.MainDAOImpl;
import com.harang.vo.AirportVO;

public class MainServiceImpl implements IMainService {
	
	private static MainServiceImpl instance;
	private MainServiceImpl() {
		dao = MainDAOImpl.getInstance();
	}
	
	public static MainServiceImpl getInstance() {
		if(instance == null) instance = new MainServiceImpl();
		return instance;
	}
	
	
	private IMainDAO dao;
	
	@Override
	public List<AirportVO> getAirportList(String airportName) {
		return dao.getAirportList(airportName);
	}

}
