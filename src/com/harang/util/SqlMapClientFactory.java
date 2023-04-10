package com.harang.util;

import java.io.Reader;
import java.nio.charset.Charset;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class SqlMapClientFactory {
	
	// SqlMapClientFactory에서 사용할 SqlMapClient 객체 선언
	private static SqlMapClient smc;
	static {
		try {
			// Charset 객체 생성하기 (UTF-8)
			Charset charset = Charset.forName("UTF-8");
			
			// Resource 객체의 인코딩 설정하기
			Resources.setCharset(charset);
			
			// Reader 객체를 통해 ibatis에서 사용할 sqlMapConfig.xml 파일 연결하기
			Reader rd = Resources.getResourceAsReader("com/harang/config/sqlMapConfig.xml");
			
			// SqlMapClient 객체 초기화
			smc = SqlMapClientBuilder.buildSqlMapClient(rd);
			rd.close();
			
		} catch (Exception e) {
			e.printStackTrace();
//			_DebugHarang.logger.error("SqlMapClientFactory 클래스 에러");
		}
	}
	
	/**
	 * SqlMapClient 객체를 반환하는 메서드
	 *  
	 * @return 설정이 완료된 SqlMapClient 객체
	 */
	public static SqlMapClient getSqlMapClient() {
		return smc;
	}
	
}
