package com.harang.ticket.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.harang.util.SqlMapClientFactory;
import com.harang.vo.FlightVO;
import com.harang.vo.PassengerVO;
import com.harang.vo.TicketVO;
import com.ibatis.sqlmap.client.SqlMapClient;

public class TicketDAOImpl implements ITicketDAO {
	
	private static TicketDAOImpl instance;
	private TicketDAOImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static TicketDAOImpl getInstance() {
		if(instance == null) instance = new TicketDAOImpl();
		return instance;
	}
	
	
	private SqlMapClient smc;
	
	// 예매 조회 메서드
	@Override
	public List<TicketVO> getTicketList(TicketVO ticketVo) {
		
		List<TicketVO> ticketList = new ArrayList<>();
		
		try {
			
			List<?> tempList = smc.queryForList("ticket.getTicketList", ticketVo);
			for(Object obj : tempList) {
				if(obj instanceof TicketVO) {
					ticketList.add((TicketVO) obj);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getTicketList() 메서드 에러");
		}
		
		return ticketList;
	}
	
	// 항공편 정보 조회 메서드
	@Override
	public FlightVO getFlightInfo(String fli_id) {
		
		FlightVO flightVo = new FlightVO();
		 try {
			
			 flightVo = (FlightVO) smc.queryForObject("ticket.getFlightInfo", fli_id);
			 
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getFlightInfo() 메서드 에러");
		}
		
		return flightVo;
	}
	
	// 탑승객 정보 목록 조회 메서드
	@Override
	public List<PassengerVO> getPssgList(String ticketId) {
		
		List<PassengerVO> pssgList = new ArrayList<>();
		
		try {
			
			List<?> tempList = smc.queryForList("ticket.getPssgList", ticketId);
			for(Object obj : tempList) {
				if(obj instanceof PassengerVO) {
					pssgList.add((PassengerVO) obj);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getPssgList() 메서드 에러");
		}
		
		return pssgList;
	}
	
	// 예매 추가 메서드
	@Override
	public int insertTicket(TicketVO ticketVo) {
		
		int result = 0;
		
		try {
			
			Object obj = smc.insert("ticket.insertTicket", ticketVo);
			if(obj == null) result = 1;
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("insertTicket() 메서드 에러");
		}
		
		return result;
	}
	
	// 탑승객 추가 메서드
	@Override
	public int insertPassenger(PassengerVO pssgVo) {
		
		int result = 0;
		
		try {
			
			Object obj = smc.insert("ticket.insertPassenger", pssgVo);
			if(obj == null) result = 1;
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("insertPassenger() 메서드 에러");
		}
		
		return result;
	}
	
	// 특정 회원의 페이징된 예매 목록을 가져오는 메서드
	@Override
	public List<TicketVO> getTicketPage(TicketVO ticketVo) {
		
		List<TicketVO> ticketList = new ArrayList<>();
		
		try {
			
			List<?> tempTicketList = smc.queryForList("ticket.getTicketPage", ticketVo);
			for(Object obj : tempTicketList) {
				if(obj instanceof TicketVO) {
					ticketList.add((TicketVO) obj);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getTicketPage() 메서드 에러");
		}
		
		return ticketList;
	}
	
	// 특정 회원의 예매 목록 총 개수를 가져오는 메서드
	@Override
	public int getTotalCount(String memId) {
		
		int result = 0;
		
		try {
			
			result = (Integer) smc.queryForObject("ticket.getTotalCount", memId);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getTotalCount() 메서드 에러");
		}
		
		return result;
	}
	
	// 특정 날짜, 특정 항공편에서 이미 예약된 좌석 목록을 가져오는 메서드
	@Override
	public List<PassengerVO> getOccupiedSeat(Map<String, String> paraMap) {
		
		List<PassengerVO> pssgList = new ArrayList<>();
		
		try {
			List<?> tempList = (List<?>) smc.queryForList("ticket.getOccupiedSeat", paraMap);
			for(Object obj : tempList) {
				if(obj instanceof PassengerVO) {
					pssgList.add((PassengerVO) obj);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getOccupiedSeat() 메서드 에러");
		}
		
		return pssgList;
	}
}
