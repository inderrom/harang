<%@page import="com.harang.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>HARANG : 하늘을 함께 날다</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
 
  <!-- Bootstrap 적용 -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
  <!-- icon -->
  <link rel="icon" href="<%= request.getContextPath() %>/images/layout/Union.png">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/navbar.css">
  
  <!-- 폰트적용 -->
  <link rel="preconnect" href="https://fonts.googleapis.com"> 
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@900&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap" rel="stylesheet">

<!-- 구글 맵 -->
 <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
 <%
	 
 %>
 <script>
	$(function(){
		
		$('#mainMenuList li').on('mouseenter', function(){
			$('#subMenuList').slideDown();
		});
		
		$('#subMenuList').on('mouseleave', function(){
			$('#subMenuList').slideUp();
		});
		
		// 날씨 함수 
		(function(d, s, id) {
            if (d.getElementById(id)) {
                if (window.__TOMORROW__) {
                    window.__TOMORROW__.renderWidget();
                }
                return;
            }
            const fjs = d.getElementsByTagName(s)[0];
            const js = d.createElement(s);
            js.id = id;
            js.src = "https://www.tomorrow.io/v1/widget/sdk/sdk.bundle.min.js";

            fjs.parentNode.insertBefore(js, fjs);
        })(document, 'script', 'tomorrow-sdk');
		
		// 최저가 항공권 연결되는곳 그림자효과
// 		$(document).on('mouseenter', '.cardArticle', function(){
// 			$(this).css('box-shadow','3px 3px 5px 3px gray');
// 		});
// 		$(document).on('mouseleave', '.cardArticle', function(){
// 			$(this).css('box-shadow','');
// 		});
		
		<%
			MemberVO memInfo = (MemberVO) session.getAttribute("memInfo");
		%>
		
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
	// 구글
	
</script>

<style>
		/* 기본값 style */
	body{
		min-width : 1600px;
		height : 100%;
		background-color : hidden;
	}
	#mainMenu{
		user-select : none;
	}
	.container-fluid{
		max-width : 1250px;
		padding-top : 75px;
		background-color : white;
	}
	
	/* 헤더 style-------------------------------------- */ 
    .wrap{
		width : 100%;
		margin : 10px auto;
		position : relative;
    }
    .cropping{
		margin-top : -10px;
		max-height : 800px;
		overflow:hidden;
    }
    .cropping img{
		max-height : initial;
		margin-top: -20%;
		filter:brightness(40%);
		z-index : 2;
    }
    .text{
		position : absolute;
		transform: translate( 330px, -600px );
		font-size : 50pt;
		color : white;
		/*font-family: 'Nanum Pen Script', cursive;*/
	}
	.bpk-flare-bar_bpk-flare-bar__curve__NjNlM {
    position: absolute;
    bottom: -1px;
    height: 2rem;
    margin-left: 50%;
    transform: translateX(-50%);
    fill: #fff;
	}
	/*--------------------------------------------------*/
	/*section style모음--------------------------------*/
	#ad{
		margin-top : 100px;
		margin-bottom : 100px;
		background-color : #013E8D;
		text-decoration : none;
	}
	.adimg{
		width : 100%;
		height : 120px;
		
		padding-top : 17px;
		padding-left : 80px;
		border-left : 10px solid white;
		
		font-family: 'Nanum Pen Script', cursive;
		font-size : 1.8em; 
		color : white;
	}
	.fakeimg{
		height: 350px;
		border : 2px solid #1F85F3;
		border-radius : 10px;
		padding : 20px;
    }
	.Kyotoimg{
		width : 350px;
		height : 200px;
		overflow:hidden;
		position : relative;
		border-radius : 10px;
	}
	#linkimg1, #linkimg2, #linkimg3{
		height : 100px;
		margin-top : 19px;
    }
    .adLink{
		color : white;
		text-decoration : none;
	}
	.cardArticle{
		margin : 10px;
		padding:20px;
		border-radius: 20px;
		transition : 300ms;
	}
	.cardArticle:hover{
		box-shadow : 3px 3px 10px 3px grey;
	}
	
    /*-------------------------------------------------- */
	/* ticket예매 style */
	
	#result1{
		width : 400px;
		height: 30px;
		background-color: #FF7E47;
		color : white;
	}
	#ticket{
		padding-top : 10px;	
	}
	#ticketchk{
		width : 250px;
		height: 50px;
		float : right;
	}
	#booking{
		padding : 30px;
		margin-left : 327px;
		width : 1250px;		
		background-color : #1DE9B6;
		background-color: rgba( 29, 233, 182, 0.65 );
		border-radius : 10px;
		position : absolute;
		transform: translate( 0px, -400px );
		font-family: 'Noto Sans KR', sans-serif;
	}
	.tomorrow{
		overflow: hidden;
	}
	#logout{
			padding : 0px;
			margin-left : 12px;
			margin-right : 5px;
			border : none;
			background-color : white;
		}
	.profile{
		border: none;
		background-color : white;
	}
	.profile h5{
		margin-left : 20px;
		font-size : 15pt;
		font-family: 'Noto Sans KR', sans-serif;
	}
	/*--------------------------------------------------*/
	#result1{
	width : 400px;
	height: 30px;
	background-color: #FF7E47;
	color : white;
	text-align : center;
	}
	#ticket{
		padding-top : 10px;	
	}
	#ticketchk{
		width : 250px;
		height: 50px;
		float : right;
	}
	#booking{
		padding : 30px;
		width : 1250px;		
	 	background-color: rgba( 28, 194, 153, 0.83 ); 
	/* 	background-color : #1CC299; */
		font-family: 'Noto Sans KR', sans-serif;
	}
	.bookingBtn{
		background-color : #1CC299;
		border : none;
	}
	.portBox{
		border-radius : 5px;
		position : absolute;
		width : 300px;
		background-color : white;
		z-index : 1;
	}
	
	.portList{
	 	list-style-type : none;
		margin : 0px;
		padding : 0px;
		font-size : 20px;
	}
	
	.airportTag{
		margin : 5px;
		margin-left : 15px;
		cursor : pointer;
	}
	.tourdiv{
/* 		white-space: nowrap; */
		word-break:break-all;
		text-overflow:ellipsis;
 		overflow:hidden; 
		width: 350px;
	}
	.cheapTable{
		width : 100%;
		text-align : center;
		font-family: 'Noto Sans KR', sans-serif;
	}
	.cheapTicket:hover{
		cursor : pointer;
		color : white;
		background-color : #1DE9B6;
	}
</style>
<script>
$(function(){

	// 가는날과 오는날의 최소값을 오늘로 설정
	var today = new Date();
	var todayFormat = today.getFullYear() + "-" + (today.getMonth() < 9 ? "0" + (today.getMonth() + 1) : (today.getMonth() + 1)) 
										  + "-" + (today.getDate() < 10 ? "0" + today.getDate() : today.getDate());
	
	var nextweek = new Date(today);
	nextweek.setDate(today.getDate() + 7);
	var nextweekFormat = nextweek.getFullYear() + "-" + (nextweek.getMonth() < 9 ? "0" + (nextweek.getMonth() + 1) : (nextweek.getMonth() + 1)) 
											    + "-" + (nextweek.getDate() < 10 ? "0" + nextweek.getDate() : nextweek.getDate());
	
	$('#goDate').attr("min", todayFormat);
	$('#goDate').val(todayFormat);
	
	$('#comeDate').attr("min", todayFormat);
	$('#comeDate').val(nextweekFormat);
	
	
	// 가는날 변경 시
	$('#goDate').on('change', function(){
		setCalendar();
	});
	
	// 왕복 - 편도 변경 시
	$('input[name=flight-type]').on('change', function(){
		lockComeFlight();
	});
	
	
	// 출도착지 입력 종료 시
	$('#departure, #arrival').on('blur', function(){
		
		var dep = $('#departure').val();
		var arr = $('#arrival').val();
		
		isSame();
		
		var portList = $(this).parent().find('.portList');
		portList.empty();
	});
	
	
	// 출도착지 입력 시
	$('#departure, #arrival').on('keyup', function(){
		
		var airportName = $(this).val();
		var portList = $(this).parent().find('.portList');
		
		$.ajax({
			url : '<%= request.getContextPath() %>/flight.do',
			data : { "job" : "port", "airportName" : airportName },
			type : 'get',
			success : function(res){
				
				var list = "";
				
				$.each(res, function(i, v){
					
					if(i > 6) return false;
					
					list += "<li class='airportTag' id='" + v.airport_name + "'>" + v.airport_name + " " + v.airport_iata + "</li>";
				});
				
				portList.html(list);
			},
			error : function(err){
				alert(err.status + " : " + err.statusText);
			},
			dataType : 'json'
		});
	});
	
	
	// 공항 목록에서 공항 선택 시
	$(document).on('mousedown', '.airportTag', function(){
		var portName = $(this).attr('id');
		$(this).parents('.form-group').find('.form-control').val(portName);
		
		$(this).parent().empty();
		isSame();
	});
	
	
	// 항공편 검색 클릭 시
	$('#ticketchk').on('click', function(){
		
		var dep = $('#departure').val();
		var arr = $('#arrival').val();
		
		if(dep.length == 0 || arr.length == 0){
			$('#result1').text("출발지와 도착지를 입력해주세요.");
			$('#result1').show();
			return false;
		} else{
			$('#result1').text("");
			$('#result1').hide();
		}
		
		$('#job').val('list');
		
		$('#searchInfo').submit();
	});
	
	
	// 최저가 항공권 클릭 시
	$(document).on('click', '.cheapTicket', function(){
		
		var dayofweeks = ['일', '월', '화', '수', '목', '금', '토'];
		var fli_schedule = $(this).find('.dayofweek').val();
		
		var today = new Date();
		var theDay;
		
		do{
			theDay = new Date(
					today.getFullYear(),
					today.getMonth(),
					today.getDate() + Math.floor((Math.random() *  30) + 1)
				);
			
			var day = dayofweeks[theDay.getDay()];
		} while(fli_schedule.indexOf(day) == -1);
		
		// 최저가 항공편의 데이터를 가져온다.
		var depport = $(this).find('.depport').text();
		depport = depport.trim();
		var arrport = $(this).find('.arrport').text();
		arrport = arrport.trim();
		
		// 월이 10 미만일 경우 앞에 '0'을 붙인다.
		var targetMonth = (theDay.getMonth() + 1) < 10 ? "0" + (theDay.getMonth() + 1) : (theDay.getMonth() + 1);
		// 일이 10 미만일 경우 앞에 '0'을 붙인다.
		var targetDay = theDay.getDate() < 10 ? "0" + theDay.getDate() : theDay.getDate();
		
		var targetDate = theDay.getFullYear() + "-" + targetMonth + "-" + targetDay;
		
		// 항공권 검색란에 값을 넣는다.
		$('#departure').val(depport);
		$('#arrival').val(arrport);
		$('#goDate').val(targetDate);
		
		$('#one-way').prop('checked', 'true');
		$('#job').val('list');
		
		setCalendar();
		lockComeFlight();
		
		// 서버에 제출하여 항공권 목록을 조회한다.
		$('#searchInfo').submit();
	});
})

// 편도 선택 시 '오는 편' 메뉴가 잠긴다.
function lockComeFlight(){

	var waySelect = $('input[name=flight-type]:checked').attr('id');
	
	if(waySelect == "one-way"){
		$('#comeBtn').prop('disabled', true);
		$('#comeBtn').css('background-color', 'grey');
		
		$('.depart').show();
		$('.arriv').hide();
		
		$('.goBtn').css("background-color", "#1CC299");
		
		$('#comeDate').prop('disabled', true);
		
	} else if(waySelect == "roundtrip"){
		$('#comeBtn').prop('disabled', false);
		$('#comeBtn').css('background-color', '#013E8D');
		
		$('#comeDate').prop('disabled', false);
		setCalendar();
	}
}

// 날짜 선택 시 달력의 선택 범위를 변경
function setCalendar(){
	var goDate = $('#goDate').val();
	var comeDate = $('#comeDate').val();
	
	// 가는날이 오는날보다 늦을 경우
	if(goDate > comeDate){
		$('#comeDate').val(goDate);
	}
	
	// 오는날은 가는날보다 빠를 수 없다.
	$('#comeDate').attr("min", goDate);
}

// 출도착지가 같을 경우
function isSame(){
	
	var dep = $('#departure').val();
	var arr = $('#arrival').val();
	
	if(dep == arr){
		$('#result1').text("출발지와 도착지가 같으면 안 돼요.");
		$('#result1').show();
	} else{
		$('#result1').text('');
		$('#result1').hide();
	}
}
</script>
</head>
<body>
<!-- header navbar -->
<header>
<nav class="navbar navbar-expand-sm bg-white navbar-white">
	<a class="navbar-brand" href="<%= request.getContextPath() %>/view/main/mainIndex.jsp"  style="color:#1DE9B6;"><img src="<%= request.getContextPath() %>/images/layout/Union.png" id="icon"> Harang</a>
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
			<button class="profile" type="button" id="profile" ><img src="<%= request.getContextPath() %>/images/layout/profile.png"></button>
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
	
	<!-- 메인 navbar ==> header 이미지 위로 올라와야하므로 header section에 위치 -->
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
<!-- 메인화면 이미지 -->
<div class="wrap">
	<div class="cropping">
		<img src="<%= request.getContextPath() %>/images/layout/01.jpg" id="airport"></img>
	</div>
	<div class="col-lg-8">
		<h1 class="text">지금 바로<br> 여행을 떠나세요!</h1>
	</div>
		<svg viewBox="0 0 3332 56" class="bpk-flare-bar_bpk-flare-bar__curve__NjNlM">
			<path d="M1701.307 8.517l-68.043 39.341c-10.632 6.185-23.795 6.185-34.528 0l-68.144-39.34c-8.91-5.173-18.988-8.215-29.316-8.518H0v55h14832V0H7530.671a63.604 63.604 0 0 0-29.364 8.517z"></path>
		</svg>
</div>
<!-- 메인화면에서 예매란 -->
	<div id="booking" class="section">
		<div class="section-center">
			<div class="container">
				<div class="row">
					<div class="booking-form">
						<form id="searchInfo" action="<%= request.getContextPath() %>/flight.do" method="post">
							<div class="form-group">
								<div class="form-checkbox">
									<label class="col-sm-1" for="roundtrip">
										<input type="radio" id="roundtrip" name="flight-type" checked>
										<span>왕복</span>
									</label>
									<label class="col-sm-1" for="one-way">
										<input type="radio" id="one-way" name="flight-type">
										<span>편도</span>
									</label>
								</div>
							</div>
							<div id="result1" style="display:none;"></div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<span class="form-label">출발지</span>
										<input class="form-control" type="text" placeholder="도시 또는 공항을 입력하세요" id="departure" name="fli_depport" autocomplete="off" required>
										<div id="depBox" class="portBox">
											<ul id="depList" class="portList"></ul>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<span class="form-label">도착지</span>
										<input class="form-control" type="text" placeholder="도시 또는 공항을 입력하세요" id="arrival" name="fli_arrport" autocomplete="off" required>
										<div id="arrBox" class="portBox">
											<ul id="arrList" class="portList"></ul>
										</div>
									</div>
								</div>
							
							
								<div class="col-md-2">
									<div class="form-group">
										<span class="form-label">가는날</span>
										<input id="goDate" name="goDate" class="form-control" type="date" required>
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<span class="form-label">오는날</span>
										<input id="comeDate" name="comeDate" class="form-control" type="date" required>
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<span class="form-label">어른 (만 18세 이상)</span>
										<select class="form-control" id="adult" name="adult">
											<option selected>1</option>
											<option>2</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
										</select>
										<span class="select-arrow"></span>
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<span class="form-label">영·유아/청소년</span>
										<select class="form-control" id="child" name="child">
											<option selected>0</option>
											<option>1</option>
											<option>2</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
										</select>
										<span class="select-arrow"></span>
									</div>
								</div>
<!-- 								<div class="col-md-4"> -->
<!-- 								이 div지우면 지상렬 -->
<!-- 								</div> -->
								
								<div class="col-md-4" id="ticket">
									<div>
										<input type="hidden" id="job" name="job">
										<button type="button" class="btn btn-light" id="ticketchk"><span style="color:#1DE9B6; font-size : 1.2em;">항공권 검색</span></button>
									</div>
								</div>
							</div>	
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>

<!-- 지도, 날씨, 가이드링크 section -->
<section>
<div class="container-fluid">
	<div class="row">
		<div  class="col-sm-6" >
		<iframe  width="600" height="330" style="border:0" loading="lazy" allowfullscreen
src="https://www.google.com/maps/embed/v1/search?q=%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD%20%EA%B5%AD%EC%A0%9C%EA%B3%B5%ED%95%AD&key=AIzaSyCBQDj6Mv6A9mfim_aSqMRL2tJTsKwD1N4"></iframe>
		</div>
		
<!--       		<div style="pointer-events: none; width: 100%; height: 100%; box-sizing: border-box; position: absolute; z-index: 1000002; opacity: 0; border: 2px solid rgb(26, 115, 232);"></div> -->
      		<br><br><br>


				<div class="col-sm-6" name="weather">

					<div class="tomorrow"
						data-location-id="065339,065400,065425,065289,065278,065406"
						data-language="KO" data-unit-system="METRIC" data-skin="light"
						data-widget-type="aqi6"
						style="padding-bottom: 22px; position: relative;">
						<a href="https://www.tomorrow.io/weather-api/"
							rel="nofollow noopener noreferrer" target="_blank"
							style="position: absolute; bottom: 0; transform: translateX(-50%); left: 50%;">
							<img alt="Powered by the Tomorrow.io Weather API"
							src="https://weather-website-client.tomorrow.io/img/powered-by.svg"
							width="100" height="30" />
						</a>
					</div>

					<hr class="d-sm-none">
				</div>

				<!--     	<div class="col-sm-3" name="schedule"> -->
<!--       		<div class="fakeimg" id="linkimg1">Fake Image</div> -->
<!--       		<div class="fakeimg" id="linkimg2">Fake Image</div> -->
<!-- 	  		<div class="fakeimg" id="linkimg3">Fake Image</div> -->
	  
<!--       		<hr class="d-sm-none"> -->
<!--     	</div> -->
	</div>
	
	<!-- ad 이미지 -->
		<div class="col-sm-12" id="ad">
			<a class="adLink" href="https://www.koreanair.com/kr/ko/travel-guide/skypass" target= "_blank">
			<img src="<%= request.getContextPath() %>/images/layout/skypass.png" style="float : right; width : 300px; height:120px;">
      			<div class="adimg">HARANG과 함께하는 대한항공 겨울 개편 SKYPASS!<br> 마일리지에 보너스까지! 지금 바로 대한항공 skypass로 이동!
      			</div>
      		</a>	
    	</div>
	<br>
	<br>
  
  
  <!-- 추천여행지 section -->
	<h2><b>이런여행은 어떠세요?</b></h2>
	<h4>HARANG이 함께 날고싶은 여행지 추천!</h4>
	<br>
	<div id="tourList_result" class="row">
<!-- 		<div class="col-sm-3.5 cardArticle"> -->
<!-- 	  		<h3 style="font-family: 'Noto Sans KR', sans-serif;">#오사카 #힐링 #여행</h3> -->
<!--       		<div class="Kyoto"> -->
<!-- 				<div class="Kyotoimg" style="margin:auto;"> -->
<%-- 					<img src="<%= request.getContextPath() %>/images/layout/일본2.jpg" style="width:400px; height:200px;"></img> --%>
<!-- 				</div> -->
<!-- 				<div style="height:100px; margin-top:10px; margin-bottom: 20px;"> -->
<!-- 					<h4>오사카의 '오사카 성'</h4> -->
<!-- 					<h6>오사카의 '오사카 성'은 <br> 에도막부시절부터 존재한 건축물로 1600년대의<br> 향취와 어우러진 현대시설들을 즐겨보세요</h6> -->
<!-- 				</div> -->
<!-- 				<div class="ticketbox"> -->
<!-- 					이곳은 최저가 이미지가 들어갈 곳입니다.	 -->
<!-- 				</div> -->
<!-- 				<div class="ticketbox"> -->
<!-- 					이곳은 최저가 이미지가 들어갈 곳입니다.	 -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
   	</div>
</div>
</section>
<br>
<br>
<br>
<br>

<!-- footer section -->
<div style="margin-bottom:0">
  	<footer>
	  	<hr/>
  			<div id="footerDiv">
  				<p>전 세계 저가 항공권을 비교하고 예약하세요</p>
				<p>ⓒ HARANG Ltd. 2022-</p>
  			</div>
  	</footer>
</div>
<script type="text/javascript">

var showTourList = 3; // 메인화면에 출력할 추천 여행지 개수
getTourList(showTourList);

// 메인화면 추천 여행지 목록 출력
function getTourList(num) {
	$.ajax({
		url : "<%=request.getContextPath()%>/tour.do",
		data : {
			"job" : "list",
			"showCount" : num
		},
		dataType : 'json',
		success: function (data) {
			
			var tourhtml ='';
			
			$('#tourList_result').html(tourhtml);
			$.each(data, function(i, v) {
				
				// 해당 공항에 도착하는 최저가 항공편 목록을 가져온다.
				var flightList = getCheapFlight(v.airport_id);
				
				// 추천 여행지 카드를 작성한다.
				tourhtml+='<div class="col-sm-3.5 cardArticle">';
			  	tourhtml+='<h3 style="font-family: "Noto Sans KR", sans-serif;">'+v.tour_name+'</h3>';
		      	tourhtml+='<div class="Kyoto">';
		      	
				tourhtml+='<div class="Kyotoimg" style="margin:auto;">';
				if(v.tour_file != null){
					tourhtml+='<img src="<%= request.getContextPath() %>/images/tour/' + v.tour_file + '" style="width:400px; height:200px;"></img>';
				} else {
					tourhtml+='<img src="<%= request.getContextPath() %>/images/layout/main02.png" style="width:400px; height:200px;"></img>';
				}
				tourhtml+='</div>';
				
				tourhtml+='<div class="tourdiv" style="height:100px; margin-top:10px; margin-bottom: 20px;">';
				tourhtml+='<h6 style="word-break:break-all;">' + v.tour_phrase + '</h6>';
				tourhtml+='</div>';
				
				tourhtml+='<table class="cheapTable">';
				$.each(flightList, function(i, v){
					
					if(i >= 2) return false;
					tourhtml+= '<tr class="cheapTicket">'
					tourhtml+= '<input type="hidden" class="dayofweek" value="' + v.fli_dayofweek + '">';
					tourhtml+= '<td>' + v.airline_name + '</td>';
					tourhtml+= '<td>' + v.fli_id + '</td>';
					tourhtml+= '<td class="depport">' + v.fli_depport + '</td>';
					tourhtml+= '<td class="arrport">' + v.fli_arrport + '</td>';
					tourhtml+= '<td>' + v.fli_price.toLocaleString('ko-KR') + '원</td>';
					tourhtml+= '</tr>'
				});
				tourhtml+='</table>';
			
				tourhtml+='</div>';
				tourhtml+='</div>';
			
			});
			
			$('#tourList_result').html(tourhtml);
			
		},
		error: function (err) {
			alert(err.status + " : " + err.statusText);
		}
	})
};

// 최저가 항공편 목록을 가져온다.
function getCheapFlight(arrport){
	
	var flightInfo;
	
	$.ajax({
		url : '<%= request.getContextPath() %>/flight.do',
		data : {
			"job" : "cheap",
			"arrport" : arrport,
		},
		type : 'post',
		async : false,
		success : function(res){
			flightInfo = res;
		},
		error : function(err){
			alert(err.status + " : " + err.statusText);
		},
		dataType : 'json'
	});
	
	return flightInfo;
}

</script>
</body>
</html>