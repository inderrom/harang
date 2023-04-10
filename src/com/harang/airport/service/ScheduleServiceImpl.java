package com.harang.airport.service;

import java.util.List;

import com.harang.airport.dao.ScheduleDAOImpl;
import com.harang.vo.FlightVO;

public class ScheduleServiceImpl implements IScheduleService {


	private static ScheduleServiceImpl instance;
	private ScheduleServiceImpl() {
		dao = ScheduleDAOImpl.getInstance();
	}

	public static ScheduleServiceImpl getInstance() {
		if (instance == null) instance = new ScheduleServiceImpl();

		return instance;
	}

	
	private ScheduleDAOImpl dao;
	
	@Override
	public List<FlightVO> getScheduleList(FlightVO vo) {
		return dao.getScheduleList(vo);
	}

}
