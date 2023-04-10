package com.harang.util;

import java.util.ResourceBundle;

public class MailAccountLoader {
	
	// properties 파일을 읽어오는 ResourceBundle 객체 선언
	private static ResourceBundle rb;
	
	static {
		// com.harang.config 패키지의 mail.properties 읽어오기
		rb = ResourceBundle.getBundle("com.harang.util.settings.mail");
	}
	
	/**
	 * 관리자 메일 주소를 반환하는 메서드
	 * 
	 * @return 관리자 메일 주소
	 */
	public static String getMailId() {
		return rb.getString("user");
	}
	
	/**
	 * 관리자 메일 비밀번호를 반환하는 메서드
	 * 
	 * @return 관리자 메일 비밀번호
	 */
	public static String getMailPass() {
		return rb.getString("pass");
	}
}
