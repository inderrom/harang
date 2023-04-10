package com.harang.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

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

import com.harang.member.dao.IMemberDAO;
import com.harang.member.dao.MemberDAOImpl;
import com.harang.util.MailAccountLoader;
import com.harang.util.MailFormLoader;
import com.harang.vo.MemberVO;

public class MemberServiceImpl implements IMemberService {
	
	private static MemberServiceImpl instance;
	private MemberServiceImpl() {
		
		dao = MemberDAOImpl.getInstance();
		
	} // 생성자 끝
	
	public static MemberServiceImpl getInstance() {
		if(instance == null) instance = new MemberServiceImpl();
		return instance;
	} // 싱글턴 끝
	
	
	// DB 작업을 위한 IMemberDAO 객체 선언
	private IMemberDAO dao;
	
	@Override
	public MemberVO loginMember(MemberVO memVo) {
		return dao.loginMember(memVo);
	}

	@Override
	public int insertMember(MemberVO memVo) {
		return dao.insertMember(memVo);
	}

	@Override
	public String findId(MemberVO memVo) {
		return dao.findId(memVo);
	}

	@Override
	public int findPass(MemberVO memVo) {
		
		// 입력받은 아이디, 이메일과 일치하는 회원 정보가 DB에 존재하는지 확인
		int result = dao.findPass(memVo);
		
		// 일치하는 회원 정보가 존재하지 않을 경우
		if(result == 0) return 0;
		
		// 12자리의 임시 비밀번호 생성
		String tempPass = issueRandomCode(TEMPPASSWORD_LENGTH);
		
		// DB에 임시 비밀번호 업데이트
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("mem_id", memVo.getMem_id());
		paraMap.put("mem_pass", tempPass);
		paraMap.put("mailPoint", "임시 비밀번호");
		paraMap.put("mailSubject", "하랑 임시 비밀번호 발급 안내");
		
		result = dao.issueTempPass(paraMap);
		paraMap.put("mem_mail", memVo.getMem_mail());
		
		// 임시 비밀번호가 성공적으로 업데이트 되었을 경우
		if(result > 0) sendMail(paraMap);
		
		return result;
	}
	
	/**
	 * 입력받은 자리수만큼의 랜덤 문자열을 생성하는 메서드
	 * 
	 * @param length 생성할 랜덤 문자열의 길이
	 * @return 특정 길이의 랜덤 문자열
	 */
	private String issueRandomCode(int length) {
		return UUID.randomUUID().toString().replaceAll("-", "").substring(0, length);
	}
	
	
	/**
	 * 발급한 임시 비밀번호를 회원 이메일로 발송하는 메서드
	 * 
	 * @param paraMap 발송할 회원 이메일과 임시 비밀번호가 담긴 Map 객체
	 */
	private void sendMail(Map<String, String> paraMap) {
		
		// ResourceBundle 객체 사용하여 관리자 이메일, 비밀번호를 가져온다.
		String user = MailAccountLoader.getMailId(); // 보내는 이 메일 주소
		String password = MailAccountLoader.getMailPass(); // 보내는 이 메일 계정 비밀번호
		
		Session session = readyMailSession(user, password);
		String mailForm = MailFormLoader.getMailForm();
		
		
		mailForm = mailForm.replace("${mailPoint}", paraMap.get("mailPoint"));
		mailForm = mailForm.replace("${mailCode}", paraMap.get("mem_pass"));
		
		try {
			// Session 객체에 기반해 메일 내용 작성
			MimeMessage message = new MimeMessage(session);
			
			message.setFrom(new InternetAddress(user)); // 보내는 이 메일 주소 입력
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(paraMap.get("mem_mail"))); // 받는 이 메일 주소 입력
			
			//paraMap.get("mem_pass"); 을 통해 임시 비밀번호 / 인증 코드를 꺼내와 메일 내용에 적용
			message.setSubject(paraMap.get("mailSubject")); // 메일 제목 입력
			
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
	
	
	// 회원가입 메일 인증 메서드
	@Override
	public String mailAuthentication(MemberVO memVo) {
		
		// 인증코드 6자리를 발급받는다.
		String authCode = issueRandomCode(AUTHCODE_LENGTH);
		
		// Map 객체에 이메일 주소와 인증코드 6자리를 담는다.
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("mem_mail", memVo.getMem_mail());
		paraMap.put("mem_pass", authCode);
		paraMap.put("mailPoint", "인증번호");
		paraMap.put("mailSubject", "하랑 회원가입 인증번호 안내");
		
		// 메일 발송
		sendMail(paraMap);
		
		// 발급한 인증코드 6자리를 반환
		return authCode;
	}

	@Override
	public int getMemberCount(String mem_Id) {
		return  dao.getMemberCount(mem_Id);
	}
	
	@Override
	public int updateMemberInfo(MemberVO memVo) {
		return dao.updateMemberInfo(memVo);
	}
	
	@Override
	public int deleteMember(String memId) {
		return dao.deleteMember(memId);
	}
	
	@Override
	public List<MemberVO> getMemberList() {
		return dao.getMemberList();
	}
	
	@Override
	public MemberVO getMemInfo(String memId) {
		return dao.getMemInfo(memId);
	}
	
}
