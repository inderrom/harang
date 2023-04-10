<%@page import="com.harang.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HARANG LOGIN</title>
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
	if(memInfo != null){
%>
		alert("잘못된 접근입니다.");
		location.href = "<%= request.getContextPath() %>/view/main/mainIndex.jsp";
<%
	}
%>
	$(function(){
		
		$('#mainMenuList li').on('mouseenter', function(){
			$('#subMenuList').slideDown();
		});
		
		$('#subMenuList').on('mouseleave', function(){
			$('#subMenuList').slideUp();
		});
		
		 window.addEventListener('load', function() {
			// Get the forms we want to add validation styles to
			var forms = document.getElementsByClassName('needs-validation');
			// Loop over them and prevent submission
			var validation = Array.prototype.filter.call(forms, function(form) {
				form.addEventListener('.btn1', function(event) {
				if (form.checkValidity() === false) {
				     event.preventDefault();
				     event.stopPropagation();
				}
				form.classList.add('was-validated');
				}, false);
			});
		}, false);
			
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
		
 		// 로그인 버튼이 눌렸을 때
  		$("#loginButton").on('click',function(){
 	 		$("#loginForm").submit();
  		});
  		 // 회원가입 버튼이 눌렸을 때
  		$("#insertButton").on('click',function(){
 	 		location.href = "signup.jsp"
  		});
  		 
  		 // -----------------------------------------------------------------------------
 		 
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
	background : linear-gradient(rgba( 29, 233, 182, 0.65 ), white)
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
	transform: translate( 840px, -200px );
	font-size : 40pt;
	color : white;
}
.text2{
	position : absolute;
	transform: translate( 760px, -170px );
	font-size : 20pt;
	color : white;
}
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
.btn1:hover, .btn2:hover{
	background  : #FF7E47;
	color : white;
}
.findId{
	box-align : top;
	margin-left : 190px;
	color : gray;
}
.findPass{
	float : right;
	margin-right : 190px;
	color : gray;
}
.form-group{
	margin-top : 30px;
	margin-left: 70px;
	margin-right: 70px;
	margin-bottom : 50px;
	font-family: 'Noto Sans KR', sans-serif;
}
.logintext{
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
						<li><a href="javascript:void(0)"  id ="goDepart_ArrivBoardInfo">출발/도착안내</a></li>
						<li><a href="javascript:void(0)"  id ="goFacilityInfo">시설안내</a></li>
						<li><a href="javascript:void(0)"  id ="goParkingInfo">주차안내</a></li>
						<li><a href="javascript:void(0)"  id ="goTransportinfo">대중교통안내</a></li>
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
			<h1 class="text">로그인</h1><br>
			<h3 class="text2">하랑과 함께 날 준비 되셨나요?</h3>
		</div>
	</div>
</header>

<!-- main section -->
<section>
	<div class="container-fluid">
		<div class="row">
				<h2 class="logintext">로그인</h2>
				<br><br>
				<form action="<%= request.getContextPath() %>/memberLogin.do" class="needs-validation" id="loginForm" method="post">
				<input type= "hidden" name = "job" value ="login" >	
					<div class="form-group">
					<label for="mem_id">아이디</label>
						<input type="text" class="form-control" id="mem_id" placeholder="아이디" name="mem_id" required>
						<div class="invalid-feedback">아이디를 입력해주세요.</div>
					</div>
					<div class="form-group">
						<label for="mem_pass">비밀번호</label> 
						<input type="password" class="form-control" id="mem_pass" placeholder="비밀번호" name="mem_pass" required>
						<div class="invalid-feedback">비밀번호는 특수문자를 포함한 8자 이상으로 작성해주십시오.</div>
					</div>
						<a href="<%= request.getContextPath() %>/view/login/findId.jsp" class="findId">아이디찾기</a>
						<a href="<%= request.getContextPath() %>/view/login/findPass.jsp" class="findPass">비밀번호 찾기</a>
					<button type="submit" class="btn btn-primary btn1" id="loginButton">로그인</button>
					<button type="button" class="btn btn-primary btn2" id= "insertButton">회원가입</button>
				</form>
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