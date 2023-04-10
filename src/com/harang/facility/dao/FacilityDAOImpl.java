package com.harang.facility.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.harang.util.SqlMapClientFactory;
import com.harang.vo.AirlineVO;
import com.harang.vo.AirportVO;
import com.harang.vo.FacilityVO;
import com.harang.vo.ParkVO;
import com.harang.vo.RouteVO;
import com.harang.vo.TransportVO;
import com.ibatis.sqlmap.client.SqlMapClient;

public class FacilityDAOImpl implements IFacilityDAO {
	
	private SqlMapClient smc;
	private static FacilityDAOImpl instance;
	private FacilityDAOImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static FacilityDAOImpl getInstance() {
		if(instance == null) instance = new FacilityDAOImpl();
		return instance;
	}

	
	// 공항별 시설 목록 조회
	@Override
	public List<FacilityVO> getFacList(FacilityVO facVo) {
		
		List<FacilityVO> facList = new ArrayList<>();
		
		try {
			
			List<?> tempList = smc.queryForList("fac.getFacList", facVo);
			for(Object obj : tempList) {
				if(obj instanceof FacilityVO) {
					facList.add((FacilityVO) obj);
				}
			}
		} catch (Exception e) {
//			_DebugHarang.logger.error("getFacList() 메서드 에러");
		}
		
		return facList;
	}

	// 항공사 목록 가져오는 메서드
	@Override
	public List<AirlineVO> getAirlineList() {
		List<AirlineVO> airlineList = new ArrayList<>();

		try {
			List<?> tempList = smc.queryForList("fac.getAirlineList");
			for(Object obj : tempList) {
				if(obj instanceof AirlineVO) {
					airlineList.add((AirlineVO) obj);
				}
			}

		} catch (SQLException e) {
//			_DebugHarang.logger.error("getAirlineList() 메서드 에러");
			e.printStackTrace();
		}

		return airlineList;
	}

	// 공항 목록 가져오는 메서드
	@Override
	public List<AirportVO> getAirportList() {
		List<AirportVO> airportList = new ArrayList<>();;

		try {
			List<?> tempList = smc.queryForList("fac.getAirportList");
			for(Object obj : tempList) {
				if(obj instanceof AirportVO) {
					airportList.add((AirportVO) obj);
				}
			}

		} catch (SQLException e) {
//			_DebugHarang.logger.error("getAirlineList() 메서드 에러");
			e.printStackTrace();
		}

		return airportList;
	}
	
	// 공항별 노선 종류 조회
	@Override
	public List<TransportVO> getSelectTransportList(String airportName) {
		List<TransportVO> transportList = new ArrayList<>();
		
		try {
			List<?> tempList = smc.queryForList("fac.getSelectTransportList",airportName);
			for(Object obj : tempList) {
				if(obj instanceof TransportVO) {
					transportList.add((TransportVO) obj);
				}
			}

		} catch (SQLException e) {
//			_DebugHarang.logger.error("getSelectTransportList() 메서드 에러");
			e.printStackTrace();
		}

		return transportList;
	}
	
	// 공항 시설정보를 조회
	@Override
	public List<FacilityVO> getSelectFacilityList(String airportName) {
		List<FacilityVO> facilityList = new ArrayList<>();;
		
		try {
			List<?> tempList = smc.queryForList("fac.getSelectFacilityList",airportName);
			for(Object obj : tempList) {
				if(obj instanceof FacilityVO) {
					facilityList.add((FacilityVO) obj);
				}
			}

		} catch (SQLException e) {
//			_DebugHarang.logger.error("getSelectFacilityList() 메서드 에러");
			e.printStackTrace();
		}

		return facilityList;
	}
	
	// 공항별 시설 분류리스트 조회
	@Override
	public List<FacilityVO> getSelectFacilityClassifyList(String airportName) {
		List<FacilityVO> classifyList = new ArrayList<>();;
		
		try {
			List<?> tempList = smc.queryForList("fac.getSelectFacilityClassifyList",airportName);
			for(Object obj : tempList) {
				if(obj instanceof FacilityVO) {
					classifyList.add((FacilityVO) obj);
				}
			}
			
		} catch (SQLException e) {
//			_DebugHarang.logger.error("getSelectFacilityClassifyList() 메서드 에러");
			e.printStackTrace();
		}
		
		return classifyList;
	}
	
	// 공항별 시설 목록을 가져오는 메서드
	@Override
	public List<FacilityVO> getclassifyFile(Map<String, String> map) {
		List<FacilityVO> classifyFileList = new ArrayList<>();;
		
		try {
			List<?> tempList = smc.queryForList("fac.getclassifyFile",map);
			for(Object obj : tempList) {
				if(obj instanceof FacilityVO) {
					classifyFileList.add((FacilityVO) obj);
				}
			}
			
		} catch (SQLException e) {
//			_DebugHarang.logger.error("getclassifyFile() 메서드 에러");
			e.printStackTrace();
		}
		
		return classifyFileList;
	}
	
	// 공항별 대중교통 종류, 가격을 가져오는 메서드
	@Override
	public List<RouteVO> getTransportPriceList(String airport_name) {
		List<RouteVO> transportPriceList = new ArrayList<>();;
		
		try {
			List<?> tempList = smc.queryForList("fac.getTransportPriceList",airport_name);
			for(Object obj : tempList) {
				if(obj instanceof RouteVO) {
					transportPriceList.add((RouteVO) obj);
				}
			}
			
		} catch (SQLException e) {
//			_DebugHarang.logger.error("getTransportPriceList() 메서드 에러");
			e.printStackTrace();
		}
		
		return transportPriceList;
	}

	// 주차장 이미지 밎 정보 가져오는 메서드
	@Override
	public List<ParkVO> getParkInfo(String airport_name) {
			List<ParkVO> parkVo = new ArrayList<>();
			
			try {
				List<?> tempList = smc.queryForList("fac.getParkInfo", airport_name);
				for(Object obj : tempList) {
					if(obj instanceof ParkVO) {
						parkVo.add((ParkVO) obj);
					}
				}
				
			} catch (SQLException e) {
//				_DebugHarang.logger.error("getParkInfo() 메서드 에러");
				e.printStackTrace();
			}
			return parkVo;
	}
	
}