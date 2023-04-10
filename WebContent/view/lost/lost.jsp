<%@page import="com.harang.vo.MemberVO"%>
<%@page import="com.harang.vo.PageVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.harang.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분실물센터</title>
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
	$(function(){
		$('#mainMenuList li').on('mouseenter', function(){
			$('#subMenuList').slideDown();
		});
		$('#subMenuList').on('mouseleave', function(){
			$('#subMenuList').slideUp();
		});
	})
 </script>
 
 <%
	// JSP문서에서 세션은 'session'이라는 이름으로 저장되어 있다.
	MemberVO memInfo = (MemberVO)session.getAttribute("memInfo");
%>
<style>
/* 기본값 style */
#mainMenu{
	user-select : none;
}
.profile{
      border : none;
      background-color: white;
}
.profile h5{
   margin-left : 20px;
   font-size : 15pt;
   font-family: 'Noto Sans KR', sans-serif;
}

body{
	min-width : 1600px;
	height : 100%;
	background : linear-gradient(rgba( 29, 233, 182, 0.65 ), white);
}
.container-fluid{
	width : 1250px;
	margin-top : 20px;
	padding-top: 75px;
	background-color : white;
}

.wrap{
	width : 100%;
	margin : 10px auto;
	position : relative;
}
.cropping{
	margin-top : -10px;
	height :  400px;
	overflow:hidden;
}
.cropping img{
	max-height : initial;
	margin-top: -20%;
	filter:brightness(60%);
	transform: translate( 0px, 320px );
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
	transform: translate( 670px, -170px );
	font-size : 20pt;
	color : white;
}
.text3{
	font-family: 'Noto Sans KR', sans-serif;
}

/* ------------------------------------------------------------------- */

td {
	text-align: center;
}
.writeBtn{
	border : none;
	background-color: #1DE9B6 ;
	color: white;
	float : right;
	font-family: 'Noto Sans KR', sans-serif;
}
.reportBtn{
	font-family: 'Noto Sans KR', sans-serif;
	border : none;
	background-color: #1DE9B6 ;
	color: white;
	margin-right: 0%";
}
.searchBtn{
	border : none;
	background-color: #1DE9B6 ; 
	color: white;
	font-family: 'Noto Sans KR', sans-serif;
}
.writeBtn:hover, .reportBtn:hover, .searchBtn:hover{
	background-color : #FF7E47;
}
.table{
	margin-top : 30px;
}
.tableHead{
	font-family: 'Noto Sans KR', sans-serif;
	border : none;
	background-color: rgba( 29, 233, 182, 0.8 ) ; 
	text-align: center;
}
.search{
	float : right;
}

.content{
	cursor : pointer;
}
.page-link{
	cursor : pointer;
}

#logout{
   padding : 0px;
   margin-left : 12px;
   margin-right : 5px;
   border : none;
   background-color : white;
}
h6{ 
	font-size : 10pt;
}

/* ------------------------------------- */
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
}
.facilityList { 
    list-style-type :none;
    padding:0px;
    margin-top: 30px;
    margin-left : 30px;
  	margin :auto;
 	padding-left : 50px;
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

.navbar-nav{
	height : 100px;
	vertical-align : top;
}
.nav-item{
 border-collapse: collapse;
 box-sizing: border-box;
 display : inline-block;
}


#nav2{text-align:center;}
#nav2 p{ color : black;}

.container a{ color : black; text-decoration: none; }
.card-text {text-align : left;font-family: monospace; }

.nav-item2{cursor : pointer; margin : 10px;}

.hover{
   border-bottom: 3px solid black;   
   transform: scale(1.1); 
   transition-duration: 0.2s; 
 } 
.card{
	margin: -2px;
	 width:300px;
} 

.card-title{
	text-align: center;
}

.card-text{
	font-family: 'Noto Sans KR', sans-serif;
	color : gray;
}

.textsp{
	color : black;
}

.airportImg {
	width : 100%;
	height : 230px;	
}
.signupText {
	margin-left:10%;
}
</style>
<script>
	// 게시판 종류 여행가이드로 바꾸는 변수
	var boardType = "reviewboard";

	$(function(){
		
		// 검색버튼
		$('#searchBtn').on('click', function(){
			var searchType = $('#searchType').val();
			var searchContent = $('#searchContent').val();
			
			location.href = "<%= request.getContextPath() %>/board.do?job=list&board_type=" + boardType + "&" + searchType + "=" + searchContent;
		});
		
		// 게시글 선택
		$(document).on('click', '.content', function(){
			var board_id = $(this).attr('id');
			location.href = "<%= request.getContextPath() %>/board.do?job=detail&board_type=" + boardType + "&board_id=" + board_id;
		});
		
		// 게시글 작성
		$('#writeBtn').on('click', function(){
			location.href = "<%= request.getContextPath() %>/view/board/insertboard.jsp?board_type=" + boardType;
		});
		
		
		// 페이지 버튼 색상 처리
		activePageBtn();
		
	});
	
	
	function activePageBtn(){
		
		// 페이징에서 현재 선택된 페이지의 버튼 색상을 활성화
		var pageItems = $('.page-item');
		
		// 페이지값이 없을 경우 버튼 '1'을 활성화
		if(<%= request.getParameter("page") %> == null){
			$('.page-item[value=1]').attr('class', 'page-item active');
		}
		
		// 버튼들 중 현재 페이지와 같은 숫자의 버튼을 활성화
		$.each($(pageItems), function(i, v){
			if($(pageItems[i]).val() == <%= request.getParameter("page") %>){
				
				$(pageItems[i]).attr('class', 'page-item active');
				return false;
			}
		});
	}
	
	// 페이징
	function toPage(page){
		// 현재 URL를 가져온다.
		var url = location.href;
		
		// 만약 쿼리스트링에 "page" 키가 없을 경우
		if(url.indexOf("page") == -1){
			location.href = url + "&page=" + page;
		} else{
			// 쿼리스트링에 작성된 값들을 분리
			var queryString = url.substring(url.indexOf("?") + 1).split("&");
			
			// 분리된 값들 중 "page" 키를 찾아 새로 입력받은 페이지를 값으로 변경
			for(idx in queryString){
				if(queryString[idx].startsWith("page")){
					var pageQuery = queryString[idx].split("=")[0] + "=" + page;
				}
			}
			
			// 페이지 이동
			location.href = url.substring(0, url.indexOf("page")) + pageQuery;
		}
	}
	
	$(function(){
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
		memInfo = (MemberVO)session.getAttribute("memInfo");
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
		%>	</nav>
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
		<h1 class="text">분실물 센터</h1>
		<h3 class="text2"></h3>
		</div>
	</div>
</header>
<!-- main section -->
<section>

<div class="container-fluid">
	<div class="signupText">
	<h2 class="text3">공항 분실물센터</h2>
	<br>
		<p><span style="color : gray;">Home > 고객센터</span> > <b>분실물센터</b></p>
	</div>	
	<hr>
	<h6 class="signupText">(해당 링크로 이동하려면 사진을 클릭해주세요.)</h6>
	
	<div id="ulBox">
	<ul class="facilityList">
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-top" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=포항공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/포항공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">포항공항</h4>
				</div>
			</div>
		</li>
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-top" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=청주국제공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/청주공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">청주공항</h4>
				</div>
			</div>
		</li>
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-top" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=제주국제공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/제주공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">제주공항</h4>
				</div>
			</div>
		</li>
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-top" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=인천국제공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/인천공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">인천공항</h4>
				</div>
			</div>
		</li>
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-top" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=원주공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/원주공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">원주공항</h4>
				</div>
			</div>
		</li>
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-top" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=울산공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/울산공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">울산공항</h4>
				</div>
			</div>
		</li>
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-top" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=여수공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/여수공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">여수공항</h4>
				</div>
			</div>
		</li>
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-top" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=양양국제공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/양양공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">양양공항</h4>
				</div>
			</div>
		</li>
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-top" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=사천공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/사천공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">사천공항</h4>
				</div>
			</div>
		</li>
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-top" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=무안국제공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/무안공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">무안공항</h4>
				</div>
			</div>
		</li>
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-tp" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=대구국제공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/대구공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">대구공항</h4>
				</div>
			</div>
		</li>
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-top" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=김해국제공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/김해공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">김해공항</h4>
				</div>
			</div>
		</li>
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-top" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=김포국제공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/김포공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">김포공항</h4>
				</div>
			</div>
		</li>
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-top" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=군산공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/군산공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">군산공항</h4>
				</div>
			</div>
		</li>
		<li id="list" class="info1">
			<div class="card">
			    <div class="card-img-top" ><a href="https://www.lost112.go.kr/find/findList.do?DEP_PLACE=광주공항"><img class="airportImg" src="<%= request.getContextPath() %>/images/airport/광주공항.PNG" class="rounded" alt="Card image" style="width:100%"></a></div>    
				<div class="card-body">
					<h4 class="card-title">광주공항</h4>
				</div>
			</div>
		</li>
		
	</ul>
	</div>
	</div>
</section>

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
</body>
</html>