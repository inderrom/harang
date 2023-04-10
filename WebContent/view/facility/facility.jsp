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
  <link rel="icon" href="<%=request.getContextPath() %>/images/layout/Union.png">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/navbar.css">
  
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
});// function
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
	max-width : 1250px;
	margin-top : -85px;
	padding-top : 75px;
	background-color : white;
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
.topDiv1{
	height : 50px;
/* 	background-color : #013E8D; */
/* 	background-color : rgba( 29, 233, 182, 0.9 ); */
	background-color : #0C654F;
	text-align : center;
	padding-top : 11px;
	color : white;
	font-family: 'Noto Sans KR', sans-serif;
}
.topDiv2{
	height : 50px;
/* 	background-color : #013E8D; */
/* 	background-color : rgba( 29, 233, 182, 0.9 ); */
	background-color : #0C654F;
	text-align : center;
	padding-top : 11px; 
/* 	margin-bottom : 10px; */
	color : white;
	font-family: 'Noto Sans KR', sans-serif;
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
.text{
	position : absolute;
	transform: translate( 800px, -200px );
	font-size : 30pt;
	color : white;
}
/*---------------------------------*/
#ulBox{
	padding : 50px;
	padding-left: 109px;
}
.facilityList { 
    list-style-type :none;
    padding:0px;
    margin-top: 30px;
    margin-left : 30px;
  	margin :auto;
 	padding-left : 0px;
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
	margin : auto;
	vertical-align : top;
}
.nav-item{
	border-collapse: collapse;
	box-sizing: border-box;
	display : inline-block;
}


#nav2{
	text-align:center;
	height : 130px;
}
#nav2 p{
	color : black;
	margin : 0px;
}

.container a{
	color : black;
	text-decoration: none;
}
.card-text {
	text-align : left;
	font-family: monospace;
}

.nav-item2{
	cursor : pointer;
	margin : 10px;
	width : 100px;
	height : 100px;
 }

/* .hover{ */
/* 	border-bottom: 3px solid black;    */
/* 	transform: scale(1.1);  */
/* 	transition-duration: 0.2s;  */
/* } */
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
.airport{
	background-color : white;
	border : 2px solid #0C654F;
	color : #0C654F;
	width : 81.35px;
	height : 50px;
	border-radius : 0px;
	font-size : 14pt;
	font-family: 'Noto Sans KR', sans-serif;
}
.airport:hover{
	background : #FF7E47;
	border : none;
}

.listUl{
	padding : 0px;
	margin : 0px;
}
.card{
	transition : 300ms;
}
.card:hover{
	box-shadow : 3px 3px 5px 3px grey;
}

.nav-item2:hover{
	border-bottom : 3px solid black;
}
</style>

</head>
<body>

<!-- header navbar -->
<header>
<nav class="navbar navbar-expand-sm bg-white navbar-white">
	<a class="navbar-brand" href="<%= request.getContextPath() %>/view/main/mainIndex.jsp"  style="color:#1DE9B6;"><img src="<%=request.getContextPath() %>/images/layout/Union.png" id="icon"> Harang</a>
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
			<h5><%= memInfo.getMem_name() %>님 환영합니다.</h5>
			</div>
		<%
			} else {
		%>
			<!-- 로그인 되지 않았을때 -->
			<button type="button" class="btn btn-primary" id="login" onclick="location.href='<%= request.getContextPath()%>/view/login/login.jsp'">LOGIN</button>	
		<%
			}
		%>
<!-- 		<div class="col-sm-3 auto"></div>	 -->
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
	<div class="wrap">
		<div class="cropping">
			<img src="<%=request.getContextPath()%>/images/layout/main02.png">
		</div>
		<div class="col-lg-8">
			<h1 class="text">공항시설 정보</h1>
		</div>
	</div>
</header>
	
<section class="infoList">
<div class="container-fluid">
  
  <!-- 공항 선택 버튼 -->

<div class="col-sm-12 topDiv1"><h5>공항선택</h5></div>
	<nav id="airport_result" class=" navbar navbar-expand-xl" style="padding : 0px;">
	  <ul class="navbar-nav listUl">
	  </ul>
	</nav>
  
 <div style="border : 1px solid gray;">
  <div class="col-sm-12 topDiv2"><h5>시설 카테고리</h5></div>	
  <nav id="nav2" class="navbar navbar-expand-sm">
  </nav>
  
</div>
	<div id="ulBox">
	</div>
</div>
</section>

<!-- footer section -->
<div style="margin-bottom:0;">
  	<footer>
	  	<hr/>
  			<div id="footerDiv">
  				<p>전 세계 저가 항공권을 비교하고 예약하세요</p>
				<p>ⓒ HARANG Ltd. 2022-</p>
  			</div>
  	</footer>
</div>

<script type="text/javascript">


$(function(){
	
	$(document).on('click', '.airport', function(){
		$('.nav-item2').css('border-bottom', '');
// 		$(this).css('border-bottom', '3px solid black');
	});
	
	// navbar 클릭시 밑줄 이벤트
	$(document).on('click', '.nav-item2', function(){
		$('.nav-item2').css('border-bottom', '');
//			$('.nav-item2').each(function(i, v){
//				$(v).css('border-bottom', '');
//			});
		$(this).css('border-bottom', '3px solid black');
	});
	
})

getData();

//공항명 가져오는 메서드
function getData(){
	$.ajax({
		type: 'get',
		data : { "category" : 'facility'},
		dataType: 'json',
		url : "<%= request.getContextPath() %>/facility.do",
		success: function(data){
			var tmp_obj = {};
			
			var html = '';
			
			$('#airport_result').html(html);
				html += '<ul class="navbar-nav listUl">';
				
			$.each(data, function(i, v){ // i= 맵(키) , v=맵(value)
				
				html += ' <li class="nav-item">';
				html += ' <button type="button" id="airport_'+i+'" class="btn btn-primary airport" onclick="getFacility(\'' + i + '\', $(this));">'+i+'</button>';
				html += '</li>';
				
				if(tmp_obj[i] == null) tmp_obj[i] = {};
				$.each(v, function(i1, v1){
					if(tmp_obj[i][v1.fac_type] == null) tmp_obj[i][v1.fac_type] = [];
					tmp_obj[i][v1.fac_type].push(v1);
				}); //중간 each문
				
			});//each 끝
			
			html+='</ul>';
			dataSet = tmp_obj;
			$('#airport_result').html(html);
			
			// 공항 선택 시 색변경
			$(".airport").on('click', function(e) { 
				$('.airport').css('background-color','').css('color','').css('border',''); 
				$(this).css('background-color','#FF7E47').css('color','white').css('border','none'); 
			}); 
			
			$('#airport_김포').click();
			
		}
	});
} // getData()

//시설 카테고리 가져오기
function getFacility(ariportName, el) {
	
	var html = '';
	var storehtml = "";
	
	$('#nav2').html(html);
	$('#ulBox').html(storehtml);
	
	html += '<ul class="navbar-nav">';
	
	
	$.each(dataSet[ariportName], function(i, v){
		
		var img=i.replace("/", "_");
// 		html += '<button type="button" class="btn btn-md btn-outline-primary mx-1 facility-item" onclick="getFile(\''+ariportName+'\', \''+i+'\', $(this));">'+i+'</button>';
			
		html += '<li class="nav-item2" id="ni1" title="' + i + '" onclick="getFile(\''+ariportName+'\', \''+i+'\', $(this));" alt="'+i+'">';
		html += '<img src="<%= request.getContextPath() %>/images/facility/facilityinfo/' + img  + '.png" style="width:60%;">';
		html += '<p>' + i + '</p>';
		html += '</li>';
		
		storehtml+='<ul class="facilityList" style="display:inline;">';
		
		$.each(v, function(i3, v3) { //뭐지?
			storehtml += '<li id="list" class="info1">';
			storehtml += '<div class="card">';
			storehtml += '<div class="card-img-top" >';
			storehtml += '<img src="<%= request.getContextPath() %>' + v3.fac_file + '" class="rounded" alt="Card image" style="width:100%">';
			storehtml += '</div>';
			storehtml += '<div class="card-body" style="height:210px;">';
			storehtml += '<p class="card-title" >' + v3.fac_name + '</p>';
			storehtml += '<hr>';
			storehtml += '<p class="card-text">위치 : <span class="textsp">' + v3.fac_pos + '</span></p>';
			storehtml += '<p class="card-text">시설분류 : <span class="textsp">' + v3.fac_type + '</span></p>';
			storehtml += '</div>';
			storehtml += '</div>';
			storehtml += '</li>';
		});
		
		storehtml+='</ul>';
		$('#ulBox').html(storehtml);
	});
		html += '</ul>';
	$('#nav2').html(html);
}//getFacility

// 사진을 출력하는 함수
function getFile(ariportName, fac_type, el){
	
// 	$.each($('.nav-item2'), function(i, v){
// 	$.each(el, function(i, v){
		// navbar hover 이벤트		
// 		$(this).hover(this, function(){
// 			$(this).addClass('hover');
// 		}, function() {
// 			$(this).removeClass('hover');
// 		});
// 	});
	
	var html = '';
	$('#ulBox').html(html);
	
	html+='<ul class="facilityList">';
	$.each(dataSet[ariportName][fac_type], function(i, v){
		
		html += '<li id="list" class="info1">';
		html += '<div class="card">';
		html += '<div class="card-img-top">';
		html += '<img src="<%= request.getContextPath() %>' + v.fac_file + '" class="rounded" alt="Card image" style="width:100%">';
		html += '</div>';
		html += '<div class="card-body" style="height:210px;">';
		html += '<p class="card-title" >'+v.fac_name+'</p>';
		html += '<hr>';
		html += '<p class="card-text">위치  : <span class="textsp">'+v.fac_pos+'</span></p>';
		html += '<p class="card-text">시설분류 : <span class="textsp">'+v.fac_type+'</span></p>';
		html += '</div>';
		html += '</div>';
		html += '</li>';
	});
	html+='</ul>';

	$('#ulBox').html(html);
}//getFile
</script>

</body>
</html>