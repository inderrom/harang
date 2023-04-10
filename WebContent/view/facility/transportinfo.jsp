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
  <link rel="icon" href="<%=request.getContextPath() %>/images/layout/Union.png">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/navbar.css">
  
  <!-- 폰트적용 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@900&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">

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
	
/* 	공항 목록 */
.topDiv{
	height : 50px;
/* 	background-color : #013E8D; */
/* 	background-color : rgba( 29, 233, 182, 0.9 ); */
	background-color : #0C654F;
	text-align : center;
	padding-top : 11px; 
	color : white;
	font-family: 'Noto Sans KR', sans-serif;
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
.nav-item2{
	cursor : pointer;
	margin : 10px;
	width : 107px;
	height : 80px;
 }
.transport{
	background-color : #0C654F;
	border : none;
	border-left : 1px solid white;
	color : white;
	width : 203.3px;
	height : 50px;
	border-radius : 0px;
	font-size : 14pt;
	font-family: 'Noto Sans KR', sans-serif;
}
.tableImgBox{
	text-align:center; 
	display:table; 
	width:1220px; 
/* 	height:700px; */
}
.imgBox{
	 display:table-cell; 
	 vertical-align:middle;
}
.imageSize{
	 max-width:1200px; 
	 max-height:700px;
	 margin-bottom: 50px;
	 margin-top: 50px;
}

.table{
	margin-top : 30px;
}
.tableHead{
	font-family: 'Noto Sans KR', sans-serif;
	border : none;
	background-color: #0C654F;
	color : white; 
	text-align: center;
}
tbody{
	text-align : center;
}
.transport_result{
	 margin-bottom: 50px;
	
}
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
			<div class="col-md-12" id="subMenuList" style="display: none;">
				<div class="col-md-4" style="margin-right : 50px;"></div>
				<div class="subMenuBlock">
					<ul class="subMenu">
						<li><a href="javascript:void(0)" id="goSearchAirplane">항공권 예매</a></li>
					</ul>
				</div>
				<div class="subMenuBlock">
					<ul class="subMenu">
						<li><a href="javascript:void(0)" id="goDepart_ArrivBoardInfo">출발/도착안내</a></li>
						<li><a href="javascript:void(0)" id="goFacilityInfo">시설안내</a></li>
						<li><a href="javascript:void(0)" id="goParkingInfo">주차안내</a></li>
						<li><a href="javascript:void(0)" id="goTransportinfo">대중교통안내</a></li>
					</ul>
				</div>
				<div class="subMenuBlock" style="padding-left : 30px;">
					<ul class="subMenu">
						<li><a href="javascript:void(0)" id="goGuidboard">여행가이드</a></li>
						<li><a href="javascript:void(0)" id="goReviewboard">여행후기</a></li>
						<li><a href="javascript:void(0)" id="goFreeboard">자유게시판</a></li>
					</ul>
				</div>
				<div class="subMenuBlock" style="padding-left : 50px;">
					<ul class="subMenu">
						<li><a href="javascript:void(0)" id="goNoticeboard">공지사항</a></li>
						<li><a href="javascript:void(0)" id="goLost">분실물센터</a></li>
						<li><a href="javascript:void(0)" id="goQuesboard">문의게시판</a></li>
					</ul>
				</div>
				<div class="col-md-4 auto"></div>
			</div>
		</div>
	</nav>
	<!-- 메인이미지  -->
	<div class="wrap">
		<div class="cropping">
			<img src="<%=request.getContextPath() %>/images/layout/travelguidemain.jpg">
		</div>
		<div class="col-lg-8">
			<h1 class="text">대중교통 정보</h1>
		</div>
	</div>
</header>

<section>
	<div class="container-fluid">


<!-- 들어가는 모습 확인용 - 백엔드 연결시 밑은 지우고 위에거 살리면됨 -->

<div>
		<h2 class="text3">대중교통</h2>
		<br>
		<p><span style="color : gray;">Home > 안내</span> > <b>대중교통안내</b></p>
	</div>

	<div style="margin-bottom : 50px;">
		<hr/>
		<h6>* 본 대중교통 정보는 각 도로교통공사의 이미지를 참조하였습니다.</h6>	
		<h6>* 대중교통의 자세한 위치는 각 항공사의 안내데스크를 방문하시면 더욱 빠른 안내를 받으실 수 있습니다.</h6>
		<h6>* 공항을 먼저 선택한 뒤 대중교통 정보를 선택하여 확인이 가능합니다.</h6>
		<hr/>
	</div>

	<div class="col-sm-12 topDiv"><h5>공항선택</h5></div>
	<nav class=" navbar navbar-expand-xl airport_result" style="padding : 0px;">
	 
	</nav>
	
	<hr>
	
	<nav class=" navbar navbar-expand-xl transport_result" style="padding : 0px;">
	  
    </nav>
    
   		<div class="tableImgBox" id="tranFile_result">
   			
   		</div>
	<!-- 		버스 눌렀을 때, 버스이미지가 여러장이면 이 글위로 올라오도록 해주십시오   		 -->
	   		<div id='price_result' style="margin-bottom: 50px;">
	   			<h6> * 시외버스 이용 시 반드시 티켓 사전 발권이 필요합니다. (무인발권기 이용)</h6>
	   			<h6> * 버스 기본 요금 정보는 최종 목적지에 대한 요금으로, 중간경유지 요금은 버스타고(http://www.bustago.or.kr)에서 확인하여 주시기 바랍니다.</h6>
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
		var facility = {};
		var routePrice ={};
		var routePriceList ={};
		var type='';
// 		getPrice();
		getData(); 

//공항명 가져오는 메서드 
function getData(){ 
	var carry ={};
	$.ajax({ 
		type: 'get', 
		data : { "category" : 'route'},
		dataType: 'json', 
		url : "<%=request.getContextPath()%>/facility.do",
		success: function(data){
			console.log('getdata',data )
			routePrice=data;
			getTransport1();
		},
		async: false,
		error : function (xhr) {
			alert("상태 : "+ xhr.status);
		}
	}); // 1번째 ajax
};// getData()

function getTransport1() {
	$.ajax({ 
		type: 'get', 
		data : { "category" : 'transport' },
		dataType: 'json', 
		url : "<%=request.getContextPath()%>/facility.do",
		success: function(data){
 					console.log('getTransport',data )
			facility=data;
			var html = '';
			$('.airport_result').html(html);
			
				html += '<ul class="navbar-nav listUl">';
			$.each(facility, function(i, v){ // i= 맵(키) , v=맵(value)
				
				html += ' <li class="nav-item">';
				html += ' <button type="button" id="airport_'+i+'" class="btn btn-primary airport" onclick="getTransport(\''+i+'\', $(this));">'+i+'</button>';
				html += '</li>';
				
			});//each 끝
				html+='</ul>';
			$('.airport_result').html(html);
			
			// 공항 선택 시 색변경
			$(".airport").on('click', function(e) { 
				$('.airport').css('background-color','').css('color','').css('border',''); 
				$(this).css('background-color','#FF7E47').css('color','white').css('border','none'); 
			}); 
			
			
			
	 		getPrice(); // 로딩실행
			
		}// success
	});// 2번째 ajax
}

function getTransport(airport, el){
	routePriceList=routePrice[airport];
	
		
		var html = '';
		$('.transport_result').html(html);
		html +='<ul class="navbar-nav listUl">';
		$.each(facility[airport], function(i, v){
			if(v.tran_file!=null){
				html +=' <li class="nav-item">';
				html +='<button type="button" id="transport_'+v.tran_type+'" class="btn btn-primary transport" onclick="getFile(\''+v.tran_file+'\',\''+ v.tran_type +'\' ,$(this));">'+v.tran_type+'</button>';
				html +='</li>';
			}else {
				html +=' <li class="nav-item">';
				html +='<button type="button" id="transport_'+v.tran_type+'" class="btn btn-primary transport" onclick="getTaxi(\''+ v.tran_type +'\' ,$(this));">'+v.tran_type+'</button>';
				html +='</li>';
				
			}
		});
		html +='</ul>';
		
		$('.transport_result').html(html);
		
		
}; //getTransport()

function getFile(tran_file,price, el){
			
			var pricehtml='';
			$('#price_result').html(pricehtml);
			
			pricehtml+='<table class="table">';
			pricehtml+='<thead class="tableHead">';
			pricehtml+='	<tr>';
			pricehtml+='	<th>노선 이름</th>';
			pricehtml+='	<th>교통 종류</th>';
			pricehtml+='	<th>가 격</th>';
			pricehtml+='	</tr>';
			pricehtml+='</thead>';
			pricehtml+='<tbody>';
			$.each(routePriceList, function(i, v) {
				if(price ==v.TRAN_TYPE.replace(/"/g,"")){
					pricehtml+='<tr><td>'+v.ROUTE_NAME+'</td><td>'+v.TRAN_TYPE+'</td><td>'+v.ROUTE_PRICE+'</td></tr>';
				}
				
			});
			
			pricehtml+='</tbody>';
			pricehtml+='</table>';
			$('#price_result').html(pricehtml);
		
	var html = '';
	$('#tranFile_result').html(html);
	
	html += '<div class="imgBox">';
	html += '<img class="imageSize" src="<%=request.getContextPath()%>/images/transport/'+tran_file+'.png">';
	html += '</div>';
	$('#tranFile_result').html(html);
	
	
};//getFile()

function getTaxi(price,el){
	var pricehtml='';
	$('#price_result').html(pricehtml);
	
		pricehtml+='<table class="table">';
		pricehtml+='<thead class="tableHead">';
		pricehtml+='	<tr>';
		pricehtml+='	<th>노선 이름</th>';
		pricehtml+='	<th>교통 종류</th>';
		pricehtml+='	<th>가 격</th>';
		pricehtml+='	</tr>';
		pricehtml+='</thead>';
		pricehtml+='<tbody>';
		$.each(routePriceList, function(i, v) {
		if(price ==v.TRAN_TYPE.replace(/"/g,"" )){
			pricehtml+='<tr><td>'+v.ROUTE_NAME+'</td><td>'+v.TRAN_TYPE+'</td><td>'+v.ROUTE_PRICE+'</td></tr>';
		}
		
	});
	var html = "";
	$('#tranFile_result').html(html);
		pricehtml+='</tbody>';
		pricehtml+='</table>';
	$('#price_result').html(pricehtml);
}

function getPrice() { //수리중(로딩시 페이지)
	$.ajax({ 
			type: 'get', 
			data : { "category" : 'route'},
			dataType: 'json', 
			url : "<%=request.getContextPath()%>/facility.do",
			success: function(data){
				routePrice=data;
				console.log(routePrice["김포"])
				console.log(facility)
				routePriceList=routePrice["김포"];
				var html = '';
				
				$('.airport_result').html(html);
				
					html += '<ul class="navbar-nav listUl">';
				$.each(facility, function(i, v){ // i= 맵(키) , v=맵(value)
					
					html += ' <li class="nav-item">';
					html += ' <button type="button" id="airport_'+i+'" class="btn btn-primary airport" onclick="getTransport(\''+i+'\', $(this));">'+i+'</button>';
					html += '</li>';
					
				});//each 끝
				
					html+='</ul>';
				$('.airport_result').html(html); // 공항 이름 가져옴
				
				
				
				var airporthtml="";
	 			var rotuehtml="";
	 			$('.transport_result').html(airporthtml);
	 			airporthtml +='<ul class="navbar-nav listUl">';
	 			$.each(facility["김포"], function(i1, v1){
	 				console.log(v1)
	 				console.log(i1)
	 				if(v1.tran_file!=null){
	 					airporthtml +=' <li class="nav-item">';
	 					airporthtml +='<button type="button" id="transport_'+v1.tran_type+'" class="btn btn-primary transport" onclick="getFile(\''+v1.tran_file+'\',\''+ v1.tran_type +'\' ,$(this));">'+v1.tran_type+'</button>';
	 					airporthtml +='</li>';
	 				}else {
	 					airporthtml +=' <li class="nav-item">';
	 					airporthtml +='<button type="button" id="transport_'+v1.tran_type+'" class="btn btn-primary transport" onclick="getTaxi(\''+ v1.tran_type +'\' ,$(this));">'+v1.tran_type+'</button>';
	 					airporthtml +='</li>';
	 				}
	 			});
	 				airporthtml +='</ul>'
	 			$('.transport_result').html(airporthtml);
	 				
// 	 				$('#airport_김포').click();
// 	 				$('#transport_버스(국내선)').click();
	 				getFile(facility["김포"][4].tran_file,facility["김포"][4].tran_type);
	 				
			} // success
		}); // 1번째 ajax
		
		
}
</script>
</body>
</html>