<%@page import="com.harang.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HARANG : 하늘을 함께 날다.</title>
 <meta name="viewport" content="width=device-width, initial-scale=1">
 
  <!-- Bootstrap 적용 -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="icon" href="<%=request.getContextPath()%>/images/layout/Union.png">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/navbar.css">
  
  <!-- 폰트적용 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@900&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Gothic+A1:wght@500&display=swap" rel="stylesheet">
<!--  swiper css 건들지 마시오 --------------------- -->
 <!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"/>
  
 	
 <script>
	$(function(){
		// 서브메뉴 올라갔다 내려갔다 왔다갔다
		$('#mainMenuList li').on('mouseenter', function(){
			$('#subMenuList').slideDown();
		});
		
		$('#subMenuList').on('mouseleave', function(){
			$('#subMenuList').slideUp();
		});
		
		// 출발/도착버튼 색이 왔다갔다 이리저리 요리조리 샤라랑
		$('.comeBtn').on('click', function(){
			$('.depart').hide();
			$('.arriv').show();
			
			$('.goBtn').css("background-color", "#013E8D");
			$('.comeBtn').css("background-color", "#1DE9B6");
		});
	
		$('.goBtn').on('click', function(){
			$('.depart').show();
			$('.arriv').hide();
			
			$('.goBtn').css("background-color", "#1DE9B6");
			$('.comeBtn').css("background-color", "#013E8D");
		});
		
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
		width : 1250px;
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
	width : 100%;
	height : 500px;
	max-height : initial;
	margin-top: -20%;
	filter:brightness(60%);
	transform: translate( 0px, 300px );
	z-index : 2;
}
.text{
	position : absolute;
	transform: translate( 800px, -200px );
	font-size : 30pt;
	color : white;
}
.text3{
	font-family: 'Noto Sans KR', sans-serif;
}

/* -------------------------------------------- */

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
.textInfo{
	margin-top : 150px;
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

/* 항공권 검색----------------------------------------*/
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
	width : 1250px;		
 	background-color: rgba( 28, 194, 153, 0.83 ); 
/* 	background-color : #1CC299; */
	font-family: 'Noto Sans KR', sans-serif;
}
.bookingBtn{
	background-color : #1CC299;
	border : none;
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

/*----------------------------------------------------*/
/* 게시판 테이블 */
.table{
	margin-top : 50px;
	text-align : center;
}
.tableHead{
	font-family: 'Noto Sans KR', sans-serif;
	border : none;
	background-color: rgba( 30, 30, 30, 0.1 ) ; 
	text-align: center;
}
.arriv{
	display : none;
}
/*-----------------------------------------------------*/
</style>

</head>
<body>

<!-- header navbar -->
<header>
<nav class="navbar navbar-expand-sm bg-white navbar-white">
	<a class="navbar-brand" href="<%= request.getContextPath() %>/view/main/mainIndex.jsp" style="color:#1DE9B6;"><img src="<%=request.getContextPath() %>/images/layout/Union.png" id="icon"> Harang</a>
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
			} else {
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
			<div class="col-md-12" id="subMenuList" style="display: none;">
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
			<img src="<%=request.getContextPath()%>/images/layout/travelguidemain.jpg">
		</div>
		<div class="col-lg-8">
			<h1 class="text">출발/도착 안내</h1>
		</div>
	</div>
</header>


<section>
	<div class="container-fluid">
		<div style="margin-bottom : 50px;">
			<h2 class="text3">출발/도착 안내</h2>
			<br>
			<p><span style="color : gray;">Home > 안내</span> > <b>출발/도착 안내</b> <span id="timer" style="font-family: 'Gothic A1', sans-serif; float: right;font-size: 1.5em;" ></span></p>
			<hr/>
		</div>
		<div class="row">
			<div>
				<button id="depart" class="goBtn" type="button" value="출발" onclick="$('#babo').val('출발');showChat();">출발</button>
			</div>
			<div>
				<button id="arrival" class="comeBtn" type="button" value="도착" onclick="$('#babo').val('도착');showChat();">도착</button>
			</div>
		<div id="booking" class="col-md-12">
			<div class="section-center">
				<div class="container">
						<div class="booking-form">
							<form>
							<input type="hidden" id="babo" name="select" value="출발">
								<!-- <div id="result1">출발지와 도착지가 같으면 뜨게할 경고문</div> -->
								<div class="row">
									<div id="airport_result" class="col-md-4">
									<!-- 공항 목록 -->
									</div>
									<div id="airline_result" class="col-md-4">
									<!-- 항공사 목록 -->
									</div>
									<div class="col-md-4" id="ticket">
										<div>
											<button type="button" class="btn btn-light" id="ticketchk" onclick="showChat(this)"><span style="color:#1CC299; font-size : 1.2em;">스케쥴 조회</span></button>
										</div>
									</div>
								</div>	
							</form>
						</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 가는 편 버튼을 누르면 나온다. -->
	<div id='gopickChat' class="depart" style="margin-top : 30px;">
		<hr>
	</div>
	
	<!-- 오는 편 버튼을 누르면 나온다. -->
	<div id='pickChat' class="arriv" style="margin-top : 30px;">
		<hr>
	</div>
	
	</div>
</section>


<!-- footer section -->
<div style="margin-bottom:0; margin-top: 100px;">
  	<footer>
	  	<hr/>
  			<div id="footerDiv">
  				<p>전 세계 저가 항공권을 비교하고 예약하세요</p>
				<p>ⓒ HARANG Ltd. 2022-</p>
  			</div>
  	</footer>
</div>
<script type="text/javascript">
showList();

function getAirline() {
	
	//항공사 목록
	$.ajax({
		url : "<%=request.getContextPath()%>/facility.do",
		data : { "category" : "airline"},
		type : 'get',
		dataType : 'json',
		success : function(data){
			
				var airline= '';
				$('#airline_result').html(airline);
				
				airline+= '<div class="col-md-12">';
				airline+= '<div class="form-group">';
				airline+= '<span class="form-label">항공사 선택</span> ';
				airline+= '<select id="airlineName" class="form-control">';
				airline+= '<option value="" selected>전체</option>';
				
			$.each(data, function(i, v) {
				airline+= '<option value="'+v.airline_name+'">'+v.airline_name+'</option>';
			});
			
				airline+= '</select>';
				airline+= '	</div>';
				airline+= '</div>';
				$('#airline_result').html(airline);
		}//success
	}) //항공사 ajax
}//getAirline

function getAirport() {
	//공항 목록
	$.ajax({
		url : "<%=request.getContextPath()%>/facility.do",
		data : { "category" : "airport"},
		type : 'get',
		dataType : 'json',
		success : function(data){
			
			var airporthtml ='';
			$('#airport_result').html(airporthtml);
			
			airporthtml += '<div class="col-md-12">';
			airporthtml += '<div class="form-group">';
			airporthtml += '<span class="form-label">공항선택</span>';
			airporthtml += '<select id="airportName" class="form-control">';
			
			$.each(data, function(i, v) {
				if(v.airport_name == "김포" && v.airport_city == "서울/김포"){
					airporthtml +='<option  value="' + v.airport_name + '" selected>' + v.airport_city + '</option>';
				}else {
				airporthtml += '<option value="' + v.airport_name + '">' + v.airport_city + '</option>';
				}
				
			});
			airporthtml += '</select>';
			airporthtml += '</div>';
			airporthtml += '</div>';
			
			$('#airport_result').html(airporthtml);
			
		}//success
	}) //공항 ajax
}//getAirport

function showList() {
	getAirport();
	getAirline();
	$('#ticketchk').click();
	
	way=$('#babo').val()
	airportName= $("#airportName option:selected").val();
	airlineName =$("#airlineName option:selected").val();
	
	findng(airportName,airlineName,way);
	
	
}

function findng(airportName,airlineName,way) {
	
	$.ajax({
		url : "<%=request.getContextPath()%>/schedule.do",
		
		data : { "way" : way,
				 "airportName": airportName,
				 "airlineName": airlineName},
		type : 'get',
		dataType : 'json',
		success : function(data){
			
			var tablehtml='';
			
			if(way == "출발"){
				$('#gopickChat').html(tablehtml);
			}
			if(way == "도착"){
				$('#pickChat').html(tablehtml);
			}
			
			
			tablehtml += '<table class="table">';
			tablehtml += '<thead class="tableHead">';
			tablehtml += '<tr>';
			tablehtml += '<th style="width:20%;">항공사</th>';
			tablehtml += '<th style="width:20%;">출발공항</th>';
			tablehtml += '<th style="width:20%;">도착공항</th>';
			tablehtml += '<th style="width:20%;">출발시간</th>';
			tablehtml += '<th style="width:20%;">도착시간</th>';
			tablehtml += '</tr>';
			tablehtml += '</thead>';
			tablehtml += '<tbody>';
			
			$.each(data,function(i,v){
				tablehtml += '<tr>';
				tablehtml += '<td>' + v.airline_name + '</td>';
				tablehtml += '<td>' + v.fli_depport + '</td>';
				tablehtml += '<td>' + v.fli_arrport + '</td>';
				
				var deptime = v.fli_deptime;
				deptime = deptime.substring(0, 2) + ":" + deptime.substring(2);
				
				var arrtime = v.fli_arrtime;
				arrtime = arrtime.substring(0, 2) + ":" + arrtime.substring(2);
				
				tablehtml += '<td>' + deptime + '</td>';
				tablehtml += '<td>' + arrtime + '</td>';
				tablehtml += '</tr>';
			});//each
			
			tablehtml += '</tbody>';
			tablehtml += '</table>' ;
			
			if(way == "출발"){
				$('#gopickChat').html(tablehtml);
			}
			
			if(way == "도착"){
				$('#pickChat').html(tablehtml);
			}
		}// success
	}); //ajax
}//findng

function showChat(el) {
	airportName = $("#airportName option:selected").val();
	airlineName = $("#airlineName option:selected").val();
	way = $('#babo').val()
	
	findng(airportName,airlineName,way);
}

$(function(){
	setInterval(function(){

		var today = new Date();   

		var hours = ('0' + today.getHours()).slice(-2); 
		var minutes = ('0' + today.getMinutes()).slice(-2);
		var seconds = ('0' + today.getSeconds()).slice(-2); 

		var timeString = hours + ':' + minutes  + ':' + seconds;
		
		$('#timer').text("현재 시간 : " + timeString);
	}, 1000);
});


</script>
</body>
</html>