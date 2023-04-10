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
<title>여행가이드게시판</title>
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

 <!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"/>
 <script>
<%
	// JSP문서에서 세션은 'session'이라는 이름으로 저장되어 있다.
	MemberVO memInfo = (MemberVO)session.getAttribute("memInfo");
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
	height : 300px;
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

/* ------------------------------------------------------------------------- */
/* swiper css입니다. 건들면 내가 좀많이 힘듭니다...*/
  .swiper {
    width: 100%;
    height: 500px;
  }

  .swiper-slide {
    text-align: center;
    font-size: 18px;
    background: #fff;

    /* Center slide text vertically */
    display: -webkit-box;
    display: -ms-flexbox;
    display: -webkit-flex;
    display: flex;
    -webkit-box-pack: center;
    -ms-flex-pack: center;
    -webkit-justify-content: center;
    justify-content: center;
    -webkit-box-align: center;
    -ms-flex-align: center;
    -webkit-align-items: center;
    align-items: center;
  }

  .swiper-slide img {
    display: block;
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
/*  ---------------------------------------------------- */
.pagination{
	margin : 0px;
}

</style>
<script>
	
	var boardType = "guideboard";

	$(function(){
		
		// 검색버튼
		$('#searchBtn').on('click', function(){
			var searchType = $('#searchType').val();
			var searchContent = $('#searchContent').val();
			
			if(searchContent.length == 0){
				alert("내용을 입력해주세요.");
				return false;
			}
			
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
		<h1 class="text">여행 가이드</h1>
		<h3 class="text2"></h3>
		</div>
	</div>
</header>
<!-- main section -->
<section>

<div class="container-fluid">

	<div>
		<h2 class="text3">여행가이드</h2>
		<br>
		<p><span style="color : gray;">Home > 커뮤니티</span> > <b>여행가이드</b></p>
	</div>

		  <!-- Swiper -->
		<div class="swiper mySwiper">
		  <div class="swiper-wrapper">
		  <%
			List<BoardVO> boardList = new ArrayList<>();
			
			List<?> tempList = (List<?>) request.getAttribute("boardList");
			for(Object obj : tempList){
				if(obj instanceof BoardVO){
					boardList.add((BoardVO) obj);
				}
			}
			
			List<BoardVO> guideList = new ArrayList<>();
			List<?> tempGuideList = (List<?>) request.getAttribute("guideList");
			for(Object obj : tempGuideList){
				if(obj instanceof BoardVO){
					guideList.add((BoardVO) obj);
				}
			}
			
			// 오류. 페이지가 바뀌었을 때는 해당 페이지의 이미지를 가져오게 된다.
			// 등록된 모든 게시글 중에 최신 5건만 가져와야한다.
			
			// 가장 최근에 등록된 게시물 5건의 이미지를 사용한다.
			int count = 5;
			if(guideList.size() < 5) count = guideList.size();
			
			for(int i = 0; i < count; i++){
				BoardVO guideVo = guideList.get(i);
				String content = guideVo.getBoard_content();
				String imageData = "";
				
				int dataStart = content.indexOf("src=\"data:image");
				int dataEnd = content.indexOf("\" ", dataStart);
				
				if(dataStart > 0 && dataEnd > 0){
					imageData = content.substring(content.indexOf("data:image"), dataEnd);
		  %>
				    <div class="swiper-slide">
				    	<img src="<%= imageData %>">
				    </div>
		  <%
				}
			}
		  %>
<!-- 		    <div class="swiper-slide"> -->
<%-- 		    	<img src="<%= request.getContextPath() %>/images/board/뮤직커버리.jpg"> --%>
<!-- 		    </div> -->
<!-- 		    <div class="swiper-slide"> -->
<%-- 		    	<img src="<%= request.getContextPath() %>/images/board/OsakaTravel.jpg"> --%>
<!-- 		    </div> -->
		  </div>
		      <div class="swiper-button-next" style="color : white;"></div>
		     <div class="swiper-button-prev" style="color : white;"></div>
		     <div class="swiper-pagination"></div>
		</div>
		<br/>
		
	<div class="row">
		<div class="col-lg-8">
<!-- 		<input type="date">-<input type="date"> -->
		</div>
		<div class="col-lg-4">
			<div class="search">
				<select id="searchType">
					<option value="board_title">제목</option>
					<option value="board_content">내용</option>
					<option value="mem_nick">작성자</option>
				</select>	
				<input type="text" id="searchContent">
				<button type="button" class="btn btn-primary btn-md searchBtn" id="searchBtn">검색</button>
			</div>
		</div>
	</div>
	<hr/>
	<div>
		<table class="table">
			<thead class="tableHead">
				<tr>
					<th style="width:10%;">글 번호</th>
					<th colspan ="3" style="width:40%;">제목</th>
					<th style="width:15%;">작성자</th>
					<th style="width:25%;">작성일</th>
					<th style="width:10%;">조회수</th>
				</tr>
			</thead>
			<tbody>
				<%
					if(boardList.size() == 0){
				%>
						<tr>
							<td colspan="7">게시글이 존재하지 않습니다.</td>
						</tr>
				<%	
					} else{
						for(int i = 0; i < boardList.size(); i++){
							BoardVO vo = boardList.get(i);
				%>
						<tr class="content" id="<%= vo.getBoard_id() %>">
							<td><%= vo.getBoard_id() %></td><td colspan ="3"  ><%= vo.getBoard_title() %></td><td><%= vo.getMem_nick() %></td><td><%= vo.getBoard_date() %></td><td><%= vo.getBoard_hit() %></td>
						</tr>
				<%
						}
					}
				%>
					
					
<!-- 				<tr> -->
<!-- 					<td>1</td><td colspan ="3"  ><a href="#">가나다라마바사아자차카타파하</a></td><td>심동근</td><td>sysdate</td><td>1</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>2</td><td colspan ="3"  ><a href="#">i got a feeling</a></td><td>정준석</td><td>sysdate</td><td>1</td> -->
<!-- 				</tr> -->
			</tbody>
		</table>
		<hr>
	</div>
	<%
		if(memInfo.getMem_account().equals("관리자")){
	%>
			<div class="writeBox">
				<button type="button" class="btn btn-primary btn-md writeBtn" id="writeBtn">글쓰기</button>			
			</div>
	<%
		}
	%>
	<div>
		<ul class="pagination justify-content-center pagination">
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
			
<!-- 			<li class="page-item"> -->
<!-- 			<a class="page-link" href="javascript:void(0);">2</a></li> -->
			
		</ul>
	</div>
</div>

<!-- Swiper JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
<script>
<!-- Initialize Swiper -->
var swiper = new Swiper(".mySwiper", {
	slidesPerView: 1,
	loop: true,
	autoplay: {
		delay: 3000,
		disableOnInteraction: false,
	},
	loopFillGroupWithBlank: true,
	pagination: {
		el: ".swiper-pagination",
		clickable: true,
	},
	navigation: {
		nextEl: ".swiper-button-next",
		prevEl: ".swiper-button-prev",
	},
});

</script>

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