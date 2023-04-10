package com.harang.member.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.harang.util.SqlMapClientFactory;
import com.harang.vo.MemberVO;
import com.ibatis.sqlmap.client.SqlMapClient;

public class MemberDAOImpl implements IMemberDAO {
	
	private static MemberDAOImpl instance;
	private MemberDAOImpl() {
		
		smc = SqlMapClientFactory.getSqlMapClient();
		
	}
	
	public static MemberDAOImpl getInstance() {
		if(instance == null) instance = new MemberDAOImpl();
		return instance;
	}
	
	
	
	// ibatis 작업을 위한 SqlMapClient 객체 선언
	private SqlMapClient smc;
	
	// 로그인
	@Override
	public MemberVO loginMember(MemberVO memVo) {
		
		MemberVO loginMemVo = new MemberVO();
		
		try {
			
			// DB에서 SELECT한 결과를 MemberVO 객체에 저장
			loginMemVo = (MemberVO) smc.queryForObject("member.loginMember", memVo);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("loginMember() 메서드 에러");
		}
		
		return loginMemVo;
	}
	
	// 회원가입
	@Override
	public int insertMember(MemberVO memVo) {
		
		int result = 0;
		
		try {
			
			// DB에 INSERT한 결과를 Object에 저장
			Object obj = smc.insert("member.insertMember", memVo);
			
			// INSERT에 성공했을 경우 Object는 null
			if(obj == null) result = 1;
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("insertMember() 메서드 에러");
		}
		
		return result;
	}
	
	// 아이디 찾기
	@Override
	public String findId(MemberVO memVo) {
		
		String memId = "";
		
		try {
			
			// DB에 SELECT한 결과를 memId에 저장
			memId = (String) smc.queryForObject("member.findId", memVo);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("findId() 메서드 에러");
		}
		
		return memId;
	}
	
	// 비밀번호 찾기
	@Override
	public int findPass(MemberVO memVo) {
		
		int result = 0;
		
		try {
			
			// DB에 SELECT한 결과를 result에 저장
			result = (Integer) smc.queryForObject("member.findPass", memVo);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("findPass() 메서드 에러");
		}
		
		return result;
	}
	
	// 임시 비밀번호 발급
	@Override
	public int issueTempPass(Map<String, String> paraMap) {
		
		int result = 0;
		
		try {
			
			// DB의 회원 정보에서 비밀번호를 임시 비밀번호로 변경
			result = smc.update("member.issueTempPass", paraMap);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("issueTempPass() 메서드 에러");
		}
		
		return result;
	}

	// 아이디 중복 검사
	@Override
	public int getMemberCount(String memId) {
		int count = 0;
		try {
			count = (int)smc.queryForObject("member.getMemberCount",memId);
		} catch (SQLException e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getMemberCount() 메서드 에러");
		}
		return count;
	}
	
	// 회원 정보 수정
	@Override
	public int updateMemberInfo(MemberVO memVo) {
		int num = 0;
		try {
			num= smc.update("member.updateMemberInfo",memVo);
		} catch (SQLException e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("updateMemberInfo() 메서드 에러");
		}
		
		return num;
	}
	
	// 회원 탈퇴
	@Override
	public int deleteMember(String memId) {
		
		int result = 0;
		
		try {
			
			result = smc.update("member.deleteMember", memId);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("deleteMember() 메서드 에러");;
		}
		
		return result;
	}
	
	// 회원 목록 조회
	@Override
	public List<MemberVO> getMemberList() {
		
		List<MemberVO> memList = new ArrayList<>();
		
		try {
			
			List<?> tempList = smc.queryForList("member.getMemberList");
			for(Object obj : tempList) {
				if(obj instanceof MemberVO) {
					memList.add((MemberVO) obj);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getMemberList() 메서드 에러");
		}
		
		return memList;
	}
	
	// 특정 회원의 회원 정보 조회
	@Override
	public MemberVO getMemInfo(String memId) {
		
		MemberVO memVo = null;
		
		try {
			
			memVo = (MemberVO) smc.queryForObject("member.getMemInfo", memId);
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("getMemInfo() 메서드 에러");
		}
		
		return memVo;
	}
}
