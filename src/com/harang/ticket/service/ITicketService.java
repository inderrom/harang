package com.harang.ticket.service;

import java.util.List;
import java.util.Map;

import com.harang.vo.FlightVO;
import com.harang.vo.PageVO;
import com.harang.vo.PassengerVO;
import com.harang.vo.TicketVO;

public interface ITicketService {
	
	/**
	 * 예매 목록을 가져오는 메서드
	 * 
	 * @param ticketVo 예매 목록 조건이 담긴 TicketVO 객체
	 * @return TicketVO 객체가 담긴 List 객체
	 */
	public List<TicketVO> getTicketList(TicketVO ticketVo);
	
	/**
	 * 티켓의 항공편명과 일치하는 항공편 정보를 가져오는 메서드
	 * 
	 * @param fli_id 가져올 항공편의 항공편명
	 * @return 항공편 정보가 담긴 FlightVO
	 */
	public FlightVO getFlightInfo(String fli_id);
	
	/**
	 * 특정 예매 건의 탑승객 정보를 가져오는 메서드
	 * 
	 * @param ticketId 탑승객 정보를 조회할 예매 번호
	 * @return 해당 예매 번호의 탑승객 정보가 담긴 PassengerVO의 List 객체
	 */
	public List<PassengerVO> getPssgList(String ticketId);
	
	/**
	 * 예매를 추가하는 메서드
	 * 
	 * @param ticketVo 추가할 예매 정보가 담긴 TicketVO 객체
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int insertTicket(TicketVO ticketVo);
	
	/**
	 * 탑승객 정보를 추가하는 메서드
	 * 
	 * @param pssgVo 추가할 탑승객 정보가 담긴 PassengerVO 객체
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int insertPassenger(PassengerVO pssgVo);
	
	/**
	 * 결제 요청을 하는 메서드
	 * 
	 * @param price 결제 가격
	 * @return 결제 QR코드로 연결되는 주소값
	 */
	public String requestPayment(int price);

	/**
	 * 특정 회원의 페이징된 예매 목록을 가져오는 메서드
	 * 
	 * @param ticketVo 회원 ID, 페이징 정보가 담긴 TicketVO 객체
	 * @return TicketVo 객체가 담긴 List 객체
	 */
	public List<TicketVO> getTicketPage(TicketVO ticketVo);
	
	/**
	 * 특정 회원의 예매 목록 총 개수를 가져오는 메서드
	 * 
	 * @param memId 예매 목록을 조회할 회원 ID
	 * @return 해당 회원의 예매 건 총 개수
	 */
	public int getTotalCount(String memId);
	
	/**
	 * 페이징 처리를 위한 메서드
	 * 
	 * @param memId 예매 목록을 조회할 회원 ID
	 * @param page 현재 페이지
	 * @return 페이지 정보가 담긴 PageVO 객체
	 */
	public PageVO getPageInfo(String memId, int page);
	
	/**
	 * 예매 정보를 메일로 발송하는 메서드
	 * 
	 * @param ticketVo ticketVo 발송할 예매 번호가 담긴 TicketVO 객체
	 * @param memMail 발송할 회원의 메일 주소
	 */
	public void sendTicketMail(TicketVO ticketVo, String memMail);
	
	/**
	 * 특정 일자에 특정 항공편에서 이미 예약된 좌석 목록을 가져오는 메서드
	 * 
	 * @param paraMap 해당하는 날짜(ticket_date)와 해당하는 항공편(fli_id)이 담긴 Map 객체
	 * @return PassengerVO 객체가 담긴 List 객체
	 */
	public List<PassengerVO> getOccupiedSeat(Map<String, String> paraMap);
}
