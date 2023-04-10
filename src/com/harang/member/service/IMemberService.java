package com.harang.member.service;

import java.util.List;

import com.harang.vo.MemberVO;

public interface IMemberService {
	
	/**
	 * 비밀번호 찾기에서 회원에게 발급되는 임시 비밀번호 길이
	 */
	final static int TEMPPASSWORD_LENGTH = 12;
	
	/**
	 * 회원가입에서 이메일 인증을 위해 발급되는 인증코드 길이
	 */
	final static int AUTHCODE_LENGTH = 6;
	
	/**
	 * 로그인을 위해 입력받은 아이디와 패스워드를 DB와 대조하여
	 * 일치하는 회원의 회원 정보를 가져오는 메서드
	 * 
	 * @param memVo 입력받은 아이디와 패스워드가 담긴 MemberVO 객체
	 * @return 로그인 성공 : 회원 정보가 담긴 MemberVO 객체<br>로그인 실패 : null
	 */
	public MemberVO loginMember(MemberVO memVo);
	
	/**
	 * 회원가입을 위해 입력받은 회원 정보를 DB에 INSERT하는 메서드
	 * 
	 * @param memVo 입력한 회원 정보가 담긴 MemberVO 객체
	 * @return 회원가입 성공 : 1<br>회원가입 실패 : 0
	 */
	public int insertMember(MemberVO memVo);
	
	/**
	 * 아이디를 찾기 위해 입력받은 이름, 이메일 정보를 DB와 대조하여
	 * 일치하는 회원의 회원 아이디를 가져오는 메서드
	 * 
	 * @param memVo 이름, 이메일 정보가 담긴 MemberVO 객체
	 * @return 아이디 찾기 성공 : 회원 아이디 (String)<br>아이디 찾기 실패 : null
	 */
	public String findId(MemberVO memVo);

	/**
	 * 비밀번호를 찾기 위해 입력받은 아이디, 이메일 정보를 DB와 대조하여
	 * 일치하는 회원이 있는지 결과를 가져오는 메서드
	 * 
	 * @param memVo 아이디, 이메일 정보가 담긴 MemberVO 객체
	 * @return 비밀번호 찾기 성공 : 1<br>비밀번호 찾기 실패 : 0
	 */
	public int findPass(MemberVO memVo);
	
	/**
	 * 회원가입 시, 입력받은 이메일 정보로 인증코드 발송을 준비하는 메서드
	 * 
	 * @param memVo 이메일 정보가 담긴 MemberVO 객체
	 * @return 발급된 인증번호 6자리 (String)
	 */
	public String mailAuthentication(MemberVO memVo);
	
	/**
	 * 아이디 중복 검사를 하는 메서드
	 * 
	 * @param memId 중복 검사할 회원 ID
	 * @return 해당 회원 ID와 일치하는 회원 정보의 개수 (ID 중복 시 : 1)
	 */
	public int getMemberCount(String mem_Id);
	
	/**
	 * 회원 정보를 수정하는 메서드
	 * 
	 * @param memVo 수정할 회원 정보가 담긴 MemberVO 객체
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int updateMemberInfo(MemberVO memVo);
	
	/**
	 * 회원 목록을 조회하는 메서드
	 * 
	 * @return MemberVO 객체가 담긴 List 객체
	 */
	public List<MemberVO> getMemberList();
	
	/**
	 * 회원을 탈퇴처리하는 메서드
	 * 
	 * @param memId 탈퇴처리할 회원의 ID
	 * @return 작업 성공 : 1, 작업 실패 : 0
	 */
	public int deleteMember(String memId);

	/**
	 * 특정 회원의 회원 정보를 가져오는 메서드
	 * 
	 * @param memId 회원 ID
	 * @return MemberVO 객체
	 */
	public MemberVO getMemInfo(String memId);
}
