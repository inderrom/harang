package com.harang.tour.service;

import java.util.List;

import com.harang.tour.dao.TourDAOImpl;
import com.harang.vo.TourVO;

public class TourServiceImpl implements ITourService {
	private TourDAOImpl dao;
	
	private static TourServiceImpl service;
	
	private TourServiceImpl() {
		dao= TourDAOImpl.getInstance();
	}
	
	public static TourServiceImpl getInstance() {
		if(service==null) service= new TourServiceImpl();
		
		return service;
	}
	@Override
	public int insertTourRecomm(TourVO tourVo) {
		return dao.insertTourRecomm(tourVo);
	}

	@Override
	public List<TourVO> getTourList() {
		return dao.getTourList();
	}
	
	@Override
	public TourVO getTour(int tour_num) {
		return dao.getTour(tour_num);
	}

	public int deleteTour(int tour_num) {
		return dao.deleteTour(tour_num);
	}

	@Override
	public int updateTour(TourVO tourVo) {
		return dao.updateTour(tourVo);
	}

	

}
