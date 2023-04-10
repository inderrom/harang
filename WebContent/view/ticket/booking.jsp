<%@page import="java.util.Date"%>
<%@page import="com.harang.vo.PassengerVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.harang.vo.FlightVO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.harang.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HARANG</title>
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
 
 <script src="<%= request.getContextPath() %>/js/jquery.serializejson.js"></script>
 <script>
 
<%
	MemberVO memInfo = (MemberVO) session.getAttribute("memInfo");
	if(memInfo == null){
%>
		alert("로그인이 필요합니다.");
		location.href="<%= request.getContextPath() %>/view/login/login.jsp";
<%
	}
%>
 
	$(function(){
		//	이 예매-결제페이지의 아래 세 코드는 버튼이 아닌 cursor : pointer만 먹여놓은 상태입니다.
		// <div class="col-2 backBtn">← 뒤로가기</div>
		// <div class="col-sm-12 headText"><h4>결제
		// <div class="payment"><h4>결제하기</h4></div>
		// id="" 뚫어놨으니깐 쓰세요~
		
		
		
		$('#mainMenuList li').on('mouseenter', function(){
			$('#subMenuList').slideDown();
		});
		
		$('#subMenuList').on('mouseleave', function(){
			$('#subMenuList').slideUp();
		});
//-------------------------------------------------------		
		$('.box2').on('mouseenter', function(){
			$('.box2').hide();
			$('.boxInfo').show();
		});
		$('.boxInfo').on('mouseleave', function(){
			$('.box2').show();
			$('.boxInfo').hide();
		});
//--------------------------------------------------------
		// 탑승객 정보 폼의 확인 버튼 클릭 시
		$('.check').on('click', function(){
			var form = $(this).parents('.userInfo');
			var lName = form.find('input[name=mem_lName]').val();
			var fName = form.find('input[name=mem_fName]').val();
			var bir = form.find('input[name=mem_bir]').val();
			
			var nameReg = /[A-Z]/;
			
			if(lName == "" || fName == "" || bir == ""){
				alert("이름, 생년월일을 입력해주세요.");
				return false;
			}
			
			if(!nameReg.test(lName) || !nameReg.test(fName)){
				alert("이름은 영문 대문자로 입력해주세요.");
				return false;
			}
			
			lockPssgForm(this);
			checkPssgForm();
		})
		
		// 탑승객 폼의 다시 입력하기 클릭 시
		$('.reWrite').on('click', function(){
			unlockPssgForm(this);
			checkPssgForm();
		})
		
		// ---------------------------------------------------------------------

		
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
	
	// 확인 클릭 시 탑승자 정보 폼 잠김
	function lockPssgForm(target){
		$(target).closest('.userInfo').find('.form-control').prop('readonly', true);
		$(target).hide();
		$(target).next('.reWrite').show();
	}
	
	// 다시 입력하기 클릭 시 탑승자 정보 폼 잠금해제
	function unlockPssgForm(target){
		$(target).closest('.userInfo').find('.form-control').prop('readonly', false);
		$(target).prev('.check').show();
		$(target).hide();
	}
	
	
 </script>
  
<style>
/* 기본값 style */
#mainMenu{
	user-select : none;
}
body{
	min-width : 1600px;
	height : 100%;
/* 	background : linear-gradient(rgba( 29, 233, 182, 0.65 ), white) */
}
.container-fluid{
	max-width : 1250px;
	margin-top : 10px;
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
.topDiv{
	height : 50px;
/* 	background-color : #013E8D; */
/* 	background-color : rgba( 29, 233, 182, 0.9 ); */
	background-color : #0C654F;
	text-align : center;
	padding-top : 11px; 
	margin-bottom : 30px;
	color : white;
	font-family: 'Noto Sans KR', sans-serif;
}
.backBtn{
	cursor : pointer;
	text-align : left;
}
/*---------------------------------*/
#ulBox{
	padding : 50px;
	margin : auto;
}
.facilityList { 
    list-style-type :none;
    padding:0px;
    margin-top: 30px;
    margin-left : 0px;
  	margin :auto;
 	padding :0px;
 	text-align : center;
} 
#list{ 
	display : inline-block;
    margin-top: 50px;
    margin : 20px;
 	padding :0px;
} 
.divstyle{ 
	 width: 3000px; 
	 margin-right: 29%; 
} 
#search{ 
	 margin-left: 700px; 
} 
/* 가는편 오는편 확인 */
.headText{
	margin-top : 30px;
	margin-bottom : 50px;
	font-family: 'Noto Sans KR', sans-serif;
}
.headText2{
	margin-top: 30px;
	margin-bottom : 10px;
	font-family: 'Noto Sans KR', sans-serif;
}
.ticketBox{
	height : 125px;
	border : 1px solid gray;
 	background-color : rgba( 29, 233, 182, 0.3 );
	margin : auto;
}
.arrow{
	margin-top : 45px;
	width : 40px;
	height : 40px;
}
.depart_arriv{
	height : 95px;
	text-align : center;
	padding-top : 50px;
	font-size : 1.3em;
	font-family: 'Noto Sans KR', sans-serif;
}
.airplaneCode{
	height : 85px;
	margin : auto;
	padding-top : 15px;
	padding-left : 100px;
	
	font-size : 1.2em;
	font-family: 'Noto Sans KR', sans-serif;
	border-left : 1px solid gray;
}
.departText{
	padding-top : 30px;
	font-family: 'Noto Sans KR', sans-serif;
}

/* 결제창 style --------------------------*/
.tex{
	float: right;
}
.tex2{
	float: right;
}
.fee{
	margin : 0px;
	padding : 0px;
}
.fee li{
	list-style-type: none;
}
.charge{
	font-family: 'Noto Sans KR', sans-serif;
	position : sticky;
	top : 100px;
	padding : 10px;
}
.payment{
	width : 100%; 
	height : 100px; 
	background-color : #1DE9B6; 
	color : white;
	text-align : center;
	padding-top : 35px;
	font-family: 'Noto Sans KR', sans-serif;
	cursor : pointer;
}
/* ------------------------------------------- */
/* 승객정보 스타일----------------------------- */
.form-group{
	font-family: 'Noto Sans KR', sans-serif;
}
.check{
	font-family: 'Noto Sans KR', sans-serif;
	border-radius : 0px;
	background-color : #1DE9B6;
	border : none;
}
.reWrite{
	font-family: 'Noto Sans KR', sans-serif;
	border-radius : 0px;
	background-color : #1DE9B6;
	border : none;
	display : none;
}
/* ------------------------------------------------ */
.boxText{
	color : #1DE9B6;
	font-family: 'Noto Sans KR', sans-serif;
	margin-top : 25px;
}
.box, .box2{
	cursor : pointer;
	margin : 100px 20px 100px 20px;
	border:4px solid #1DE9B6; 
	border-radius : 10px; 
	height:200px; 
	text-align : center; 
	padding-top : 40px;
}
.boxInfo0{
	cursor : pointer;
	margin : 100px 20px 100px 20px;
	border:4px solid gray; 
	border-radius : 10px; 
	height:200px; 
	text-align : center; 
	padding-top : 50px;
	display : none;
	
	color : gray;
	font-family: 'Noto Sans KR', sans-serif;
}
.h4textStyle{
	font-size : 25pt;
	color : #FF7E47;
}
.reWrite:hover, .check:hover{
	background-color : #FF7E47;
}
.box:hover{
	background-color : rgba( 29, 233, 182, 0.3 );
}
.boxInfo{
	cursor : pointer;
	margin : 100px 20px 100px 20px;
	border:4px solid gray; 
	border-radius : 10px; 
	height:200px; 
	text-align : center; 
	padding-top : 10px;
	display : none;
	
	font-family: 'Noto Sans KR', sans-serif;
	color : gray;
}
.boxInfo2{
	 margin-top: 30px; 
	 height:350px; 
	 border:1px solid gray;
}
.boxInfo3{
	 margin-top: 50px; 
	 padding : 10px auto; 
	 height:450px;
	 border:1px solid gray; 
}
.boxInfo4{
	 margin-top: 50px; 
	 padding : 10px auto; 
	 border:1px solid gray; 
	 height:100px; 
	 display : inline-block;
}
#logout{
	padding : 0px;
	margin-left : 12px;
	margin-right : 5px;
	border : none;
	background-color : white;
}
#profile{
	border: none;
	background-color : white;
}
.profile h5{
	margin-left : 20px;
	font-size : 15pt;
	font-family: 'Noto Sans KR', sans-serif;
}

/*  좌석선택 버튼을 누르고 좌석예매버튼에 갔다오면 내가 선택한 좌석이 나오도록 한다. */
.seatText{
	font-family: 'Noto Sans KR', sans-serif;
	font-size : 18px;
	color : #FF7E47;
}
#seatAlert{
	display : none;
}
#seatAlertText{
	color : red;
}
</style>
<script>
<%
	//탑승자 목록
	List<PassengerVO> pssgList = new ArrayList<>();

	List<?> tempPssgList = (List<?>) session.getAttribute("pssgList");
	if(tempPssgList != null){
		for(Object obj : tempPssgList){
			if(obj instanceof PassengerVO){
				pssgList.add((PassengerVO) obj);
			}
		}
	}
	
	// --------------------------------------------------------
	
	// 가는 편 좌석 정보
	List<PassengerVO> goSeatList = new ArrayList<>();
	List<?> tempGoSeatList = (List<?>) session.getAttribute("goSeat");
	
	if(tempGoSeatList != null){
		for(Object obj : tempGoSeatList){
			if(obj instanceof PassengerVO){
				goSeatList.add((PassengerVO) obj);
			}
		}
	}
	
	
	// 오는 편 좌석 정보
	List<PassengerVO> comeSeatList = new ArrayList<>();
	List<?> tempComeSeatList = (List<?>) session.getAttribute("comeSeat");
	
	if(tempComeSeatList != null){
		for(Object obj : tempComeSeatList){
			if(obj instanceof PassengerVO){
				comeSeatList.add((PassengerVO) obj);
			}
		}
	}
	
%>
	$(function(){
		
		
		
		var userInfo = $('.userInfo');
		<%
			// 탑승자 정보 꺼내오기
			if(pssgList != null && pssgList.size() > 0){
				for(int i = 0; i < pssgList.size(); i++){
					PassengerVO pssgVo = pssgList.get(i);
					
					String fullName = pssgVo.getPssg_name(); // 풀 네임
					String fName = fullName.split(" ")[0]; // 영어 성 씨
					String lName = fullName.split(" ")[1]; // 영어 이름
					
					String bir = pssgVo.getPssg_bir(); // 생일
					
					PassengerVO goSeatVo = goSeatList.get(i); // 가는 편 좌석 번호
					
					// -> 0번째 탑승객 : 0번째 좌석번호
					// -> 1번째 탑승객 : 1번째 좌석번호...
					
					// 해당 탑승자의 좌석 정보 가져오기
					String goSeatNum = goSeatVo.getPssg_seat();
					
					// 왕복일 경우 오는 편 좌석 정보도 가져온다.
					String comeSeatNum = "";
					if(comeSeatList != null && comeSeatList.size() > 0){
						PassengerVO comeSeatVo = comeSeatList.get(i);
						comeSeatNum = comeSeatVo.getPssg_seat();
					}
		%>
						// 탑승자 정보 & 좌석 정보 출력
						$(userInfo[<%= i %>]).find('input[name=mem_lName]').val('<%= lName %>');
						$(userInfo[<%= i %>]).find('input[name=mem_fName]').val('<%= fName %>');
						$(userInfo[<%= i %>]).find('input[name=mem_bir]').val('<%= bir %>');
						$(userInfo[<%= i %>]).find('.goSeat').text('<%= goSeatNum %>');
						<%
						if(comeSeatNum != null && !comeSeatNum.equals("")){
						%>
							$(userInfo[<%= i %>]).find('.comeSeat').text('<%= comeSeatNum %>');
						<%
						}
						%>
						lockPssgForm($(userInfo[<%= i %>]).find('.check'));
		<%
				}
			}
		%>
		
		var goSeatInfo = $('.userInfo').find('.goSeat').text();
		
		// 좌석을 선택하지 않았을 경우
		if(goSeatInfo == ""){
			$('.payment').prop('disabled', 'true');
			$('.payment').css('pointerEvents', 'none')
			$('.payment').css('background-color', 'grey');
			$('.payment').css('cursor', 'auto');
			$('#seatAlert').show();
		}
		
		// 좌석 선택 클릭 시
		$('#toSeat').on('click', function(){
			savePssg("toSeat");
		});
		
		// 결제 버튼 클릭 시
		$('.payment').on('click', function(){
			savePssg("toPayment");
		});
		
		// 탑승객 정보를 세션에 저장
		function savePssg(nextPage){
			
			var userInfo = $('.userInfo');
			var userInfoList = new Array();
			
			$.each(userInfo, function(i, v){
				userInfoList.push(JSON.stringify($(v).serializeJSON()));
			});
			
			$.ajax({
				url : '<%= request.getContextPath() %>/ticket.do',
				data : {
					"job" : "savePssg",
					"userInfoList" : userInfoList
				},
				type : 'post',
				traditional : 'true',
				success : function(res){
					
					if(res == "SUCCESS"){
						
						switch(nextPage){
						case "toSeat":
							location.href="<%= request.getContextPath() %>/view/ticket/seat.jsp";
							break;
						case "toPayment":
							payment();
							break;
						}
					} else{
						alert("잠시 후 다시 시도해주세요.");
					}
					
				},
				error : function(err){
					alert(err.status + " : " + err.statusText);
				},
				dataType : "json"
			});
			
		}
		
		
		// 결제창 변수
		var payWin;
		
		// 결제 처리
		function payment() {
			
			var price = $('.tex2').text();
			price = price.replace(/[^0-9]/g ,'');
			
			$.ajax({
				url : '<%= request.getContextPath() %>/ticket.do',
				data : {
					'job' : 'payment',
					'price' : price
				},
				type : 'post',
				success : function(res){
					payWin = window.open(res, "_blank", "width=800,height=800,status=no,scrollbars=no");
				},
				error : function(err){
					alert("잠시 후 다시 시도해주세요.");
				},
				dataType : 'json'
			});
		}
		
		// 최초 페이지 연결 시 탑승객 폼이 모두 작성되었는지 확인
		checkPssgForm();
		birthdayLimit();
	});
	
	
	// 생후 7일 초과부터만 탑승할 수 있다.
	function birthdayLimit(){
		
		var today = new Date();
		var limitDateForm = new Date(
				today.getFullYear(),
				today.getMonth(),
				(today.getDate() - 7)
			);
		
		var limitMonth = (limitDateForm.getMonth() + 1) < 10 ?  "0" + (limitDateForm.getMonth() + 1) : (limitDateForm.getMonth() + 1);
		var limitDate = limitDateForm.getDate() < 10 ? "0" + limitDateForm.getDate() : limitDateForm.getDate();
		
		var limitday = limitDateForm.getFullYear() + "-" + limitMonth + "-" + limitDate;
		
		$('input[name=mem_bir]').attr('max', limitday);
	}
	
	// 탑승객 폼이 모두 작성되었는지 확인
	function checkPssgForm(){
		var forms = $('.userInfo').find('.check:visible');
		
		if(forms.length > 0){
			disableToSeat();
		} else{
			ableToSeat();
		}
	}
	
	// 탑승객 정보 폼 작성을 완료하면 좌석 선택 가능
	function ableToSeat(){
		$('#toSeat').css('filter', 'none');
		$('#toSeat').css('pointer-events', 'auto');
		
		$('#toSeat').find('.boxText').text('좌석 선택');
	}
	
	// 탑승객 정보 폼 작성을 완료하지 않으면 좌석 선택이 불가능
	function disableToSeat(){
		$('#toSeat').css('filter', 'brightness(10%)');
		$('#toSeat').css('pointer-events', 'none');
		
		$('#toSeat').find('.boxText').text('승객 정보를 작성해주세요.');
	}
	
</script>
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
		<%
			if(memInfo != null && memInfo.getMem_name() != null){
		%>
			<!-- 로그인 되었을때 -->
			<div class="col-md-3 row profile">
			<button type="button" id="logout" ><img src="<%= request.getContextPath() %>/images/layout/logout.png"></button>
			<button type="button" id="profile" ><img src="<%= request.getContextPath() %>/images/layout/profile.png"></button>
			<h5><%=memInfo.getMem_name() %>님 환영합니다.</h5>
			</div>
		<%
			}else{
		%>
			<!-- 로그인 되지 않았을때 -->
			<button type="button" class="btn btn-primary" id="login" onclick="location.href='<%= request.getContextPath()%>/view/login/login.jsp'">LOGIN</button>	
		<%
			}
		%>
	</nav>
	
<!-- subnavbar ==> header 이미지 위로 올라와야하므로 header section에 위치 -->
	<nav>
		<div id="imageSec">
			<div class="col-md-12" id="subMenuList" style="display : none">
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
	<!-- 메인이미지  -->
	<div class="wrap">
		<div class="cropping">
			<img src="<%= request.getContextPath() %>/images/layout/main02.png">
		</div>
	</div>
</header>

<%
	// 예매 항공편 정보
	
	// 가는 편
	FlightVO goFlight = (FlightVO) session.getAttribute("goFlight");
	// 오는 편
	FlightVO comeFlight = (FlightVO) session.getAttribute("comeFlight");
%>
<section class="infoList">
<div class="container-fluid">
	<div class="col-sm-12 row topDiv">
		<div class="col-2 backBtn" id="">← 뒤로가기</div>
		<div class="col-3"></div>
		<h5>예매정보확인 · 결제</h5>
	</div>
	<div class="col-sm-12 row">
		<div class="col-sm-12 headText2"><h3>여정 정보</h3></div>
		<div class="departText"><h5>가는 편</h5></div>
		<div class="col-sm-12 row ticketBox">
			<div class="col-sm-3 depart_arriv"><h5><%= goFlight.getFli_depport() %></h5></div>
			<img src="<%= request.getContextPath() %>/images/ticket/arrow-right.png" class="arrow">
			<div class="col-sm-3 depart_arriv"><h5><%= goFlight.getFli_arrport() %></h5></div>
		
			<div class="col-sm-4 airplaneCode"><h5><%= goFlight.getFli_id() %>&nbsp;&nbsp;<%= goFlight.getAirline_name() %><br><%= goFlight.getDate() %> <%= goFlight.getFli_deptime().substring(0, 2) + ":" + goFlight.getFli_deptime().substring(2) %></h5></div>	
		</div>
	
	<%
		if(comeFlight != null){
	%>
			<div class="departText"><h5>오는 편</h5></div>
			<div class="col-sm-12 row ticketBox">
				<div class="col-sm-3 depart_arriv"><h5><%= comeFlight.getFli_depport() %></h5></div>
				<img src="<%= request.getContextPath() %>/images/ticket/arrow-right.png" class="arrow">
				<div class="col-sm-3 depart_arriv"><h5><%= comeFlight.getFli_arrport() %></h5></div>
				
				<div class="col-sm-4 airplaneCode"><h5><%= comeFlight.getFli_id() %>&nbsp;&nbsp;<%= comeFlight.getAirline_name() %><br><%= comeFlight.getDate() %> <%= comeFlight.getFli_deptime().substring(0, 2) + ":" + comeFlight.getFli_deptime().substring(2) %></h5></div>	
			</div>
	<%
		}
	%>
<!-- 			<div class="col-sm-12 depart_arriv">오는 편에 대한 정보가 존재하지 않습니다.</div> -->
		
	</div>
	
	<div class="col-sm-12 row">
	
	<!-- 승객정보를 늘리고 싶다면 여기서부터 복사해서 -->
		<div class="col-sm-9">
			<form action="/action_page.php" class="needs-validation userInfo" style="border : 1px solid gray; padding : 30px; margin-top : 60px;" novalidate >
			<div class="col-sm-12 headText"><h3>승객 정보</h3></div>
				<div class="form-group">
					<label>이름 <span style="color:red;">*</span></label> 
<!-- 					<p>홍길동 </p> -->
<!-- 					<hr/> -->
					<div class="col-12 row">
					<!-- 성과 이름으로 나누어져있으니 name 값을 이용해 사용하시기바랍니다-->
						<input type="text" class="col-6 form-control" placeholder="영문 이름" name="mem_lName" required>
						<input style="margin-left : 10px;" type="text" class="col-5 form-control" placeholder="영문 성" name="mem_fName" required>
					</div>
				</div>
			
				<div class="form-group">
					<label>생년월일 <span style="color:red;">*</span></label> 
					<div class="col-12 row">
						<input type="date" class="form-control" placeholder="생일" name="mem_bir" max="9999-12-31" required>
					</div>
				</div>
			
<!-- 				<div class="form-group"> -->
<!-- 					<label for="ugender">성별 <span style="color:red;">*</span></label>  -->
<!-- 					<select class="form-control" name="mem_gender"> -->
<!-- 						<option value="man">남자</option> -->
<!-- 						<option value="woman">여자</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
				
				<div class="form-group">
					<hr/>
					<p>좌석</p>
					<span class="seatWay">가는 편 : </span>
					<span class="seatText goSeat"></span><br>
					
					<%
						if(comeFlight != null){
					%>
						<span class="seatWay">오는 편 : </span>
						<span class="seatText comeSeat"></span> 
					<%
						}
					%>
					<hr/>
				</div>
			
				<button type="button" class="col-sm-3 btn btn-primary check">확인</button>	
				<button type="button" class="col-sm-3 btn btn-primary reWrite">다시 입력하기</button>			
			</form>
		</div>
		<!-- 여기까지 ctrl+c, 결제창 끝 아래에 ctrl+v 하면 됨 --> 
	
	
	<%
		// 가는 편 가격
		int goPrice = goFlight.getFli_price();
	
		// 예매 인원
		int count = goFlight.getCount();
		
		DecimalFormat df = new DecimalFormat("###,###,###");
		
		// 왕복편일 경우
		int comePrice = 0;
		if(comeFlight != null){
			comePrice = comeFlight.getFli_price();
		}
		
		// 가격 총합
		int totalPrice = (goPrice + comePrice) * count;
		
		// 세금은 10%
		int ticketPrice = (int) (Math.floor((((double) totalPrice / 10) * 9) / 100) * 100);
		int tax = totalPrice - ticketPrice;
	%>
		<!-- 결제창 -->
		<div class="col-sm-3 charge">
			<hr/>
				<h5>항공 운송료</h5>
				<ul class="fee">
					<li>운임<span class="tex"><%= df.format(ticketPrice) %>원</span></li>
					<li>세금, 수수료 및 기타 요금<span class="tex"><%= df.format(tax) %>원</span></li>
				</ul>
			<hr/>
			<div><strong>총액</strong><span class="tex2"><%= df.format(totalPrice) %>원</span></div>
			<hr/>
			<div class="payment" id="">
				<h4>결제하기</h4>
			</div>
			<div id="seatAlert"><span id="seatAlertText">* 좌석을 선택해주세요.</span></div>
		</div>
		<!-- 결제창 끝... -->
	<%
		for(int i = 2; i <= count; i++){
	%>
		<!-- 승객정보를 늘리고 싶다면 여기서부터 복사해서 -->
		<div class="col-sm-9">
			<form action="/action_page.php" class="needs-validation userInfo" style="border : 1px solid gray; padding : 30px; margin-top : 60px;" novalidate >
			<div class="col-sm-12 headText"><h3>승객 정보</h3></div>
				<div class="form-group">
					<label for="uName">이름 <span style="color:red;">*</span></label> 
<!-- 					<p>홍길동 </p> -->
<!-- 					<hr/> -->
					<div class="col-12 row">
					<!-- 성과 이름으로 나누어져있으니 name 값을 이용해 사용하시기바랍니다-->
						<input type="text" class="col-6 form-control" placeholder="영문 이름" name="mem_lName" required>
						<input style="margin-left : 10px;" type="text" class="col-5 form-control" placeholder="영문 성" name="mem_fName" required>
					</div>
				</div>
			
				<div class="form-group">
					<label for="uBir">생년월일 <span style="color:red;">*</span></label> 
					<div class="col-12 row">
						<input type="date" class="form-control" placeholder="생일" name="mem_bir" max="9999-12-31" required>
					</div>
				</div>
			
<!-- 				<div class="form-group"> -->
<!-- 					<label for="ugender">성별 <span style="color:red;">*</span></label>  -->
<!-- 					<select class="form-control" name="mem_gender"> -->
<!-- 						<option value="man">남자</option> -->
<!-- 						<option value="woman">여자</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
				
				<div class="form-group">
					<hr/>
					<p>좌석</p>
					<span class="seatWay">가는 편 : </span>
					<span class="seatText goSeat"></span><br>
					<span class="seatWay">오는 편 : </span>
					<span class="seatText comeSeat"></span> 
					<hr/>
				</div>
			
				<button type="button" class="col-sm-3 btn btn-primary check">확인</button>	
				<button type="button" class="col-sm-3 btn btn-primary reWrite">다시 입력하기</button>			
			</form>
		</div>
		<!-- 여기까지 ctrl+c, 결제창 끝 아래에 ctrl+v 하면 됨 --> 
		
	<%
		}
	%>
		<!-- 승객정보를 늘리고 싶다면 여기서부터 복사해서 -->
<!-- 			<div class="col-sm-9"> -->
<!-- 			<form action="/action_page.php" class="needs-validation userInfo" style="border : 1px solid gray; padding : 30px; margin-top : 60px;" novalidate > -->
<!-- 			<div class="col-sm-12 headText"><h3>승객 정보 2</h3></div> -->
<!-- 				<div class="form-group"> -->
<!-- 					<label for="uName">이름 <span style="color:red;">*</span></label>  -->
<!-- 					<p>홍길동 </p> -->
<!-- 					<hr/> -->
<!-- 					<div class="col-12 row"> -->
					<!-- 성과 이름으로 나누어져있으니 name 값을 이용해 사용하시기바랍니다-->
<!-- 						<input type="text" class="col-6 form-control" placeholder="영문 이름" name="mem_name" required> -->
<!-- 						<input style="margin-left : 10px;" type="text" class="col-5 form-control" placeholder="영문 성" name="mem_name" required> -->
<!-- 					</div> -->
<!-- 				</div> -->
				
<!-- 				<div class="form-group"> -->
<!-- 					<label for="uName">생년월일 <span style="color:red;">*</span></label>  -->
<!-- 					<div class="col-12 row"> -->
<!-- 						<input type="date" class="form-control" placeholder="생일" name="mem_bir" required> -->
<!-- 					</div> -->
<!-- 				</div> -->
			
<!-- 				<div class="form-group"> -->
<!-- 					<label for="ujhender">성별 <span style="color:red;">*</span></label>  -->
<!-- 					<select class="form-control" name="mem_gender"> -->
<!-- 						<option value="man">남자</option> -->
<!-- 						<option value="woman">여자</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
				
<!-- 				<div class="form-group"> -->
<!-- 					<p>좌석</p> -->
<!-- 					<span class="seatText"></span>  -->
<!-- 					<hr/> -->
<!-- 				</div> -->
				
<!-- 				<button type="button" class="col-sm-3 btn btn-primary check">확인</button>	 -->
<!-- 				<button type="button" class="col-sm-3 btn btn-primary reWrite">다시 입력하기</button>			 -->
<!-- 			</form> -->
<!-- 		</div> -->
		<!-- 여기까지 ctrl+c, 이 아래에 ctrl+v 하면 됨 그리고 승객정보의 숫자 1개씩 올려주셈--> 
		
		<div id="toSeat" class="col-sm-4 box" >
			<img src="<%= request.getContextPath() %>/images/ticket/seat.png" style="width : 75px; height : 75px;">
			<h5 class="boxText">좌석 선택</h5>
		</div>
		
		<div class="col-sm-4 box2">
		<img src="<%= request.getContextPath() %>/images/ticket/travel-luggage.png" style="width : 75px; height : 75px;">
			<h5 class="boxText">초과 수화물</h5>
		</div>
		<!-- 초과수화물 버튼을 누르면 아래 안내문이 나온다 -->
		<div class="col-sm-4 boxInfo">
			<h5>초과 수화물</h5>
			<h6>초과된 수화물은 각 항공사의 안내데스크에서 티켓을 발급받은뒤 수화물에 부착하고 수화물 비행기를 이용 바랍니다
			<br><br>이에 따라 발생하는 초과금은 하랑이 아닌 각 항공사에서 결제해주시기 바랍니다.
			</h6>
		</div>
		
		<div class="col-sm-9 boxInfo2">
			<div class="col-sm-12 headText"><h3>유의사항 전달 및 확인</h3></div>
			<div class="col-sm-12">
				<h5>[필수]운송약관, 수하물에 대한 안내문을 확인하셨나요?</h5>
				<h6>하랑의 항공권을 구매하시는 것은 각 항공사들과의 계약을 체결하는데 동의하는것으로 운임규정은 항공권 변경, 취소 등에 따른
				수수료와 사전 좌석배정, 좌석승급등 구매하는 항공 운임조건에 대한 조건을 기재하고있으며, 계약 체결에 따른 계약조건을 명시합니다.</h6>
				<hr/>
			
				<h5>[필수]위험품 안내문을 확인 하셨나요?</h5>
				<h6>고객의 안전을 위하여 항공기 내부로 반입이 금지된 폭발성, 인화성, 유독성 물질 및 품목에 대한 안내문을 필독해주십시오. </h6>
				<hr/>
			</div>
		</div>
		
		<div class="col-sm-9 boxInfo3">
			<div class="col-sm-12 headText"><h4>출입국 규정 및 구비서류 안내</h4></div>
			<div class="col-sm-12">
				<h5>[필수]출입국 규정 조회</h5>
				<h6>하랑에서 결제하신 고객님들은 각 항공사에서 제공하는 출입국 주요 제한사항을 참고하여 주시기바랍니다.</h6>
				<hr/>
			
				<h5>대한민국 무사증 입국시 K-ETA사전 신청 의무화 안내</h5>
				<h6>대한민국에 비자없이 입국이 가능한 외국인들은 출발 24시간 전까지 <a href="https://www.k-eta.go.kr">www.k-eta.go.kr</a>또는 모바일 앱(K_ETA)
				를 통해 K-ETA를 발급받은 뒤 입국이 가능합니다.</h6>
				<hr/>
			
				<h5>Q-CODE(검역정보사전입력시스템) 등록 안내</h5>
				<h6>대한민국 입국시 <a href="https://cov19ent.kdca.go.kr/cpassportal/">Q-Code(Quarantine Infomation Pre-Entry)</a>를 이용하여 
				입국 전 사전입력을 완료해주시기바랍니다.</h6>
				<hr/>
			</div>
		</div>
		
		<div class="col-sm-9 boxInfo4">
			<div class="col-sm-12 headText" id=""><h4>결제<img src="<%= request.getContextPath() %>/images/ticket/카카오페이.png" style="margin-left : 20px; width : 80px; height: 30px"></h4></div>
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