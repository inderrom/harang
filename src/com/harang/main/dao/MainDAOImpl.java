package com.harang.main.dao;

import java.util.ArrayList;
import java.util.List;

import com.harang.util.SqlMapClientFactory;
import com.harang.vo.AirportVO;
import com.ibatis.sqlmap.client.SqlMapClient;

public class MainDAOImpl implements IMainDAO {
	
	private static MainDAOImpl instance;
	private MainDAOImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static MainDAOImpl getInstance() {
		if(instance == null) instance = new MainDAOImpl();
		return instance;
	}

	// ibatis 작업을 위한 SqlMapClient 객체
	private SqlMapClient smc;
	
	// 연관 공항명 메서드
	@Override
	public List<AirportVO> getAirportList(String airportName) {
		
		List<AirportVO> airportList = new ArrayList<>();
		
		try {
			
			// 입력한 문자열과 비슷한 이름을 가진 공항 정보를 가져온다.
			List<?> tempList = smc.queryForList("main.getAirportList", airportName);
			for(Object obj : tempList) {
				if(obj instanceof AirportVO) {
					airportList.add((AirportVO) obj);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getAirportList() 메서드 에러");
		}
		
		return airportList;
	}


}
