package com.harang.airport.dao;

import java.util.ArrayList;
import java.util.List;

import com.harang.util.SqlMapClientFactory;
import com.harang.vo.FlightVO;
import com.ibatis.sqlmap.client.SqlMapClient;

public class ScheduleDAOImpl implements IScheduleDAO {

	private SqlMapClient smc;

	// 싱글톤 생성
	private static ScheduleDAOImpl instance;
	private ScheduleDAOImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}

	public static ScheduleDAOImpl getInstance() {
		if (instance == null) instance = new ScheduleDAOImpl();
		return instance;
	}

	// 출발/도착 스케줄 리스트
	@Override
	public List<FlightVO> getScheduleList(FlightVO vo) {

		List<FlightVO> flightList = new ArrayList<>();

		try {

			// DB에 SELECT한 FlightVO객체들을 List에 저장
			List<?> tempList = smc.queryForList("fac.getScheduleList", vo);
			for(Object obj : tempList) {
				if(obj instanceof FlightVO) {
					flightList.add((FlightVO) obj);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("SelectScheduleFligh() 메서드 에러");
		}

		return flightList;
	}

}
