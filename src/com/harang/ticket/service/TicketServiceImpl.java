package com.harang.ticket.service;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.harang.ticket.dao.ITicketDAO;
import com.harang.ticket.dao.TicketDAOImpl;
import com.harang.util.MailAccountLoader;
import com.harang.util.TicketMailFormLoader;
import com.harang.vo.FlightVO;
import com.harang.vo.PageVO;
import com.harang.vo.PassengerVO;
import com.harang.vo.TicketVO;

public class TicketServiceImpl implements ITicketService {
	private static TicketServiceImpl instance;
	private TicketServiceImpl() {
		dao = TicketDAOImpl.getInstance();
	}
	public static TicketServiceImpl getInstance() {
		if(instance == null) instance = new TicketServiceImpl();
		return instance;
	}

	
	private ITicketDAO dao;
	
	@Override
	public List<TicketVO> getTicketList(TicketVO ticketVo) {
		return dao.getTicketList(ticketVo);
	}
	
	@Override
	public FlightVO getFlightInfo(String fli_id) {
		return dao.getFlightInfo(fli_id);
	}
	
	@Override
	public List<PassengerVO> getPssgList(String ticketId) {
		return dao.getPssgList(ticketId);
	}

	@Override
	public int insertTicket(TicketVO ticketVo) {
		return dao.insertTicket(ticketVo);
	}
	
	@Override
	public int insertPassenger(PassengerVO pssgVo) {
		return dao.insertPassenger(pssgVo);
	}
	
	@Override
	public String requestPayment(int price) {
		
		String target = "";
		
		try {
			URL test = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection connection = (HttpURLConnection) test.openConnection();
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Authorization", "KakaoAK f129e364bf3e81260de75afd95c83e48"); // 어드민 키
			connection.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			connection.setDoOutput(true);
			
			String parameter = "cid=TC0ONETIME"
					+ "&partner_order_id=partner_order_id" // 가맹점 주문번호
					+ "&partner_user_id=partner_user_id" // 가맹점 회원 id
					+ "&item_name=" + URLEncoder.encode("하랑", "UTF-8") // 상품명
					+ "&quantity=1" // 상품 수량
					+ "&total_amount=" + (price == 0 ? 1000 : price) // 총 금액
					+ "&vat_amount=0" // 부가세
					+ "&tax_free_amount=0" // 상품 비과세 금액
//					+ "&approval_url=http://localhost/harang/ticket.do?job=success" // 결제 성공 시
//					+ "&fail_url=http://localhost/harang/ticket.do?job=failed" // 결제 실패 시
//					+ "&cancel_url=http://localhost/harang/ticket.do?job=cancel"; // 결제 취소 시
					+ "&approval_url=http://192.168.145.28/harang/ticket.do?job=success" // 결제 성공 시
					+ "&fail_url=http://192.168.145.28/harang/ticket.do?job=failed" // 결제 실패 시
					+ "&cancel_url=http://192.168.145.28/harang/ticket.do?job=cancel"; // 결제 취소 시
			
			
			OutputStream send = connection.getOutputStream(); // 이제 뭔가를 를 줄 수 있다.
			DataOutputStream dataSend = new DataOutputStream(send); // 이제 데이터를 줄 수 있다.
			
			dataSend.writeBytes(parameter); // OutputStream은 데이터를 바이트 형식으로 주고 받기로 약속되어 있다. (형변환)
			dataSend.close();
			
			int result = connection.getResponseCode(); // 전송 잘 됐나 안됐나 번호를 받는다.
			InputStream receive; // 받다
			
			if(result == 200) {
				receive = connection.getInputStream();
			}else {
				receive = connection.getErrorStream(); 
			}
			// 읽는 부분
			InputStreamReader read = new InputStreamReader(receive); // 받은걸 읽는다.
			BufferedReader change = new BufferedReader(read); // 바이트를 읽기 위해 형변환 버퍼리더는 실제로 형변환을 위해 존제하는 클레스는 아니다.
			
			// 받는 부분
			String resultMsg = change.readLine(); // 문자열로 형변환을 알아서 해주고 찍어낸다 그리고 본인은 비워진다.
			JsonParser jparser = new JsonParser();
			JsonObject jo = (JsonObject)jparser.parse(resultMsg);
			target = jo.get("next_redirect_pc_url").toString().replaceAll("\"", "");
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return target;
	}
	
	@Override
	public List<TicketVO> getTicketPage(TicketVO ticketVo) {
		return dao.getTicketPage(ticketVo);
	}
	
	@Override
	public int getTotalCount(String memId) {
		return dao.getTotalCount(memId);
	}
	
	@Override
	public PageVO getPageInfo(String memId, int page) {
		
		int count = getTotalCount(memId);
		
		int start = (page - 1) * PageVO.getPerList() + 1;
		int end = start + PageVO.getPerList() - 1;
		if(end > count) end = count;
		
		int totalPage = (int) Math.ceil((double) count / PageVO.getPerList());
		
		int startPage = ((page - 1) / PageVO.getPerPage() * PageVO.getPerPage()) + 1;
		int endPage = startPage + PageVO.getPerPage() - 1;
		if(endPage > totalPage) endPage = totalPage;
		
		PageVO pageVo = new PageVO();
		
		pageVo.setCount(count);
		pageVo.setStart(start);
		pageVo.setEnd(end);
		pageVo.setTotalPage(totalPage);
		pageVo.setStartPage(startPage);
		pageVo.setEndPage(endPage);
		
		return pageVo;
	}
	
	
	
	
	// 예매 정보 메일 발송 메서드
	public void sendTicketMail(TicketVO ticketVo, String memMail) {
		
		// ResourceBundle 객체 사용하여 관리자 이메일, 비밀번호를 가져온다.
		String user = MailAccountLoader.getMailId(); // 보내는 이 메일 주소
		String password = MailAccountLoader.getMailPass(); // 보내는 이 메일 계정 비밀번호
		
		Session session = readyMailSession(user, password);
		String mailForm = TicketMailFormLoader.getTicketMailForm();
		
		
		String ticketId = ticketVo.getTicket_id();
		List<PassengerVO> pssgList = dao.getPssgList(ticketId);
		FlightVO flightVo = dao.getFlightInfo(ticketVo.getFli_id());
		
		// ---------------------------------------------------------
		// 메일 폼에 정보 삽입
		
		// 출발일
		String ticketDate = ticketVo.getTicket_date().split(" ")[0];
		
		// 시간 형식 변경
		String depTime = flightVo.getFli_deptime();
		String arrTime = flightVo.getFli_arrtime();
		depTime = depTime.substring(0, 2) + "시 " + depTime.substring(2) + "분";
		arrTime = arrTime.substring(0, 2) + "시 " + arrTime.substring(2) + "분";
		
		// 항공편 정보
		String flightHTML = "";
		flightHTML += "<h4>출발일자 : " + ticketDate + "</h4><br>";
		flightHTML += "<h4>항공편명 : " + ticketVo.getFli_id() + "</h4>";
		flightHTML += "<h4>항공사 : " + flightVo.getAirline_name() + "</h4><br>";
		flightHTML += "<h4>출발 : " + depTime + "   " + flightVo.getFli_depport() + " 공항</h4>";
		flightHTML += "<h4>도착 : " + arrTime + "   " + flightVo.getFli_arrport() + " 공항</h4><br>";
		
		
		// 탑승객 정보
		String pssgHTML = "";
		
		for(PassengerVO pssgVo : pssgList) {
			String bir = pssgVo.getPssg_bir().split(" ")[0];
			pssgHTML += "<h4>탑승자명 : " + pssgVo.getPssg_name() + "</h4>";
			pssgHTML += "<h4>생년월일 : " + bir + "</h4>";
			pssgHTML += "<h4>좌석번호 : " + pssgVo.getPssg_seat() + "</h4><br>";
		}
		
		
		// 가져온 정보들을 메일폼에 삽입한다.
		mailForm = mailForm.replace("${ticketId}", ticketId);
		mailForm = mailForm.replace("${flightInfo}", flightHTML);
		mailForm = mailForm.replace("${pssgInfo}", pssgHTML);
		
		// ---------------------------------------------------------
		
		try {
			// Session 객체에 기반해 메일 내용 작성
			MimeMessage message = new MimeMessage(session);
			
			message.setFrom(new InternetAddress(user)); // 보내는 이 메일 주소 입력
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(memMail)); // 받는 이 메일 주소 입력
			
			message.setSubject("하랑 항공권 예매 결과 안내"); // 메일 제목 입력
			
			// 메일 내용을 Multipart로 작성
			MimeMultipart part = new MimeMultipart("related");
			
			// 메일 안에 들어가는 컨텐츠를 작성
			BodyPart htmlBody = new MimeBodyPart();
			htmlBody.setContent(mailForm, "text/html;charset=utf-8"); // html 타입 콘텐츠
			part.addBodyPart(htmlBody);
			
			// 이미지 경로 가져오기
			String classPath = getClass().getResource("").getPath(); // 현재 이 클래스의 경로를 가져온다.
			classPath = classPath.replace("%20", " "); // 띄어쓰기를 공백으로 변경
			classPath = classPath.substring(0, classPath.indexOf("WEB-INF"));
			classPath += "images/layout/haranghead.png"; // 어쩌구저쩌구.../harang/images/layout/haranghead.png
			
			// 이미지 데이터 가져오기
			DataSource ds = new FileDataSource(classPath);
			
			BodyPart image = new MimeBodyPart();
			image.setDataHandler(new DataHandler(ds));
			image.setHeader("Content-ID", "<haranghead.png>");
			part.addBodyPart(image);
			
			message.setContent(part); // 메일 내용 입력
			
			Transport.send(message); // 메일 전송
			
//			_DebugHarang.logger.info("아이디 : " + paraMap.get("mem_id") + "에 임시 비밀번호 발급 ["
//								   + "이메일 : " + paraMap.get("mem_mail") + "]");
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("sendMail() 메서드 에러");
		}
	}
	
	/**
	 * 이메일 발송을 위해 Session 객체를 준비하는 메서드
	 * 
	 * @param user 이메일을 발송하는 관리자의 이메일 주소
	 * @param password 이메일을 발송하는 관리자의 이메일 계정 비밀번호
	 * @return SMTP 설정을 마친 Session 객체
	 */
	private Session readyMailSession(String user, String password) {
		
		// SMTP 정보 입력 : 네이버 메일
		Properties prop = new Properties();
		
		prop.put("mail.smtp.host", "smtp.naver.com");
		prop.put("mail.smtp.port", 465);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", "smtp.naver.com");
		
		// 메일 계정 정보를 통해 인증 후 Session 객체 생성
		Session session = Session.getDefaultInstance(prop, new Authenticator() {
			
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
		
		return session;
	}
	
	@Override
	public List<PassengerVO> getOccupiedSeat(Map<String, String> paraMap) {
		return dao.getOccupiedSeat(paraMap);
	}
}
