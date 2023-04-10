<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.harang.vo.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.harang.vo.FlightVO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
 
<script>

<%
	MemberVO memInfo = (MemberVO) session.getAttribute("memInfo");
%>


	$(function(){
		
		$('#mainMenuList li').on('mouseenter', function(){
			$('#subMenuList').slideDown();
		});
		
		$('#subMenuList').on('mouseleave', function(){
			$('#subMenuList').slideUp();
		});
		
		$('.goBtn').on('click', function(){
			clickGoBtn();
		});
		
		$('.comeBtn').on('click', function(){
			clickComeBtn();
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
	
	// 가는 편 클릭 시
	function clickGoBtn(){
		$('.depart').show();
		$('.arriv').hide();
		
		$('.goBtn').css("background-color", "#1CC299");
		
		if($('.comeBtn').prop('disabled') == false){
			$('.comeBtn').css("background-color", "#013E8D");
		}
	}
	
	// 오는 편 클릭 시
	function clickComeBtn(){
		$('.depart').hide();
		$('.arriv').show();
		
		$('.goBtn').css("background-color", "#013E8D");
		$('.comeBtn').css("background-color", "#1CC299");
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
	
}
.container-fluid{
	max-width : 1250px;
	margin-top : 30px;
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
.arriv{
	display : none;
}
.table{
	text-align : center;
}
.tableHead{
	font-family: 'Noto Sans KR', sans-serif;
	border : none;
	background-color: #013E8D;
	color: white; 
	text-align: center;
}
td{
	font-size : 14pt;
	font-family: 'Noto Sans KR', sans-serif;
}
.goBtn{
	width : 625px;
	border : none;
	height : 50px;
	text-align : center;
	font-family: 'Noto Sans KR', sans-serif;
	font-size : 13pt;
	color : white;
	background-color : #1CC299;
}
.comeBtn{
	width : 625px;
	border : none;
	height : 50px;
	text-align : center;
	background-color : #013E8D;
	font-family: 'Noto Sans KR', sans-serif;
	font-size : 13pt;
	color : white;
}
.text{
	position : absolute;
	transform: translate( 800px, -200px );
	font-size : 35pt;
	color : white;
}
.text2{
	position : absolute;
	transform: translate( 670px, -120px );
	font-size : 20pt;
	color : white;
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
 /*-------------------------------------------------- */
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

		
		
		// 항공편 목록에서 예매하기 클릭 시
		// 예매 페이지에서 사용할 데이터를 '#toBooking' 폼에 설정 
		$(document).on('click', '.goFlight, .comeFlight', function(){
			var flightWay = $(this).parents('.table').attr('id');
			var flightId = $(this).parents('.flightList').find('.flightId').attr('id');
			
			// 탑승 인원 설정
			var count = parseInt($('#adult').val()) + parseInt($('#child').val());
			$('#toBooking input[name=count]').val(count);
			
			$('#toBooking input[name=job]').val('toBooking');
			
			switch(flightWay){
			case "departTable": // 가는 편 선택
				$('#toBooking input[name=goFlightId]').val(flightId);
			
				// 가는 날짜 결정
				var goDate = $('#goDate').val();
				$('#toBooking input[name=goDate]').val(goDate);
				
				var comeFlightId = $('#toBooking input[name=comeFlightId]').val(); // 오는 편 항공편명
				
				if($('#comeDate').prop('disabled') || comeFlightId != ""){ // 편도이거나 오는 편을 이미 선택했을 경우
					$('#toBooking').submit();
				} else{ // 왕복일 경우
					clickComeBtn();  // 가는 편 선택
				}
				break;
			case "arrivTable": // 오는 편 선택
				$('#toBooking input[name=comeFlightId]').val(flightId);
			
				// 오는 날짜 결정
				var comeDate = $('#comeDate').val();
				$('#toBooking input[name=comeDate]').val(comeDate);
				
				var goFlightId = $('#toBooking input[name=goFlightId]').val(); // 가는 편 항공편명
				
				if(goFlightId == ""){ // 왕복이지만 가는 편이 선택되지 않았을 경우
					clickGoBtn();
				} else{ // 편도일 경우
					$('#toBooking').submit();
				}
				break;
			}
			
		});
		
	});
	
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
			<div class="col-md-12" id="subMenuList" style="display : none;">
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
		<div class="col-lg-8">
		<h1 class="text">항공권 검색</h1>
		<h3 class="text2">이제 날아오를 준비가 거의 다됐어요!</h3>
		</div>
	</div>
</header>


<section class="infoList">
<div class="container-fluid">
	<div class="row">
		<div>
			<button class="goBtn" type="button">가는 편</button>
		</div>
		<div>
			<button class="comeBtn" type="button" id="comeBtn">오는 편</button>
		</div>
		
		
		<%
			// 검색한 항공편 정보
			Map<String, String> searchInfo = new HashMap<>();
			Map<?, ?> tempMap = (Map<?, ?>) request.getAttribute("searchInfo");
			
			if(tempMap != null){
				for(Object obj : tempMap.keySet()){
					if(obj instanceof String && tempMap.get(obj) instanceof String){
						searchInfo.put((String)obj, (String)tempMap.get(obj));
					}
				}
		%>
				<script>
					$(function(){
						
						// 편도 : 1, 왕복 2
						var count = parseInt(<%= searchInfo.get("flightCount") %>);
						
						if(count == 1){
							$('#one-way').prop('checked', true);
							lockComeFlight();
						}
						
						// 출발공항 - 도착공항
						var depport = "<%= searchInfo.get("fliDepport") %>";
						var arrport = "<%= searchInfo.get("fliArrport") %>";
						
						$('#departure').val(depport);
						$('#arrival').val(arrport);
						
						// 가는 날 - 오는 날
						var goDate = "<%= searchInfo.get("goDate") %>";
						var comeDate = "<%= searchInfo.get("comeDate") %>";
						
						$('#goDate').val(goDate);
						if(comeDate != "null"){
							$('#comeDate').val(comeDate);
							setCalendar();
						}
						
						// 성인 수, 아동 수
						var adult = parseInt(<%= searchInfo.get("adult") %>);
						var child = parseInt(<%= searchInfo.get("child") %>);
						
						$('#adult').val(adult);
						$('#child').val(child);
						
					});
				</script>
		<%
			}
		%>
		
		<div id="booking" class="col-md-12">
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
								<div id="result1" style="display : none;"></div> 
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
<!-- 									<div class="col-md-4"> -->
<!-- 									여기지우면 지상렬 -->
<!-- 									</div> -->
									
									<div class="col-md-4" id="ticket">
										<div>
											<input type="hidden" id="job" name="job">
											<button type="button" class="btn btn-light" id="ticketchk"><span style="color:#1CC299; font-size : 1.2em;">항공권 검색</span></button>
										</div>
									</div>
								</div>	
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 가는 편 버튼을 누르면 나온다. -->
	<div class="depart" style="margin-top : 30px;">
		<div>
			<table id="departTable" class="table" style="text-align : center;">
				<thead class="tableHead">
					<tr>
						<th>출발시간</th>
						<th>도착시간</th>
						<th colspan="3">출발지</th>
						<th colspan="5">도착지</th>
						<th colspan="5">항공사</th>
						<th colspan="3">편명</th>
						<th colspan="3">가격</th>
						<th colspan="5">예매</th>
					</tr>
				</thead>
				<tbody>
				<%
					// 조건에 맞는 항공편 목록
					// flightList.get(0) : 가는 편
					// flightList.get(1) : 오는 편 (왕복일 경우에만 해당)
					List<List<FlightVO>> flightList = new ArrayList<>();
					List<?> tempList = (List<?>) request.getAttribute("flightList");
					
					if(tempList != null){
					
						for(Object listObj : tempList){
							if(listObj instanceof List<?>){
								List<FlightVO> voList = new ArrayList<>();
								for(Object voListObj : (List<?>) listObj){
									if(voListObj instanceof FlightVO){
										voList.add((FlightVO) voListObj);
									}
								}
								flightList.add(voList);
							}
						}
						
						// 오늘 날짜 구하기
						Date date = new Date();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						
						String today = sdf.format(date.getTime());
						
						// 가는 편 목록
						List<FlightVO> goFlight = flightList.get(0);
						if(goFlight.size() == 0){
				%>
						<tr>
							<td colspan="28">조건에 맞는 항공편이 없어요.</td>
						</tr>
				<%
						} else {
							for(FlightVO vo : goFlight){
								
								// 출발일이 오늘일 경우
								if(searchInfo.get("goDate").equals(today)){
									SimpleDateFormat timeformat = new SimpleDateFormat("HHmm");
									
									int deptime = Integer.parseInt(vo.getFli_deptime());
									int now = Integer.parseInt(timeformat.format(date));
									
									// 출발 시간 1시간 전의 항공권만 목록에 나온다.
									if(deptime < now + 100) continue;
								}
								
								String deptime = vo.getFli_deptime().substring(0, 2) + ":" + vo.getFli_deptime().substring(2);
								String arrtime = vo.getFli_arrtime().substring(0, 2) + ":" + vo.getFli_arrtime().substring(2);
								DecimalFormat df = new DecimalFormat("###,###,###원");
								String price = df.format(vo.getFli_price());
				%>
								<tr class="flightList">
									<td><%= deptime %></td>
									<td><%= arrtime %></td>
									<td colspan="3"><%= vo.getFli_depport() %></td>
									<td colspan="5"><%= vo.getFli_arrport() %></td>
									<td colspan="5"><%= vo.getAirline_name() %></td>
									<td colspan="3" id="<%= vo.getFli_id() %>" class="flightId"><%= vo.getFli_id() %></td>
									<td colspan="3"><%= price %></td>
									<td colspan="5"><button type="button" class="btn btn-primary btn-md bookingBtn goFlight">예매하기</button></td>
								</tr>
				<%
							}
						}
				%>
<!-- 					<tr> -->
<!-- 						<td>14:20</td> -->
<!-- 						<td>15:50</td> -->
<!-- 						<td colspan="3">제주</td> -->
<!-- 						<td colspan="5">인천공항</td> -->
<!-- 						<td colspan="5">(이미지)대한항공</td> -->
<!-- 						<td colspan="3">KJS00</td> -->
<!-- 						<td colspan="3">36,700원</td> -->
<!-- 						<td colspan="5"><button type="button" class="btn btn-primary btn-md bookingBtn">예매하기</button></td> -->
<!-- 					</tr> -->
				</tbody>
			</table>
			<hr>
		</div>
	</div>
	
	<!-- 오는편 버튼을 누르면 나온다. -->
	<div class="arriv" style="margin-top : 30px;">
		<div>
			<table id="arrivTable" class="table" style="text-align : center;">
				<thead class="tableHead">
					<tr>
						<th>출발시간</th>
						<th>도착시간</th>
						<th colspan="3">출발지</th>
						<th colspan="5">도착지</th>
						<th colspan="5">항공사</th>
						<th colspan="3">편명</th>
						<th colspan="3">가격</th>
						<th colspan="5">예매</th>
					</tr>
				</thead>
				<tbody>
				<%
						// 검색 조건이 편도일 경우
						if(flightList.size() <= 1){
				%>
							<tr>
								<td colspan="28">조건에 맞는 항공편이 없어요.</td>
							</tr>
				<%
						} else {
							
							// 오는 편 목록
							List<FlightVO> comeFlight = flightList.get(1);
							if(comeFlight.size() == 0){
				%>
								<tr>
									<td colspan="28">조건에 맞는 항공편이 없어요.</td>
								</tr>
				<%
							}else {
								for(FlightVO vo : comeFlight){
									String deptime = vo.getFli_deptime().substring(0, 2) + ":" + vo.getFli_deptime().substring(2);
									String arrtime = vo.getFli_arrtime().substring(0, 2) + ":" + vo.getFli_arrtime().substring(2);
				%>
									<tr class="flightList">
										<td><%= deptime %></td>
										<td><%= arrtime %></td>
										<td colspan="3"><%= vo.getFli_depport() %></td>
										<td colspan="5"><%= vo.getFli_arrport() %></td>
										<td colspan="5"><%= vo.getAirline_name() %></td>
										<td colspan="3" id="<%= vo.getFli_id() %>" class="flightId"><%= vo.getFli_id() %></td>
										<td colspan="3"><%= vo.getFli_price() %></td>
										<td colspan="5"><button type="button" class="btn btn-primary btn-md bookingBtn comeFlight">예매하기</button></td>
									</tr>
				<%
								}
							}
						}
					}
				%>
				
<!-- 					<tr> -->
<!-- 						<td>14:20</td> -->
<!-- 						<td>15:50</td> -->
<!-- 						<td colspan="3">인천</td> -->
<!-- 						<td colspan="5">제주공항</td> -->
<!-- 						<td colspan="5">(이미지)대한항공</td> -->
<!-- 						<td colspan="3">KJS00</td> -->
<!-- 						<td colspan="3">40,700원</td> -->
<!-- 						<td colspan="5"><button type="button" class="btn btn-primary btn-md bookingBtn">예매하기</button></td> -->
<!-- 					</tr> -->
				</tbody>
			</table>
			<hr>
		</div>
	</div>
</div>
<!-- 선택한 항공편을 저장해두는 div -->
<div id="flightSelect" style="display : none">
	<form id="toBooking" action="<%= request.getContextPath() %>/flight.do" method="post">
		<input type="hidden" name="job">
		<input type="hidden" name="goFlightId">
		<input type="hidden" name="comeFlightId">
		<input type="hidden" name="goDate">
		<input type="hidden" name="comeDate">
		<input type="hidden" name="count">
	</form>
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