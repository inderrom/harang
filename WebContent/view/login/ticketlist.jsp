<%@page import="com.harang.vo.PageVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.harang.vo.TicketVO"%>
<%@page import="java.util.List"%>
<%@page import="com.harang.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 예매정보</title>
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
  
<%
	MemberVO memInfo = (MemberVO) session.getAttribute("memInfo");
	if(memInfo == null){
%>
<script type="text/javascript">
		alert("로그인이 필요합니다.");
		location.href="<%= request.getContextPath() %>/view/login/login.jsp";
</script>
<%
	}
%>
 <script>
	$(function(){
		$('#mainMenuList li').on('mouseenter', function(){
			$('#subMenuList').slideDown();
		});
		$('#subMenuList').on('mouseleave', function(){
			$('#subMenuList').slideUp();
		});
		
		
		// -----------------------------------------------------------
		
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
		
		// 예매번호 클릭 시
		$(document).on('click', '.modaling', function(){
			
			var fliId = $(this).parents('tr').find('.fliId').text();
			fliId = fliId.trim();
			
			var ticketId = $(this).text();
			ticketId = ticketId.trim();
			
			getFlightInfo(fliId);
			getPssgInfo(ticketId);
			
			$("#myModal").modal();
		});
		
		
		// 페이지 버튼 색상 처리
		activePageBtn();
	})
	
	// 페이지 버튼 색상 처리
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
	
	// 모달에 항공편 정보를 삽입한다.
	function getFlightInfo(fliId){
		$.ajax({
			url : '<%= request.getContextPath() %>/flight.do',
			data : {
				"job" : "flight",
				"fliId" : fliId
			},
			type : 'post',
			success : function(res){
				$('#depport').text(res.fli_depport);
				$('#arrport').text(res.fli_arrport);
				$('#airlineName').text(res.airline_name)
				$('#fliId').text(res.fli_id);
				
				var depTime = res.fli_deptime.substring(0, 2) + ":" + res.fli_deptime.substring(2);
				var arrTime = res.fli_arrtime.substring(0, 2) + ":" + res.fli_arrtime.substring(2);
				
				$('#deptime').text(depTime);
				$('#arrtime').text(arrTime);
			},
			error : function(err){
				alert(err.status + " : " + err.statusText);
			},
			dataType : 'json'
		});
	}
		
	// 모달에 탑승객 정보를 삽입한다.
	function getPssgInfo(ticketId){
		$.ajax({
			url : '<%= request.getContextPath() %>/ticket.do',
			data : {
				"job" : "passenger",
				"ticketId" : ticketId
			},
			type : 'post',
			success : function(res){
				
				var code = "";
				
				$.each(res, function(i, v){
					code += "<h5>이름 : <span class='pssgName'>" + v.pssg_name + "</span></h5>";
					code += "<h5>생년월일 : <span class='pssgBir'>" + v.pssg_bir.split(" ")[0] + "</span></h5>";
					code += "<h5>좌석번호 : <span class='seat'>" + v.pssg_seat + "</span></h5>";
					code += "<hr/>";
				});
	         	
				$('#pssgInfo').html(code);
			},
			error : function(err){
				alert(err.status + " : " + err.statusText);
			},
			dataType : 'json'
		});
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
	background : linear-gradient(rgba( 29, 233, 182, 0.65 ), white);
}
.container-fluid{
	width : 1250px;
	margin-top : 50px;
	padding : 100px;
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
	transform: translate( 0px, 320px );
	z-index : 2;
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
	background-color : #1DE9B6 ; 
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

h6{
	font-size : 10pt;
}
#logout{
	padding : 0px;
	margin-left : 12px;
	margin-right : 5px;
	border : none;
	background-color : white;
}
#profile{
	border : none;
	background-color: white;
}
.profile h5{
	margin-left : 20px;
	font-size : 15pt;
	font-family: 'Noto Sans KR', sans-serif;
}
.listUl{
	margin : 0px;
}
/* 모달 스타일 */
.modalForm{
	font-family: 'Noto Sans KR', sans-serif;
	text-align : center;
}
.right{
	margin : 0px 50px 0px 50px; 
	color : #FF7E47;
}
.depart_arriv{
	font-size : 25px;
}
.seat{
	color : #FF7E47;
}
.page-link{
	cursor : pointer;
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
	</div>
</header>
<!-- main section -->
<section>

<div class="container-fluid">
	<div>
		<h2 class="text3">나의 예매정보</h2>
	</div>
	
	<hr/>
	<div>
		<table class="table">
			<thead class="tableHead">
				<tr>
					<th>예매번호</th>
					<th>항공사명</th>
					<th>항공편명</th>
					<th>출발날짜</th>
				</tr>
			</thead>
			<tbody>
			<%
				// 회원의 예매정보
				List<TicketVO> ticketList = new ArrayList<>();
				List<?> tempTicketList = (List<?>) request.getAttribute("ticketList");
				if(tempTicketList != null){
					for(Object obj : tempTicketList){
						if(obj instanceof TicketVO){
							ticketList.add((TicketVO) obj);
						}
					}
				}
				
				
				if(ticketList.size() == 0){
			%>
				<tr>
					<td colspan="4">예매정보가 없어요.</td>
<!-- 					<td><a class="modaling" data-toggle="modal" href="#myModal">KALFLIGHTWINGS1234-12345</a></td><td>대한항공</td><td>KAL707</td><td>2022-11-12 17:30:40</td> -->
				</tr>
			<%
				} else {
					for(int i = 0; i < ticketList.size(); i++){
						TicketVO ticketVo = ticketList.get(i);
						String date = ticketVo.getTicket_date().split(" ")[0];
			%>
				<tr>
					<td><a class="modaling" data-toggle="modal" href="#myModal"><%= ticketVo.getTicket_id() %></a></td>
					<td><%= ticketVo.getAirline_name() %></td>
					<td class="fliId"><%= ticketVo.getFli_id() %></td>
					<td><%= date %></td>
				</tr>
			<%
					}
				}
			%>
			</tbody>
		</table>
		<hr>
	</div>
	<div>
		<ul class="pagination justify-content-center listUl">
			<%
				PageVO pageVo = (PageVO) request.getAttribute("pageVo");
			
				if(pageVo.getStartPage() > 1){
			%>
					<li class="page-item"><a class="page-link" onclick="toPage(<%= pageVo.getStartPage() - 1 %>)" id="prevBtn">Prev</a></li>
			<%
				}
				
				for(int i = pageVo.getStartPage(); i <= pageVo.getEndPage(); i++){
			%>
					<li value="<%= i %>" class="page-item"><a class="page-link" onclick="toPage(<%= i %>)"><%= i %></a></li>
			<%
				}
				
				if(pageVo.getEndPage() < pageVo.getTotalPage()){
			%>
					<li class="page-item"><a class="page-link" onclick="toPage(<%= pageVo.getEndPage() + 1 %>)">Next</a></li>
			<%
				}
			%>
		</ul>
	</div>
	
	<!-- The Modal -->
  <div class="modal fade modalForm" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">나의 예매 정보</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
         	<div>출발지<span class="right">&nbsp;&nbsp; --- &nbsp;&nbsp;</span>도착지</div>
         	<div class="depart_arriv">
         		<span id="depport"></span> <span class="right">>>></span> <span id="arrport"></span>
         		<hr/>
         	</div>
         	<div>항공사명&nbsp;<span class="right">:</span>&nbsp;항공편명</div>
         	<div class="depart_arriv">
         		<span id="airlineName"></span><span class="right"></span><span id="fliId"></span>
         		<hr/>
         	</div>
         </div>
         	
         	<div>출발시간 <span class="right">&nbsp;&nbsp; --- &nbsp;&nbsp;</span> 도착시간</div>
         	<div class="depart_arriv">
         		<span id="deptime"></span><span class="right">>>></span><span id="arrtime"></span>
         		<hr/>
         		
         	</div>
         	
         	<div style="margin-top : 30px;">
         		<hr/>
         		<h3>탑승객 정보</h3>
         		<hr/>	
         	</div>
         	
         	<div id="pssgInfo" style="text-align : center; margin: 0px 0px 30px 0px;">
<!--          		<h5>이름 : <span class="pssgName"></span></h5> -->
<!-- 	         	<h5>생년월일 : <span class="pssgBir"></span></h5> -->
<!-- 	         	<h5>좌석번호 : <span class="seat">A03</span></h5> -->
<!-- 	         	<hr/> -->
	         	
<!--          		<h5>이름 : 두명인경우</h5> -->
<!-- 	         	<h5>생년월일 : 1997/11/24</h5> -->
<!-- 	         	<h5>좌석번호 : <span class="seat">A03</span></h5> -->
<!-- 	         	<hr/> -->
         	</div>
	         	
         	
	        <!-- Modal footer -->
    	    <div class="modal-footer">
    	      <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
    	    </div>
        </div>
        
        
      </div>
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