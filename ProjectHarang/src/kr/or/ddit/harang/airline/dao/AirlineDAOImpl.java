package kr.or.ddit.harang.airline.dao;

import java.util.ArrayList;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.harang.util.SqlMapClientFactory;
import kr.or.ddit.harang.vo.AirlineVO;

public class AirlineDAOImpl implements IAirlineDAO {
	
	private static AirlineDAOImpl instance;
	private AirlineDAOImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static AirlineDAOImpl getInstance() {
		if(instance == null) instance = new AirlineDAOImpl();
		return instance;
	}
	
	private SqlMapClient smc;

	@Override
	public int insertAirline(AirlineVO airlineVo) {
		
		int result = 0;
		
		try {
			
			Object obj = smc.insert("airline.insertAirline", airlineVo);
			
			if(obj == null) result = 1;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<AirlineVO> selectAll() {
		
		List<AirlineVO> airlineList = new ArrayList<>();
		
		try {
			
			List<?> tempList = smc.queryForList("airline.selectAll");
			for(Object obj : tempList) {
				if(obj instanceof AirlineVO) {
					airlineList.add((AirlineVO) obj);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return airlineList;
	}

}
