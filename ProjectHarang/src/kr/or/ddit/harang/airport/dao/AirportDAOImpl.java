package kr.or.ddit.harang.airport.dao;

import java.util.ArrayList;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.harang.util.SqlMapClientFactory;
import kr.or.ddit.harang.vo.AirportVO;

public class AirportDAOImpl implements IAirportDAO {
	
	private static AirportDAOImpl instance;
	private AirportDAOImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static AirportDAOImpl getInstance() {
		if(instance == null) instance = new AirportDAOImpl();
		return instance;
	}
	
	
	private SqlMapClient smc;
	
	@Override
	public List<AirportVO> selectAll() {
		
		List<AirportVO> airportList = new ArrayList<>();
		
		try {
			
			List<?> tempList = smc.queryForList("airport.selectAll");
			for(Object obj : tempList) {
				if(obj instanceof AirportVO) {
					airportList.add((AirportVO) obj);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return airportList;
	}

}
