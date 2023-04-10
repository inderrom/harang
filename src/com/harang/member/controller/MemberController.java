package com.harang.member.controller;

import java.io.IOException;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.google.gson.Gson;
import com.harang.blacklist.service.BlacklistServiceImpl;
import com.harang.blacklist.service.IBlacklistService;
import com.harang.member.service.IMemberService;
import com.harang.member.service.MemberServiceImpl;
import com.harang.vo.MemberVO;

@WebServlet(urlPatterns = {"/memberLogin.do", "/memberJoin.do",
						   "/memberIdCheck.do","/memberMailSend.do",
						   "/memberMailChk.do", "/memberLogout.do",
						   "/memberProfile.do", "/meberFindId.do",
						   "/memberFindPass.do", "/member.do"
						   })

public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private IMemberService memService;
	private IBlacklistService blkService;
	private Timer timer;
	private TimerTask task;
	
	@Override
	public void init() throws ServletException {
		memService = MemberServiceImpl.getInstance(); // Service 객체 초기화
		blkService = BlacklistServiceImpl.getInstance();
		
		
		// 블랙리스트 정지기간을 하루에 한 번 갱신
		timer = new Timer();
		task = new TimerTask() {
			
			@Override
			public void run() {
				blkService.checkBlkList();
			}
		};
		
		timer.scheduleAtFixedRate(task, 0, 1000 * 60 * 60 * 24);
	}
	
	@Override
	public void destroy() {
		timer.cancel();
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		// 전송받은 Request에서 할 작업을 분류
		String job = request.getParameter("job");
		
		switch(job) {
		case "join":	// 회원가입
			insertMember(request, response);
			break;
		case "login":   // 로그인
			loginMember(request, response);
			break;
		case "logout":  // 로그아웃
			logoutMember(request, response);
			break;
		case "findId":  // 아이디 찾기
			findId(request, response);
			break;
		case "findPass": // 비밀번호 찾기
			findPass(request, response);
			break;
		case "authMail": // 메일 보내기
			authMail(request, response);
			break;
		case "idCheck":  // 아이디 중복확인
			checkId(request, response);
			break;
		case "mailChk":  // 인증 번호 확인
			mailChk(request,response);
			break;
		case "profile":  // 회원 정보 수정
			modifyMemInfo(request,response);
			break;
		case "list":	// 회원 목록 조회 (관리자)
			getMemberList(request, response);
			break;
		case "memCheck": // 탈퇴 전 비밀번호 확인
			checkMember(request, response);
			break;
		case "delete":	// 회원 탈퇴 (사용자 / 관리자)
			deleteMember(request, response);
			break;
		}
	}
	
	
	// 회원 탈퇴
	private void deleteMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 탈퇴 처리할 회원 아이디를 가져온다.
		String memId = request.getParameter("mem_id");
		
		// 메서드 이름은 delete 이나 실제로는 update를 사용해 mem_status 를 'N'으로 바꿔준다.
		int result = memService.deleteMember(memId);
		
		String jsonData = "";
		Gson gson = new Gson();
		response.setContentType("application/json;charset=utf-8");
		
		if(result > 0) {
			jsonData = gson.toJson("SUCCESS");
		} else {
			jsonData = gson.toJson("FAILED");
		}
		
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}
	
	// 회원 탈퇴 전 비밀번호 확인
	private void checkMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MemberVO memVo = useBeanUtils(request);
		MemberVO memInfo = memService.loginMember(memVo);
		
		String jsonData = "";
		Gson gson = new Gson();
		response.setContentType("application/json;charset=utf-8");
		
		// 회원정보가 있을 경우
		if(memInfo != null) {
			jsonData = gson.toJson("SUCCESS");
		} else {
			jsonData = gson.toJson("FAILED");
		}
		
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}

	// 회원 목록 조회
	private void getMemberList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<MemberVO> memList = memService.getMemberList();
		
		request.setAttribute("memList", memList);
		request.getRequestDispatcher("/view/admin/adminMem.jsp").forward(request, response);
	}

	// 회원 정보 수정
	private void modifyMemInfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		MemberVO memVo = useBeanUtils(request);
		
		int result = memService.updateMemberInfo(memVo);
		
		String jsonData = "";
		Gson gson = new Gson();
		response.setContentType("application/json;charset=utf-8");
		
		if(result > 0) {
			MemberVO newMemInfo = memService.getMemInfo(memVo.getMem_id());
			request.getSession().setAttribute("memInfo", newMemInfo);
			jsonData = gson.toJson("SUCCESS");
		} else {
			jsonData = gson.toJson("FAILED");
		}
		
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}
	
	// 회원 로그아웃
	private void logoutMember(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		session.invalidate();
		
		response.sendRedirect(request.getContextPath() + "/view/main/mainIndex.jsp");
	}
	
	// 회원 이메일 인증
	private void mailChk(HttpServletRequest request, HttpServletResponse response) throws IOException  {
		// 이메일 확인 체크
		HttpSession session = request.getSession();
		
		String chkNum = (String) session.getAttribute("chkNum");
		
		// ajax로 인증번호 값을 받아 온다.
		String mailNum =  request.getParameter("mem_mailNum");
		
		Gson gson = new Gson();
		String result = null;
		
		if(chkNum.equals(mailNum)){
			result = gson.toJson("OK");
		} else if (!chkNum.equals(mailNum)) {
			result = gson.toJson("Fail");
		}
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(result);
		response.flushBuffer();
	}

	// 아이디 중복 체크 메서드
	private void checkId(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String mem_Id = request.getParameter("mem_id");
		
		IMemberService service = MemberServiceImpl.getInstance();
		int cnt = service.getMemberCount(mem_Id);
		
		Gson gson = new Gson();
		String result = null;
				
		if(cnt>0) {
			result = gson.toJson("Fail");
			
		}else {
			result = gson.toJson("OK");
		}
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().write(result);
		response.flushBuffer();
	}
	
	
	// 이메일 인증 메서드
	private void authMail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 입력받은 이메일 주소를 가져온다.
		String mem_mail = request.getParameter("mem_mail");
		
		MemberVO memVo = new MemberVO();
		memVo.setMem_mail(mem_mail);
		
		// 이메일 주소로 인증 번호를 보낸 후 인증번호를 가져온다.
		String authCode = memService.mailAuthentication(memVo);
		// 세션을 생성
		HttpSession session = request.getSession();
		// chkNum이라는 키 값에 인증번호를 저장한다.
		session.setAttribute("chkNum", authCode);
		
		int result = 0;
		if(authCode != null) result = 1;
		String resultMsg = result == 1 ? "SUCCESS" : "FAILED";
		
		Gson gson = new Gson();
		String jsonData = gson.toJson(resultMsg);
		
		// 인증번호를 View로 보내준다.
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().write(jsonData);
		response.flushBuffer();
	}
	
	
	// 비밀번호 찾기 메서드
	private void findPass(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 입력받은 아이디, 이메일 정보를 MemberVO 객체에 담는다.
		MemberVO memVo = useBeanUtils(request);
		
		int result = memService.findPass(memVo);
		
		response.setContentType("text/html;charset=utf-8");
		
		if(result == 0) {
			response.getWriter().print("<script>alert('일치하는 회원 정보가 없어요.');location.href='"
										+ request.getContextPath() + "/view/login/findPass.jsp'</script>");
			return;
		}
		
		// 임시 비밀번호 발급에 성공했을 경우
		// 로그인 페이지로 이동
		response.getWriter().print("<script>alert('임시 비밀번호가 발급되었습니다. 이메일을 확인해주세요.');location.href='"
				+ request.getContextPath() + "/view/login/login.jsp'</script>");
	}
	
	
	// 아이디 찾기 메서드
	private void findId(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MemberVO memVo = useBeanUtils(request);
		String memId = memService.findId(memVo);
		
		// 일치하는 회원 정보가 없을 경우
		if(memId == null || memId.equals("")) {
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().print("<script>alert('일치하는 회원 정보가 없어요.');location.href='"
										+ request.getContextPath() + "/view/login/findId.jsp'</script>");
			return;
		}
		
		// 일치하는 회원 정보가 있을 경우
		// 아이디는 앞자리 4글자만 보여주고 나머지는 별표(*)로 가린다.
		int idLenght = memId.length();
		memId= memId.substring(0,4);
		
		for(int i=0;i<idLenght;i++) {
			memId += "*"; 
		}
		
		request.setAttribute("memId", memId);
		request.getRequestDispatcher("/view/login/seeId.jsp").forward(request, response);
	}
	
	
	// 로그인 메서드
	private void loginMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MemberVO memVo = useBeanUtils(request);
		MemberVO memInfo = memService.loginMember(memVo);
		
		// 로그인에 실패했을 경우
		if(memInfo == null) {
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().print("<script>alert('아이디 또는 비밀번호가 틀립니다.');location.href='"
										+ request.getContextPath() + "/view/login/login.jsp'</script>");
			return;
		}
		
		// 로그인에 성공했을 경우 세션에 회원 정보를 저장
		HttpSession session = request.getSession();
		session.setAttribute("memInfo", memInfo);
		
		response.sendRedirect(request.getContextPath()+"/view/main/mainIndex.jsp");
	}
	
	// 회원가입 메서드
	private void insertMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MemberVO memVo = useBeanUtils(request);
		int result = memService.insertMember(memVo);
		
		// 회원가입에 실패했을 경우
		if(result == 0) {
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().print("<script>alert('에러가 발생했습니다.');location.href='"
										+ request.getContextPath() + "/파일경로'</script>");
		}
		
		// 회원가입에 성공했을 경우 로그인 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/view/login/login.jsp");
	}
	
	
	// 입력받은 정보를 MemberVO 객체에 담아주는 메서드
	private MemberVO useBeanUtils(HttpServletRequest request) {
		
		// 입력받은 정보를 담을 MemberVO 객체
		MemberVO memVo = new MemberVO();
		
		// 입력받은 정보를 BeanUtils를 이용해 MemberVO 객체에 담는다.
		try {
			BeanUtils.populate(memVo, request.getParameterMap());
		} catch (Exception e) {
//			_DebugHarang.logger.error("/memberLogin.do 서블릿 BeanUtils 에러");
		}
		
		return memVo;
	}

}
