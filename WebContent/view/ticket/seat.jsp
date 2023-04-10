<%@page import="com.harang.vo.PassengerVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
<title>HARANG SEAT BOOKING</title>
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
	if(memInfo == null){
%>
		alert("로그인이 필요합니다.");
		location.href="<%= request.getContextPath() %>/view/login/login.jsp";
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
		
	})
 </script>
  
<style>
/* 기본값 style */
#mainMenu{
	user-select : none;
}
body{
	user-select : none;
	min-width : 1600px;
	height : 100%;
	/* background : linear-gradient(rgba( 29, 233, 182, 0.65 ), white) */
}
.container-fluid{
	max-width : 1250px;
	height : initial;
	margin-top : 50px;
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
	transform: translate( 780px, -200px );
	font-size : 35pt;
	color : white;
}
.text2{
	position : absolute;
	transform: translate( 690px, -170px );
	font-size : 20pt;
	color : white;
}
.text3{
	font-family: 'Noto Sans KR', sans-serif;
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
h6{
	font-size : 10pt;
}
/*----------------------------------------------------------*/

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
.ticketBox{
	height : 125px;
	border : 1px solid gray;
	background-color : rgba( 29, 233, 182, 0.3 );
	margin : auto;
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
.arrow{
	margin-top : 45px;
	width : 40px;
	height : 40px;
}
.airplaneBox{
	margin-top : 30px;
	border : 1px solid gray;
	padding : 50px; 
	width: 890px;
}
.airplane{
	margin-left : 50px;
	width : 700px;
	height : 2270px;
}
.notice{
	border : 1px solid gray;
	margin-bottom : 30px;
	padding : 20px;
}
.notice h5{
	font-family: 'Noto Sans KR', sans-serif;
	margin-bottom : 10px;
	padding-left : 20px;
}
/* ---------------------------------------------------- */
/* 왼쪽 박스 */
.bookingLeftSide{
	margin-top: 30px;
	margin-left: 15px; 
	margin-right:30px; 
	width: 300px; 
	height: 600px;
	position : sticky;
	top : 100px;
}
.bookingUserData{
	width : 100%; 
	border : 1px solid black; 
/* 	height : 80px; */
	background-color : rgba( 29, 233, 182, 0.3 );
	margin-bottom : 15px;
	padding : 25px;
}
.bookingUserData h5{
	font-size : 15px;
	color : black;
	font-family: 'Noto Sans KR', sans-serif;
	margin :auto;
	margin-top : 20px;
	margin-bottom : 20px;
}
.bookingInfo{
	width:100%; 
	height:300px; 
	border : 1px solid black;
}
.userSeat{
	float : right;
	font-size : 18pt;
	color : #FF7E47;
	line-height: 18px;
}
.seat{
	position : absolute;
	transform : translate(180px, -1820px);
}
.seatImg{
	margin : 3px;
	cursor : pointer;
}
.seatImg2{
	display: none;
	cursor : pointer;
}
.seatImg3{
	display: none;
	pointer-events : none;
}
td{
	text-align : center;
}
.reportBtn{
	float : right;
	border : 0px;
	border-radius : 0px;
	background-color : grey;
	color : white;
	margin-top : 30px;
	width : 200px;
	height : 80px;
	font-family: 'Noto Sans KR', sans-serif;
}
.reportBtn:hover{
	background  : #FF7E47;
	color : white;
}
.seatX{
	float : right;
	margin : 5px;
	display : none;
}
.seatX:hover{
	cursor : pointer;
}
</style>

<script>

<%
	//예매 정보
	FlightVO goFlight = (FlightVO) session.getAttribute("goFlight");
	FlightVO comeFlight = (FlightVO) session.getAttribute("comeFlight");
%>
	
	$(function(){
		
		initSeat();
		getOccupiedSeat("<%= goFlight.getDate() %>", "<%= goFlight.getFli_id() %>");
		
		// 의자 선택 시 색상 변환
		$('.seatImg').on('click', function(){
			
			var seatCol = $(this).parent().attr('class');
			var seatRow = $(this).parents('tr').attr('id');
			
			var seats = $('.userSeat');
			
			$.each(seats, function(i, v){
				var seat = $(v).text();
				
				if(seat.length == 0){
					$(v).text(seatCol + seatRow);
					$(v).prev().show();
					
					return false;
				}
			});
			
			isEmpty();
			selectOn(this);
		})
		
		// 의자 선택 해제 시 색상 초기화
		$('.seatImg2').on('click', function(){
			
			var seatCol = $(this).parent().attr('class');
			var seatRow = $(this).parents('tr').attr('id');
			
			var seats = $('.userSeat');
			
			$.each(seats, function(i, v){
				var seat = $(v).text();
				
				if(seat == (seatCol + seatRow)){
					$(v).text('');
					$(v).prev().hide();
				}
			});
			
			selectOff(this);
		})
		
		// 탑승객 이름 옆의 좌석번호 x표시 선택 시 좌석 선택 해제
		$('.seatX').on('click', function(){
			var userSeat = $(this).parent().find('.userSeat');
			var seatCol = userSeat.text().substring(0, 1);
			var seatRow = userSeat.text().substring(1);
			
			var targetRow = $('#' + seatRow.trim());
			var targetSeat = $(targetRow).find('.' + seatCol);
			
			selectOff(targetSeat.find('.seatImg2'));
			
			$(this).hide();
			userSeat.empty();
			ableSeatBox();
		});
		
		// 다음 여정으로 선택 시 화면 초기화
		$('#nextBtn').on('click', function(){
			saveSeats();
		});
		
		// 편도 예매일 경우 버튼에 처음부터 좌석선택 완료라는 이름이 붙는다.
		<%
			if(comeFlight == null){
		%>
				$('#nextBtn').val('좌석선택 완료');
		<%
			}
		%>
	});
	
	// 좌석 선택 완료 후 좌석 정보 저장
	function saveSeats(){
		var flightWay = $('#nextBtn').attr('status');
		var userDatas = $('.bookingUserData h5');
		
		var seatInfo = "[";
		
		$.each(userDatas, function(i, v){
			if(i > 0) seatInfo += ", ";
			seatInfo += "{";
			seatInfo += "'pssgName' : '" + $('.pssgName', v).text() + "', ";
			seatInfo += "'pssgSeat' : '" + $('.userSeat', v).text() + "'";
			seatInfo += "}";
		});
		seatInfo +="]";
		
		$.ajax({
			url : '<%= request.getContextPath() %>/ticket.do',
			data : {
				'job' : 'saveSeat',
				'flightWay' : flightWay,
				'seatInfo' : seatInfo
			},
			type : 'post',
			success : function(res){
				
				if(res == "SUCCESS"){
					initSeat();
					nextFlight();
					
					// 오는 편 정보가 없거나 현재 선택을 끝낸 좌석이 오는 편 좌석일 경우
					if("<%= comeFlight %>" == "null" || flightWay == "comeSeat"){
						location.href = "<%= request.getContextPath() %>/view/ticket/booking.jsp";
					}
				<%
					if(comeFlight != null){
				%>
						getOccupiedSeat("<%= comeFlight.getDate() %>", "<%= comeFlight.getFli_id() %>");
				<%
					}
				%>
				} else{
					alert("잠시 후 다시 시도해주세요.");
				}
			},
			error : function(err){
				alert(err.status + " : " + err.statusText);
			},
			dataType : 'json'
		});
	}
	
	// 좌석 초기화
	function initSeat(){
		var selectedSeat = $('.airplaneBox').find('.seatImg2');
		
		$.each(selectedSeat, function(i, v){
			$(v).hide();
			$(v).parent().find('.seatImg').show();
		});
		
		$('.airplaneBox').find('.seatImg2').hide();
		$('.airplaneBox').find('.seatImg3').hide();
		$('.airplaneBox').find('.seatImg').show();
		
		ableSeatBox();
		
		$('.userSeat').text('');
	}
	
	// 이미 예약된 좌석을 표시
	function getOccupiedSeat(date, fliId){
		
		$.ajax({
			url : '<%= request.getContextPath() %>/ticket.do',
			data : {
				"job" : "occupiedSeat",
				"date" : date,
				"fliId" : fliId
			},
			type : 'post',
			success : function(res){
				
				$.each(res, function(i, v){
					
					var seat = v.pssg_seat;
					var col = seat.substring(0, 1);
					var row = seat.substring(1);
					
					var occupiedSeat = $('tr[id=' + row + ']').find('.' + col);
					$('.seatImg', occupiedSeat).hide();
					$('.seatImg3', occupiedSeat).show();
				});
				
			},
			error : function(err){
				
			},
			dataType : 'json'
		});
		
	}
	
	// 선택
	function selectOn(target){
		$(target).hide();
		$(target).closest('td').find('.seatImg2').show();
	}
	
	// 선택 해제
	function selectOff(target){
		$(target).hide();
		$(target).closest('td').find('.seatImg').show();
	}
	
	// 좌석을 선택하지 않은 탑승객이 있는지 확인
	function isEmpty(){
		var seats = $('.userSeat');
		
		$.each(seats, function(i, v){
			var seat = $(v).text();
			
			if(seat.length == 0){
				ableSeatBox(); // 선택하지 않은 탑승객이 있을 경우 좌석 선택 가능하도록 활성화
				return false;
			} else{
				disableSeatBox();
			}
		});
	}
	
	// 좌석 선택 가능
	function ableSeatBox(){
		$('.airplaneBox').css("pointer-events", "auto");
		$('.airplaneBox').css("filter", "brightness(100%)");
		
		$('#nextBtn').prop('disabled', true);
		$('#nextBtn').css('backgroundColor', 'grey');
	}
	
	// 좌석 선택 불가능
	function disableSeatBox(){
		$('.airplaneBox').css("pointer-events", "none");
		$('.airplaneBox').css("filter", "brightness(50%)");
		
		$('#nextBtn').prop('disabled', false);
		$('#nextBtn').css('backgroundColor', '#1DE9B6');
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
		<div id="imageSec" >
			<div class="col-md-12" id="subMenuList">
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
			<h1 class="text">사전 좌석배정</h1><br>
			<h3 class="text2">하랑은 함께 앉을 수 있다면 어디든 좋아요 :)</h3>
		</div>
	</div>
</header>

<!-- 메인 섹션 -->
<section>
	<div class="container-fluid">
		<div class="col-sm-12 topDiv"><h5>사전 좌석 배정</h5></div>
		<div class="col-lg-12 notice">
			<h5>* 안내드립니다.</h5>
			<h6> ＊ 항공사의 사정에 의해 자리는 변동될 수 있으며, 사전 안내를 통해 불편이 없도록 최선을 다하겠습니다.</h6>
			<h6> ＊ 본 좌석선택 페이지는 무료좌석의 배정만 가능하며, 유료좌석은 항공사의 안내데스크를 이용해주십시오.</h6>
			<h6> ＊ 좌석의 취소를 하시게되면 좌석사전배정의 선택불가상태가 해제되기까지 시간이 걸리므로, 양해부탁드립니다.</h6>
			<h6> ＊ 그 밖의 문의사항은 항공사의 안내데스크, 안내전화, 문의게시판을 이용해 주시면 감사하겠습니다.</h6>
			<h6> ＊ 항공사 안내전화번호 : 010 - 9117 - 7548 /<span style="margin-left: 10px;"><a href="">문의게시판 이동</a></span></h6>
		</div>
		
		<%
			// 탑승자 목록
			List<PassengerVO> pssgList = new ArrayList<>();

			List<?> tempPssgList = (List<?>) session.getAttribute("pssgList");
			for(Object obj : tempPssgList){
				if(obj instanceof PassengerVO){
					pssgList.add((PassengerVO) obj);
				}
			}
		%>
		<script>
				
				// 왕복 예매일 경우 오는 편 좌석도 선택
				function nextFlight(){
			<%
					if(comeFlight != null){
			%>
						var comeFlightDep = "<%= comeFlight.getFli_depport() %>";
						var comeFlightArr = "<%= comeFlight.getFli_arrport() %>";
						
						// 항공편 출도착지를 오는 편으로 바꾼다.
						$('#depport>h5').text(comeFlightDep);
						$('#arrport>h5').text(comeFlightArr); 
						
						// 항공편 정보
						var flightInfo = "<%= comeFlight.getFli_id() %>&nbsp;&nbsp;<%= comeFlight.getAirline_name() %><br><%= comeFlight.getDate() %> <%= comeFlight.getFli_deptime().substring(0, 2) + ":" + comeFlight.getFli_deptime().substring(2) %>";
						$('#flightInfo>h5').html(flightInfo);
						
						$('#nextBtn').val('좌석선택 완료');
						$('#nextBtn').attr('status', 'comeSeat');
			<%
					}
			%>
				}
		</script>
		<div class="col-sm-12 row ticketBox">
			<div class="col-sm-3 depart_arriv" id="depport"><h5><%= goFlight.getFli_depport() %></h5></div>
			<img src="<%= request.getContextPath() %>/images/ticket/arrow-right.png" class="arrow">
			<div class="col-sm-3 depart_arriv" id="arrport"><h5><%= goFlight.getFli_arrport() %></h5></div>
			
			<div class="col-sm-5 airplaneCode" id="flightInfo"><h5><%= goFlight.getFli_id() %>&nbsp;&nbsp;<%= goFlight.getAirline_name() %><br><%= goFlight.getDate() %> <%= goFlight.getFli_deptime().substring(0, 2) + ":" + goFlight.getFli_deptime().substring(2) %></h5></div>	
		</div>
		<div>
			<div class="row">
				<div class="col-xs-3 bookingLeftSide">
					<div class="bookingUserData">
						<%
							for(int i = 0; i < pssgList.size(); i++){
								PassengerVO pssgVo = pssgList.get(i);
								String name = pssgVo.getPssg_name();
						%>
								<h5><%= i + 1 %>. <span class="pssgName"><%= name %></span><span class="seatX">x</span><span class="userSeat"></span></h5>
						<%
							}
						%>
					</div>
					<!-- 예비로 넣어봄 <div class="bookingUserData"></div> -->
					<div class="bookingInfo"><img src="<%= request.getContextPath() %>/images/ticket/좌석배치안내문.png"></img></div>
					<input status="goSeat" type="button" class="btn btn-primary btn-lg reportBtn" id="nextBtn" value="다음 여정으로" disabled>
				</div>
				<div class="col-xs-7 airplaneBox">
					<h4 class="text3">좌석 선택</h4>
					<img src="<%= request.getContextPath() %>/images/ticket/airplane.png" class="airplane">
					<table class="seat">
						<tr>
							<td><h5>A</h5></td>
							<td><h5>B</h5></td>
							<td><h5>C</h5></td>
							<td style="width: 80px;"></td>
							<td><h5>D</h5></td>
							<td><h5>E</h5></td>
							<td><h5>F</h5></td>
						</tr>
						<tr id="01">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align : center;"><h5>1</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="02">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>2</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="03">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>3</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="04">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>4</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="05">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>5</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="06">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>6</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="07">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>7</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="08">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>8</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="09">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>9</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="10">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>10</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="11">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>11</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="12">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>12</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="13">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>13</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="14">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>14</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
					
				<!-- 14개 테이블 -->
						<tr>
						<td style="height: 50px;"></td>
						</tr>
						<tr id="15">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>15</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr>
						<td style="height: 80px;"></td>
						</tr>
						<tr id="16">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>16</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>	
						<tr id="17">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>17</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>	
						<tr id="18">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>18</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>	
						<tr id="19">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>19</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="20">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>20</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="21">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>21</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="22">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center;"><h5>22</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="23">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>23</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="24">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>24</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
						<tr id="25">
							<td class="A">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="B">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="C">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td style="width : 80px; text-align: center"><h5>25</h5></td>
							<td class="D">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="E">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
							<td class="F">
								<img src="<%= request.getContextPath() %>/images/ticket/테두리 의자.png" class="seatImg"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/호버링 붉은색의자.png" class="seatImg2"></img>
								<img src="<%= request.getContextPath() %>/images/ticket/회색의자.png" class="seatImg3"></img>
							</td>
						</tr>
					</table>
				</div>
				</div>
			</div>
<!-- 			<input type="button" class="btn btn-primary btn-lg reportBtn" value="다음 여정으로"> -->
		</div>
</section>

<!-- footer section -->
<div style="margin-bottom:0; margin-top: 400px">
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