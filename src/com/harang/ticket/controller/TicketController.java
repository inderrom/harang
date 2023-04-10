package com.harang.ticket.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.harang.ticket.service.ITicketService;
import com.harang.ticket.service.TicketServiceImpl;
import com.harang.vo.FlightVO;
import com.harang.vo.MemberVO;
import com.harang.vo.PageVO;
import com.harang.vo.PassengerVO;
import com.harang.vo.TicketVO;

@WebServlet("/ticket.do")
public class TicketController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ITicketService ticketService;
	
	@Override
	public void init() throws ServletException {
		ticketService = TicketServiceImpl.getInstance();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String job = request.getParameter("job");
		switch(job) {
		case "list":
			getTicketList(request, response);	// 예매 목록 조회
			break;
		case "flight":
			getFlightInfo(request, response);	// 항공편 정보 조회
			break;
		case "passenger":
			getPssgList(request, response);		// 탑승객 정보 조회
			break;
		case "savePssg":
			savePssgInfo(request, response);	// 탑승객 정보 저장
			break;
		case "occupiedSeat":
			getOccupiedSeat(request, response);
			break;
		case "saveSeat":
			saveSeat(request, response);		// 좌석 정보 저장
			break;
		case "insertTicket":
			insertTicket(request, response);	// 예매 이력 등록
			break;
		case "payment":
			payment(request, response);			// 항공권 결제
			break;
		case "success":
			successPayment(request, response);	// 항공권 결제 성공
			break;
		case "failed":
			failedPayment(request, response);	// 항공권 결제 실패
			break;
		case "cancel":
			cancelPayment(request, response);	// 항공권 결제 취소
			break;
		case "mylist":
			getTicketPage(request, response);	// 특정 회원의 예매 목록 (페이징)
			break;
		}
	}
	
	// 이미 예약이 잡힌 좌석 목록을 가져오는 메서드
	private void getOccupiedSeat(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String date = request.getParameter("date");		
		String fliId = request.getParameter("fliId");
		
		// 해당 날짜와 항공편명을 저장
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("ticket_date", date);
		paraMap.put("fli_id", fliId);
		
		List<PassengerVO> pssgList = ticketService.getOccupiedSeat(paraMap);
		
		String jsonData = "";
		Gson gson = new Gson();
		response.setContentType("application/json;charset=utf-8");
		
		jsonData = gson.toJson(pssgList);
		
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}

	// 특정 회원의 페이징된 예매 목록을 가져오는 메서드
	private void getTicketPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String pageStr = request.getParameter("page");
		
		int page = 1;
		if(pageStr != null) page = Integer.parseInt(pageStr);
		
		TicketVO ticketVo = useBeanUtils(request);
		PageVO pageVo = ticketService.getPageInfo(ticketVo.getMem_id(), page);
		
		ticketVo.setStart(pageVo.getStart());
		ticketVo.setEnd(pageVo.getEnd());
		
		List<TicketVO> ticketList = ticketService.getTicketPage(ticketVo);
		
		request.setAttribute("pageVo", pageVo);
		request.setAttribute("ticketList", ticketList);
		request.getRequestDispatcher("/view/login/ticketlist.jsp").forward(request, response);
	}

	// 결제 취소 시
	private void cancelPayment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().print("<script>alert('결제를 취소하셨습니다.'); window.close();</script>");
	}

	// 결제 실패 시
	private void failedPayment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().print("<script>alert('잠시 후 다시 시도해주세요.');</script>");
	}
	
	// 결제 완료 후 창 닫기
	private void successPayment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=utf-8");
//		response.getWriter().print("<script>var target = window.opener; target.location.href='http://localhost/harang/ticket.do?job=insertTicket'; window.close();</script>");
		response.getWriter().print("<script>var target = window.opener; target.location.href='http://192.168.145.28/harang/ticket.do?job=insertTicket'; window.close();</script>");
	}

	// 결제
	private void payment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int price = Integer.parseInt(request.getParameter("price"));
		
		String target = ticketService.requestPayment(price);
		
		Gson gson = new Gson();
		String jsonData = gson.toJson(target);
		
		response.setContentType("application/json;charset=utf-8");
		
		// 만약 결과값이 엉망일 경우
		if(target.equals("")) {
			response.getWriter().write("FAILED");
			response.flushBuffer();
			return;
		}
		
		// 정상 처리되었을 경우
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}

	// 특정 예매 건에 대하여 탑승객 정보를 가져오기
	private void getPssgList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String ticketId = request.getParameter("ticketId");
		List<PassengerVO> pssgList = ticketService.getPssgList(ticketId);
		
		Gson gson = new Gson();
		String jsonData = gson.toJson(pssgList);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}

	// 예매이력 확인에서 항공편 정보 가져오기
	private void getFlightInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String fliId = request.getParameter("fliId");
		FlightVO fliVo = ticketService.getFlightInfo(fliId);
		
		request.setAttribute("fliVo", fliVo);
		request.getRequestDispatcher("").forward(request, response);
	}

	// 예매 추가
	private void insertTicket(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// 항공편 정보
		FlightVO goFlight = (FlightVO) session.getAttribute("goFlight");
		FlightVO comeFlight = (FlightVO) session.getAttribute("comeFlight");
		
		// 탑승객 정보
		List<PassengerVO> pssgList = new ArrayList<>();
		List<?> tempPssgList = (List<?>) session.getAttribute("pssgList");
		for(Object obj : tempPssgList) {
			if(obj instanceof PassengerVO) {
				pssgList.add((PassengerVO) obj);
			}
		}
		
		// 가는 편 좌석 정보
		List<PassengerVO> goSeatList = new ArrayList<>(0);
		List<?> tempGoSeat = (List<?>) session.getAttribute("goSeat");
		for(Object obj : tempGoSeat) {
			if(obj instanceof PassengerVO) {
				goSeatList.add((PassengerVO) obj);
			}
		}
		
		// 오는 편 좌석 정보
		List<PassengerVO> comeSeatList = new ArrayList<>();
		List<?> tempComeSeat = (List<?>) session.getAttribute("comeSeat");
		if(tempComeSeat != null) {
			for(Object obj : tempComeSeat) {
				if(obj instanceof PassengerVO) {
					comeSeatList.add((PassengerVO) obj);
				}
			}
		}
		
		int count = 1;
		if(comeFlight != null) count = 2;
		
		// 회원 정보 가져오기
		MemberVO memInfo = (MemberVO) session.getAttribute("memInfo");
		String memId = memInfo.getMem_id();
		
		int result = 0;
		
		for(int i = 0; i < count; i++) {
			// 항공편 정보 -> 0 : 가는 편, 1 : 오는 편
			FlightVO fliVo = null;
			switch(i) {
			case 0:
				fliVo = goFlight;
				break;
			case 1:
				fliVo = comeFlight;
				break;
			}
			
			// 예매번호
			String ticketCode = UUID.randomUUID().toString().replace("-", "").substring(0, 12) + new SimpleDateFormat("yyyyMMddHHmm").format(new Date().getTime());
			
			TicketVO ticketVo = new TicketVO();
			ticketVo.setTicket_id(ticketCode);
			ticketVo.setFli_id(fliVo.getFli_id());
			ticketVo.setMem_id(memId);
			ticketVo.setTicket_date(fliVo.getDate());
			
			int pssgCount = fliVo.getCount();
			
			// 예매정보 저장
			result = ticketService.insertTicket(ticketVo);
			if(result == 1) {
				
				// 탑승객 정보 저장
				for(int j = 0; j < pssgCount; j++) {
					PassengerVO pssgInfo = pssgList.get(j);
					
					String name = pssgInfo.getPssg_name();
					String bir = pssgInfo.getPssg_bir();
					
					String seatNum = "";
					switch(i) {
					case 0:
						seatNum = goSeatList.get(j).getPssg_seat();
						break;
					case 1:
						seatNum = comeSeatList.get(j).getPssg_seat();
						break;
					}
					
					PassengerVO pssgVo = new PassengerVO();
					pssgVo.setTicket_id(ticketCode);
					pssgVo.setPssg_name(name);
					pssgVo.setPssg_bir(bir);
					pssgVo.setPssg_seat(seatNum);
					
					result = ticketService.insertPassenger(pssgVo);
					
					
					
				}
				
				// 예매 결과 메일 발송
				String memMail = memInfo.getMem_mail();
				ticketService.sendTicketMail(ticketVo, memMail);
			}
		}
		
		
		if(result == 1) {
			session.removeAttribute("bookInfo");
			session.removeAttribute("pssgList");
			session.removeAttribute("goSeat");
			session.removeAttribute("comeSeat");
			response.sendRedirect(request.getContextPath() + "/view/ticket/bookingResult.jsp");
		} else {
			response.sendRedirect(request.getContextPath() + "/view/ticket/booking.jsp");
		}
	}
	
	// 좌석 임시 저장
	private void saveSeat(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String arr = request.getParameter("seatInfo");
		String flightWay = request.getParameter("flightWay"); // goSeat 또는 comeSeat
		
		JsonParser jparser = new JsonParser();
		JsonArray ja = (JsonArray) jparser.parse(arr);
		
		// 세션에 저장되어있던 탑승객 정보를 가져온다.
		List<PassengerVO> pssgList = new ArrayList<>();
		
		HttpSession session = request.getSession();
		List<?> tempPssgList = (List<?>)session.getAttribute("pssgList");
		for(Object obj : tempPssgList) {
			if(obj instanceof PassengerVO) {
				pssgList.add((PassengerVO) obj);
			}
		}
		
		// 좌석 정보가 담기는 List
		List<PassengerVO> seatList = new ArrayList<>();
		
		for(int i = 0; i < ja.size(); i++) {
			JsonObject jo = (JsonObject) ja.get(i);
			
//			String pssgName = jo.get("pssgName").toString().replaceAll("\"", "");
			String pssgSeat = jo.get("pssgSeat").toString().replaceAll("\"", "");
			
			PassengerVO pssgVo = pssgList.get(i);
			String fullName = pssgVo.getPssg_name();
			
			PassengerVO seatVo = new PassengerVO();
			seatVo.setPssg_name(fullName);
			seatVo.setPssg_seat(pssgSeat);
			seatList.add(seatVo);
		}
		
		session.setAttribute(flightWay, seatList);
		
		
		Gson gson = new Gson();
		response.setContentType("application/json;charset=utf-8");
		
		if(session.getAttribute(flightWay) != null) {
			String jsonData = gson.toJson("SUCCESS");
			response.getWriter().write(jsonData);
			response.flushBuffer();
			return;
		}
		
		String jsonData = gson.toJson("FAILED");
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}
	
	// 탑승객 정보 임시 저장
	private void savePssgInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String[] arr = request.getParameterValues("userInfoList");
		JsonParser jparser = new JsonParser();
		
		// 탑승객 목록
		List<PassengerVO> pssgList = new ArrayList<>();
		
		for(int i = 0; i < arr.length; i++) {
			
			JsonObject jo = (JsonObject) jparser.parse(arr[i]);
			
			String lName = jo.get("mem_lName").toString().replaceAll("\"", "");
			String fName = jo.get("mem_fName").toString().replaceAll("\"", "");
			String bir = jo.get("mem_bir").toString().replaceAll("\"", "");
			
			// 탑승객 정보
			PassengerVO pssgVo = new PassengerVO();
			pssgVo.setPssg_name(fName + " " + lName);
			pssgVo.setPssg_bir(bir);
			
			pssgList.add(pssgVo);
		}
		
		// 탑승객 정보 목록을 세션에 저장
		HttpSession session = request.getSession();
		session.setAttribute("pssgList", pssgList);
		
		String result = "";
		if(session.getAttribute("pssgList") != null) {
			result = "SUCCESS";
		} else {
			result = "FAILED";
		}
		
		Gson gson = new Gson();
		String jsonData = gson.toJson(result);
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(jsonData);
	}
	
	
	// 예매 목록 조회
	private void getTicketList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		TicketVO ticketVo = useBeanUtils(request);
		List<TicketVO> ticketList = ticketService.getTicketList(ticketVo);
		
		request.setAttribute("ticketList", ticketList);
		request.getRequestDispatcher("/view/login/ticketlist.jsp").forward(request, response);
	}
	

	// 입력받은 정보를 BoardVO 객체에 담아주는 메서드
	private TicketVO useBeanUtils(HttpServletRequest request) {
		
		// 입력받은 정보를 담을 BoardVO 객체
		TicketVO ticketVo = new TicketVO();
		
		// 입력받은 정보를 BeanUtils를 이용해 BoardVO 객체에 담는다.
		try {
			BeanUtils.populate(ticketVo, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
//				_DebugHarang.logger.error("/ticket.do 서블릿 BeanUtils 에러");
		}
		
		return ticketVo;
	}
}
