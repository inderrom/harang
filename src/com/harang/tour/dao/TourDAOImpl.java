package com.harang.tour.dao;

import java.util.ArrayList;
import java.util.List;

import com.harang.util.SqlMapClientFactory;
import com.harang.vo.TourVO;
import com.ibatis.sqlmap.client.SqlMapClient;

public class TourDAOImpl implements ITourDAO {
	private SqlMapClient client;
	
	private static TourDAOImpl dao;
	private TourDAOImpl() {
		client = SqlMapClientFactory.getSqlMapClient();
	}
	public static TourDAOImpl getInstance() {
		if(dao == null) dao = new TourDAOImpl();
		return dao;
	}
	
	// 여행지 추가
	@Override
	public int insertTourRecomm(TourVO tourVo) {
		int result = 0;
		
		try {
			
			Object obj = client.insert("tour.insertTourRecomm", tourVo);
			if(obj == null) result = 1;
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("insertTourRecomm() 메서드 에러");
		}
		
		return result;
	}
	
	// 여행지 목록 조회
	@Override
	public List<TourVO> getTourList() {
		
		List<TourVO> tourList = new ArrayList<>();
		
		try {
			List<?> tempList = client.queryForList("tour.getTourList");
			for(Object obj : tempList) {
				if(obj instanceof TourVO) {
					tourList.add((TourVO) obj);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getTourList() 메서드 에러");
		}
		
		return tourList;
	}
	
	@Override
	public TourVO getTour(int tour_num) {
		
		TourVO tourVo = null;
		
		try {
			
			tourVo = (TourVO) client.queryForObject("tour.getTour", tour_num);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getTour() 메서드 에러");
		}
		
		return tourVo;
	}
	
	// 여행지 삭제
	@Override
	public int deleteTour(int tour_num) {
		int result = 0;
		
		try {
			
			result = client.delete("tour.deleteTour",tour_num);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("deleteTour() 메서드 에러");
		}
		return result;
	}
	
	// 여행지 업데이트
	@Override
	public int updateTour(TourVO tourVo) {
		int result = 0;
		
		try {
			
			result = client.update("tour.updateTour",tourVo);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("updateTour() 메서드 에러");
		}
		
		return result;
	}
}
