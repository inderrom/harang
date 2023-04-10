<%@page import="com.harang.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HARANG SIGN UP</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap 적용 -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="icon" href="<%= request.getContextPath() %>/images/layout/Union.png">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/navbar.css">
  <!-- 폰트적용 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@900&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap" rel="stylesheet">
  
<script>
<%
MemberVO memInfo = (MemberVO) session.getAttribute("memInfo");
%>
	$(function(){
		var idFlag = false;     // 아이디 판별
		var pwFlag = false;		// 비밀번호 판별
		var nicknameFlag = false; // 닉네임 판별
		var nameFlag = false;	// 이름 판별
		var mailFlag = false;	// 메일 판별 
		var mailNumFlag = false; // 인증번호 판별
		var send = false // 인증번호 발송 여부 판별
// 		var tel = false // 전화번호 판별
		
		$('#mainMenuList li').on('mouseenter', function(){
			$('#subMenuList').slideDown();
		});
		$('#subMenuList').on('mouseleave', function(){
			$('#subMenuList').slideUp();
		});
 		window.addEventListener('load', function() {
    		var forms = document.getElementsByClassName('needs-validation');
   		 	var validation = Array.prototype.filter.call(forms, function(form) {
     			form.addEventListener('submit', function(event) {
        			if (form.checkValidity() === false) {
          				event.preventDefault();
          				event.stopPropagation();
        			}
        			form.classList.add('was-validated');
      			}, false);
    		});
  		}, false);
 		
 		// 아이디 입력 시
 		$("#mem_id").on('keyup', function(){
	 		var id = $("#mem_id").val(); 
	 		idreg =  /^[a-z]+[a-z0-9]{4,19}$/g;
	 		
	 		if(idreg.test(id)) {
	 			$("#idChkResult").empty();
	 			idFlag = true;  // 판별 값 참으로 변경
	 		}else{
	 			$("#idChkResult").html("<span style='color:red'>아이디는 5~19자 사이로 입력해주세요.</span>");
	 			idFlag = false;  // 판별 값 거짓으로 변경
	 		}
	 	});
 		
		// 아이디 중복 버튼 클릭 시
 		$("#idCheck").on("click",function(){
 			
 			// 아이디 양식이 옳을 경우
 			if(idFlag){
 				$("#idChkResult").html("");
 		 		var memId = $("#mem_id").val();
 		 		$.ajax({
 		 			url : '<%= request.getContextPath()%>/memberIdCheck.do',
 		 			type : "post",
 		 			data : { "mem_id": memId, "job": "idCheck"},
 		 			dataType : 'json',
 		 			success : function(result){
 		 				if(result=="OK"){
 			 				$("#idChkResult").html("<span style='color:green'>사용 가능한 아이디예요.</span>");
 			 				idFlag = true;
 		 				} else {
 		 					$("#idChkResult").html("<span style='color:red'>이미 사용중인 아이디예요.</span>");
 		 					idFlag = false;
 		 				}
 		 			},
 		 			error : function(xhr){
 		 				alert("status :"+xhr.status);
 		 			}
 		 		});
 			}
	 	});
		
 		// 비밀번호 확인란에 입력 했을 때
	 	$("#mem_passChk").on('keyup', function(){
	 		var pass1 = $("#mem_pass").val();
	 		var pass2 = $("#mem_passChk").val();
	 		passreg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()+]).{8,14}$/;
	 		
	 		if(!passreg.test(pass1)){
	 			$("#passChkResult").html("<span style='color:red'>비밀번호는 8~14자리 사이로 입력해주세요.</span>");
	 			pwFlag = false;
	 		}else if(pass1!=pass2) {
	 			$("#passChkResult").html("<span style='color:red'>비밀번호를 다시 확인해주세요.</span>");
	 			pwFlag = false;
	 		}else{
	 			$("#passChkResult").empty();
	 			pwFlag = true;
	 		}
	 	});
 		// 닉네임
 		$("#mem_nick").on('keyup',function(){
 			var nickName = $("#mem_nick").val();
 			// 한글 포함 1,14글자
 			var nickLength = nickName.length;
 			if(nickLength > 1 && nickLength < 15 ){
 				nicknameFlag = true;
 				$("#nicknameResult").empty();
 			} else {
 				$("#nicknameResult").html("<span style='color: red'>닉네임은 2~14자 사이로 입력해주세요.</span>");
 			}
 		});
	 	// 이름
	 	$("#mem_name").on('keyup', function(){
	 		var name = $("#mem_name").val();
	 		namereg = /^[가-힣]{2,5}$/;
	 		if(namereg.test(name)) {
	 			$("#nameResult").empty();
	 			nameFlag = true;
	 		}else{
	 			$("#nameResult").html("<span style='color:red'>이름을 다시 한번 확인해주세요.</span>");
	 			nameFlag = false;
	 		}
	 	});
	 	// 이메일
	 	$("#mem_mail").on('keyup', function(){
	 		var mail = $("#mem_mail").val();
	 		mailreg=/^([a-z][a-z0-9]+)@([a-z][a-z0-9]+)(\.[a-z]+){1,2}$/;
	 		if(mailreg.test(mail)) {
	 			$("#mailChkResult").empty();
	 			mailFlag = true;
	 		}else{
	 			$("#mailChkResult").html("<span style='color:red'>메일 주소를 다시 한번 확인해주세요.</span>");
	 			mailFlag = false;
	 		}
	 	});
	 	
		// 전화번호
	 	$("#mem_tel").on('keyup', function(){
	 		var tel = $("#mem_tel").val();
	 		telreg=/^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	 		
	 		if(telreg.test(tel)) {
	 			$("#telChkResult").empty();
	 		}else{
	 			$("#telChkResult").html("<span style='color:red'>전화번호를 다시 한번 확인해주세요.</span>");
	 		}
	 	});
	 	
	 	// 인증번호 전송 버튼이 눌렸을 때
	 	$("#mailNumReceive").on("click",function(){
	 		
	 		// 이메일이 옳은 양식일 경우
	 		if(mailFlag){
	 			// 인증 번호를 입력한 텍스트에서 값을 받아 온다.
		 		var memMail = $("#mem_mail").val();
		 		
		 		$.ajax({
		 			url : '<%= request.getContextPath()%>/memberMailSend.do',
		 			type : "post",
		 			data : {
		 					"mem_mail": memMail,
		 					"job":"authMail"
		 					},
		 			dataType : 'json',
		 			success : function(result){
		 				if(result=="SUCCESS" && mailFlag ){
		 					alert("이메일로 인증번호가 발송되었어요.");
		 					send = true;
		 					mailNumFlag = true;
		 				}else if(!mailFlag){
		 					alert("이메일 형식을 확인해주세요.")
		 				}else{
		 					alert("잠시후 다시 시도해주세요.")
		 				}
		 			}
		 		});
	 		}else{
	 			$("#mailChkResult").html("<span style='color:red'>메일 주소를 다시 한번 확인해주세요.</span>");
	 		}
	 		
	 	})
	 	// 이메일 인증번호 확인 버튼이 눌렸을 때
	 	$("#mailChk").on('click', function(){
	 		
	 		var mailChk = $("#mem_mailChk").val();
	 		
	 		if(send){
		 		$.ajax({
		 			url : '<%= request.getContextPath()%>/memberMailChk.do',
		 			type : 'post',
		 			data : {
		 					"mem_mailNum": mailChk,
		 					"job": "mailChk"
		 			},
		 			dataType : 'json',
		 			success : function(result){
		 				if(result=="OK"){
		 					// 이메일이 승인 되었을 때 해당 버튼을 사용 
		 					$("#sendednumberChk").html("<span style='color:green'>인증 완료</span>");
		 				}else{
		 					alert("인증번호가 일치하지 않아요.");
		 				}
		 			},
		 			error : function(err){
		 				alert(err.status + " : " + err.statusText);
		 			}
		 		});
	 		} else {
	 			alert("인증번호 받기를 눌러주세요.");
	 		}
	 	});
	 	
	 	// 회원 등록 버튼 클릭 시
	 	$("#regist").on('click',function(){
	 		
	 		if(idFlag && pwFlag && nameFlag && mailFlag && mailNumFlag){
				$("#regiserForm").submit();
	 		}else{
	 			alert("입력 항목을 다시 한번 확인해주세요.");
	 		}
	 	});
	 	
	 	// 메인으로 버튼 클릭 시
	 	$("#mainButton").on('click',function(){
	 		location.href = "<%= request.getContextPath() %>/view/main/mainIndex.jsp"
 		});
	 	
	 	// 로그아웃 버튼이 눌렸을 때
		$("#logout").on('click',function(){
			location.href = '<%= request.getContextPath()%>/memberLogout.do?job=logout';
		});
		
		// 프로필 버튼이 눌렸을 때
		$("#profile").on('click',function(){
		<%
			if(memInfo != null){
		%>
				// 일반 계정의 경우 프로필로 연결
				// 관리자 계정의 경우 관리자 페이지로 연결
				if("<%= memInfo.getMem_account() %>" == "일반"){
					location.href = '<%= request.getContextPath()%>/view/login/profile.jsp'
				} else {
					location.href = '<%= request.getContextPath()%>/view/admin/adminIndex.jsp'
				}
		<%
			}
		%>
		});
		
		
		// 항공권 예매 클릭 시
		$("#goSearchAirplane").on('click', function(){
			location.href = '<%= request.getContextPath() %>/view/ticket/searchAirplane.jsp';
		});
		
		//출발/도착안내
		$('#goDepart_ArrivBoardInfo').on('click', function () {
			location.href = '<%= request.getContextPath() %>/view/facility/depart_ArrivBoardInfo.jsp';
		})
		//시설안내
		$('#goFacilityInfo').on('click', function () {
			location.href = '<%= request.getContextPath() %>/view/facility/facility.jsp';
		})
		
		//주차안내
		$('#goParkingInfo').on('click', function () {
			location.href = '<%= request.getContextPath() %>/view/facility/parkingInfo.jsp';
		})
		
		//대중교통안내
		$('#goTransportinfo').on('click', function () {
			location.href = '<%= request.getContextPath() %>/view/facility/transportinfo.jsp';
		})
		
		// 여행가이드 게시판 사항
		$("#goGuidboard").on("click",function(){
			<%
				if(memInfo != null){
			%>
					location.href='<%=request.getContextPath()%>/board.do?job=list&board_type=guideboard';
			<%
				} else {
			%>
				alert("로그인이 필요합니다.");
				location.href='<%=request.getContextPath()%>/view/login/login.jsp';
			<%
				}
			%>
		});
		
		// 여행후기 게시판 사항
		$("#goReviewboard").on("click",function(){
			<%
				if(memInfo != null){
			%>
					location.href='<%=request.getContextPath()%>/board.do?job=list&board_type=reviewboard';
			<%
				} else {
			%>
				alert("로그인이 필요합니다.");
				location.href='<%=request.getContextPath()%>/view/login/login.jsp';
			<%
				}
			%>
		});
		
		// 자유게시판 버튼이 눌렸을 때
		$("#goFreeboard").on("click",function(){
		<%
			if(memInfo != null){
		%>
				location.href='<%=request.getContextPath()%>/board.do?job=list&board_type=freeboard';
		<%
			} else {
		%>
			alert("로그인이 필요합니다.");
			
			location.href='<%=request.getContextPath()%>/view/login/login.jsp';
		<%
			}
		%>
		});
		
		// 공지 사항
		$("#goNoticeboard").on("click",function(){
			location.href='<%=request.getContextPath()%>/board.do?job=list&board_type=noticeboard';
		});
		
		// 분실물
		$("#goLost").on("click",function(){
			location.href='<%=request.getContextPath()%>/view/lost/lost.jsp';
		});
		
		// 문의게시판 사항
		$("#goQuesboard").on("click",function(){
			<%
				if(memInfo != null){
			%>
					location.href='<%=request.getContextPath()%>/board.do?job=list&board_type=quesboard';
			<%
				} else {
			%>
				alert("로그인이 필요합니다.");
				location.href='<%=request.getContextPath()%>/view/login/login.jsp';
			<%
				}
			%>
		});
		
	});
</script>
<style>
/* 기본값 style */
#mainMenu{
	user-select : none;
}
body{
	min-width : 1600px;
	height : 100%;
	background : linear-gradient(rgba( 29, 233, 182, 0.65 ), white);
}
.container-fluid{
	max-width : 650px;
	margin-top : 50px;
	padding-top : 75px;
	background-color : white;
}
.wrap{
	width : 100%;
	margin : 10px auto;
	position : relative;
}
.cropping{
	margin-top : -10px;
	height :  300px;
	overflow:hidden;
}
.cropping img{
	max-height : initial;
	margin-top: -20%;
	filter:brightness(60%);
	transform: translate( 0px, 300px );
	z-index : 2;
}
.text{
	position : absolute;
	transform: translate( 830px, -200px );
	font-size : 40pt;
	color : white;
}
.text2{
	position : absolute;
	transform: translate( 760px, -170px );
	font-size : 20pt;
	color : white;
}

/* --------------------------------------------- */
.btn1, .btn2{
	float : left;
	width : 325px;
	height : 75px;
	border : 0px;
	border-radius : 0px;
	margin-top : 50px;
	background-color : rgba( 29, 233, 182, 0.9 );
	font-family: 'Noto Sans KR', sans-serif;
}
.btn2{
	border : 0px;
	background-color : #013E8D;
}

.chkBtn:hover, .btn1:hover, .btn2:hover{
	background  : #FF7E47;
	color : white;
}
.chkBtn{
	margin : 10px;
	float : right;
	border : none;
	background-color : #1DE9B6;
	font-family: 'Noto Sans KR', sans-serif;
} 

.form-group{
	margin-top : 30px;
	margin-left: 70px;
	margin-right: 70px;
	margin-bottom : 50px;
	font-family: 'Noto Sans KR', sans-serif;
}
.signupText{
	margin-left : 70px;
	font-family: 'Noto Sans KR', sans-serif;
}
</style>

</head>
<body>

<!-- header navbar -->
<header>
<nav class="navbar navbar-expand-sm bg-white navbar-white">
	<a class="navbar-brand" href="<%= request.getContextPath() %>/view/main/mainIndex.jsp" style="color:#1DE9B6;"><img src="<%= request.getContextPath() %>/images/layout/Union.png" id="icon"> Harang</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="mainMenu">
		<ul class="nav justify-content-center" id="mainMenuList">
			<li class="nav-item">
				<div class="nav-link"  id="navBtn1">예매</div>
			</li>
        	<li class="nav-item">
				<div class="nav-link"  id="navBtn2">안내</div>
        	</li>
        	<li class="nav-item">
				<div class="nav-link"  id="navBtn3">커뮤니티</div>
        	</li>
	    	<li class="nav-item">
				<div class="nav-link"  id="navBtn4">고객센터</div>
        	</li>
		</ul>
		</div>
		<div class="col-sm-3 auto"></div>	
	</nav>
	
	
<!-- subnavbar ==> header 이미지 위로 올라와야하므로 header section에 위치 -->
	<nav>
		<div id="imageSec" >
			<div class="col-md-12" id="subMenuList" style="display:none;">
				<div class="col-md-4" style="margin-right : 50px;"></div>
				<div class="subMenuBlock">
					<ul class="subMenu">
						<li><a href="javascript:void(0)" id="goSearchAirplane">항공권 예매</a></li>
					</ul>
				</div>
				<div class="subMenuBlock">
					<ul class="subMenu">
						<li><a href="javascript:void(0)" id ="goDepart_ArrivBoardInfo">출발/도착안내</a></li>
						<li><a href="javascript:void(0)" id ="goFacilityInfo">시설안내</a></li>
						<li><a href="javascript:void(0)" id ="goParkingInfo">주차안내</a></li>
						<li><a href="javascript:void(0)" id ="goTransportinfo">대중교통안내</a></li>
					</ul>
				</div>
				<div class="subMenuBlock" style="padding-left : 30px;">
					<ul class="subMenu">
						<li><a href="javascript:void(0)" id = "goGuidboard">여행가이드</a></li>
						<li><a href="javascript:void(0)" id = "goReviewboard">여행후기</a></li>
						<li><a href="javascript:void(0)" id = "goFreeboard">자유게시판</a></li>
					</ul>
				</div>
				<div class="subMenuBlock" style="padding-left : 50px;">
					<ul class="subMenu">
						<li><a href="javascript:void(0)" id = "goNoticeboard">공지사항</a></li>
						<li><a href="javascript:void(0)" id = "goLost">분실물센터</a></li>
						<li><a href="javascript:void(0)" id = "goQuesboard">문의게시판</a></li>
					</ul>
				</div>
				<div class="col-md-4 auto"></div>
			</div>
		</div>
	</nav>
	<div class="wrap">
		<div class="cropping">
			<img src="<%= request.getContextPath() %>/images/layout/main02.png">
		</div>
		<div class="col-lg-8">
			<h1 class="text">회원가입</h1><br>
			<h3 class="text2">하랑이 날개를 달아드릴게요</h3>
		</div>
	</div>
</header>
<!-- main section -->
<section>
	<div class="container-fluid">
		<div class="row">
			<div>
			<h2 class="signupText">회원정보입력</h2>
			<br>
			<form action="<%= request.getContextPath() %>/memberJoin.do" class="needs-validation" id="regiserForm" method="post">
			<input type= "hidden" name = "job" value ="join" >
				<div class="form-group">
					<label for="uId">아이디 <span style="color:red;">*</span><span id="idChkResult"></span></label>
					<input type="text" class="form-control" placeholder="영소문자 및 숫자 5~19자리" name="mem_id" id = "mem_id" required>
					<div class="invalid-feedback">아이디를 입력해주세요.</div>
					<button type="button" class="col-sm-3 btn btn-primary chkBtn" id="idCheck" >중복체크</button>
				</div>
				<div class="form-group">
					<label for="pwd1">비밀번호 <span style="color:red;">*</span><span id="passChkResult"></span></label> 
					<input type="password" class="form-control" placeholder="영어 대소문자, 숫자, 특수문자 포함 8~14자리" name="mem_pass" id = "mem_pass" required>
					<div class="invalid-feedback">비밀번호는 특수문자를 포함한 8자리 이상으로 작성해주십시오.</div>
				</div>
				<div class="form-group">
					<label for="pwd2">비밀번호 확인 <span style="color:red;">*</span></label> 
					<input type="password" class="form-control" placeholder="비밀번호 확인" name="mem_passChk" id="mem_passChk" required>
					<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
				</div>
				<div class="form-group">
					<label for="uName">닉네임 <span style="color:red;">*</span><span id="nicknameResult"></span></label> 
					<input type="text" class="form-control" placeholder="이름" name="mem_nick" id ="mem_nick" required>
				</div>
				<div class="form-group">
					<label for="uName">이름 <span style="color:red;">*</span><span id="nameResult"></span></label> 
					<input type="text" class="form-control" placeholder="이름" name="mem_name" id ="mem_name" required>
				</div>
				<div class="form-group">
					<label for="ubir">생년월일 <span style="color:red;">*</span><span id="birResult"></span></label> 
					<input type="date" class="form-control" name="mem_bir" id = "mem_bir" max="9999-12-31" required>
				</div>
				<div class="form-group">
					<label for="umail">본인 확인 이메일 <span style="color:red;">*</span><span id="mailChkResult"></span></label> 
					<input type="text" class="form-control" placeholder="이메일" id="mem_mail"  name="mem_mail" required>
				</div>
				<div class="form-group">
					<label for="umail">이메일 인증번호 <span style="color:red;">*</span><span id = "sendednumberChk"></span></label> 
					<input type="text" class="form-control" name="mem_mailChk" id = "mem_mailChk">
					<!-- 인증번호 확인 버튼이 none으로 감춰져있으므로, 기능을 제작할때 풀고 하시기 바랍니다. -->
					<button type="button" class="col-sm-3 btn btn-primary chkBtn" id="mailNumReceive">인증번호 받기</button>
					<button type="button" class="col-sm-3 btn btn-primary chkBtn" id="mailChk">인증번호 확인</button>
				</div>
				<div class="form-group">
					<label for="ujhender">성별</label> 
					<select class="form-control" name="mem_gender">
						<option value="" selected>없음</option>
						<option value="M">남자</option>
						<option value="W">여자</option>
					</select>
				</div>
				<div class="form-group">
					<label for="uhp">휴대전화<span id = "telChkResult"></span></label> 
					<input type="text" class="form-control" name="mem_tel" id="mem_tel" placeholder="'-' 포함 13자리">
				</div>
				<!-- 회원등록 버튼을 누르면 회원가입이 완료되었다는 alert창이 뜨고 로그인 화면으로 넘겨주면 되겠습니다. - 수정완료시 이 주석은 삭제바람-->
				<button type="submit" class="col-sm-6 btn btn-primary btn1" id="regist" >회원등록</button>
				<button type="button" class="col-sm-6 btn btn-primary btn2" id="mainButton">메인으로</button>
			</form>
			</div>
		</div>
	</div>
</section>
<!-- footer section -->
<div style="margin-bottom:0; margin-top: 100px">
  	<footer>
	  	<hr/>
  			<div id="footerDiv">
  				<p>전 세계 저가 항공권을 비교하고 예약하세요</p>
				<p>ⓒ HARANG Ltd. 2022-</p>
  			</div>
  	</footer>
</div>

</body>
</html>