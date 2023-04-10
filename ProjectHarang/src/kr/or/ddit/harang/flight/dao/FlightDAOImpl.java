package kr.or.ddit.harang.flight.dao;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.harang.util.SqlMapClientFactory;
import kr.or.ddit.harang.vo.FlightVO;

public class FlightDAOImpl implements IFlightDAO {
	
	private static FlightDAOImpl instance;
	private FlightDAOImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static FlightDAOImpl getInstance() {
		if(instance == null) instance = new FlightDAOImpl();
		return instance;
	}
	
	
	private SqlMapClient smc;
	
	@Override
	public int insertFlight(FlightVO flightVo) {
		
		int result = 0;
		
		try {
			
			Object obj = smc.insert("flight.insertFlight", flightVo);
			if(obj == null) result = 1;
			
			System.out.println("항공편을 추가했습니다.");
			
		} catch (Exception e) {
			System.out.println("이미 존재하는 항공편입니다.");
			System.out.println("요일을 추가합니다.");
			
			try {
				smc.update("flight.updateFlight", flightVo);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return result;
	}

}
