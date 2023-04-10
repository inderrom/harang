<%@page import="com.harang.vo.MemberVO"%>
<%@page import="com.harang.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>자유게시판 글쓰기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap 적용 -->
	<link rel="stylesheet"href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
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

<!-- 게시판 -->
<!-- <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script> -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

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
	var boardType;

	$(function(){
		
		boardType = "<%= request.getParameter("board_type") %>";
		
		<%
			BoardVO boardVo = (BoardVO) request.getAttribute("boardVo");
		
			// 서블릿으로부터 받은 게시판 정보가 있을 경우 게시글 수정
			// 수정일 경우 제목 / 내용란에 기존 게시글 내용을 삽입한다.
			if(boardVo != null){
		%>
				$('#board_title').val("<%= boardVo.getBoard_title() %>");
				$('#summernote').summernote('code', '<%= boardVo.getBoard_content() %>');
		<%	
			}
		%>
		
		$('#mainMenuList li').on('mouseenter', function(){
			$('#subMenuList').slideDown();
		});
		$('#subMenuList').on('mouseleave', function(){
			$('#subMenuList').slideUp();
		});

		// 써머노트 초기화
		$('#summernote').summernote({
			placeholder: '이곳에 내용을 입력해 주세요.',
			tabsize: 2,
			height: 700,
			width: 1050,
			lang: 'ko-KR', // default: 'en-US'
			toolbar: [
			   ['style', ['style']],
			   ['font', ['bold', 'underline', 'clear']],
			   ['color', ['color']],
			   ['para', ['ul', 'ol', 'paragraph']],
			   ['table', ['table']],
			   ['insert', ['link', 'picture', 'video']],
			   ['view', ['fullscreen', 'codeview', 'help']]
			]
		});
		
		// 이전 버튼
		$('#prevBtn').on('click', function(){
			location.href="<%= request.getContextPath() %>/board.do?job=list&board_type=" + boardType;
		});
		
	})
	
	// submit이 실행될 때 써머노트에 작성한 내용이 그 위에 숨겨진 textarea로 보내진다.
	// 해당 textarea가 서블릿으로 보내진다.
	function postForm(){
		
		<%
			if(boardVo != null){
				
		%>
				$('input[name=job]').val('update');
		<%
			} else {
		%>
				$('input[name=job]').val('insert');
		<%
			}
		%>
		$('input[name=board_type]').val(boardType);
		$('#board_content').val($('#summernote').summernote('code'));
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
		
		// 게시글 폼에서 등록 버튼 클릭 시
		$('#insertBtn').on('click', function(){
			var title = $('#board_title').val();
			title = title.trim();
			
			if(title.length == 0){
				alert("제목을 입력해주세요.");
				return false;
			}
			
			postForm();
			$('#insertForm').submit();
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
	background : linear-gradient(rgba( 29, 233, 182, 0.65 ), white);
	
}
.container-fluid{
	width : 1250px;
	padding-top : 75px;
	background-color : white;
	padding : 100px;
}
/* ------------------------------------------- */
.wrap {
	width: 100%;
	margin: 10px auto;
	position: relative;
}

.cropping {
	margin-top: -10px;
	height: 400px;
	overflow: hidden;
}


.cropping img {
	max-height: initial;
	margin-top: -20%;
	filter: brightness(60%);
	transform: translate(0px, 320px);
	z-index: 2;
}
.freeboard{
	box-align : center;
}

h3, h5{
	font-family: 'Noto Sans KR', sans-serif;
}
.writeBtn, .backBtn{
	font-family: 'Noto Sans KR', sans-serif;
	margin : 5px;
	float: right;
	background-color: #1DE9B6; 
	border : 0px;
}
.writeBtn:hover, .backBtn:hover{
	background  : #FF7E47;
	color : white;
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
</style>
</head>
<body>
	<!-- header navbar -->
	<header>
		<nav class="navbar navbar-expand-sm bg-white navbar-white">
			<a class="navbar-brand" href="<%= request.getContextPath() %>/view/main/mainIndex.jsp" style="color: #1DE9B6;">
			<img src="<%= request.getContextPath() %>/images/layout/Union.png" id="icon"> Harang</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#collapsibleNavbar">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="mainMenu">
				<ul class="nav justify-content-center" id="mainMenuList">
					<li class="nav-item">
						<div class="nav-link" id="navBtn1">예매</div>
					</li>
					<li class="nav-item">
						<div class="nav-link" id="navBtn2">안내</div>
					</li>
					<li class="nav-item">
						<div class="nav-link" id="navBtn3">커뮤니티</div>
					</li>
					<li class="nav-item">
						<div class="nav-link" id="navBtn4">고객센터</div>
					</li>
				</ul>
			</div>
		<%
			MemberVO memberInfo = (MemberVO)session.getAttribute("memInfo");
			if(memberInfo != null && memberInfo.getMem_name() != null){
		%>
			<!-- 로그인 되었을때 -->
			<div class="col-md-3 row profile">
			<button type="button" id="logout" ><img src="<%= request.getContextPath() %>/images/layout/logout.png"></button>
			<button class="profile" type="button" id="profile" ><img src="<%= request.getContextPath() %>/images/layout/profile.png"></button>
			<h5><%=memberInfo.getMem_name() %>님 환영합니다.</h5>
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
		<form action="<%= request.getContextPath() %>/board.do" method="post" id="insertForm">
			<div>
				<div>
			<%	
				String boardType = request.getParameter("board_type");		//  보드의 값 받아오기 
				if(boardType.equals("freeboard")){
			%>
					<h3>자유 게시판 글 쓰기</h3>
			<%
				}
			%>
			<%
				if(boardType.equals("reviewboard")){	
			%>
					<h3>여행후기 글 쓰기</h3>
			<%
				} 
			%>
			<%
				if(boardType.equals("guideboard")){	
			%>
					<h3>여행가이드 글 쓰기</h3>
			<%
				} 
			%>	
			<%
				if(boardType.equals("noticeboard")){	
			%>
					<h3>공지사항 글 쓰기</h3>
			<%
				} 
			%>	
			<%
				if(boardType.equals("quesboard")){	
			
			%>
					<h3>문의게시글 글 쓰기</h3>
			<%
				} 
			%>
					<hr>
					<p>본 게시판은 모든 연령의 유저가 이용하는 게시판입니다.</p>
					<p>자유게시글을 올리기 전 운영원칙을 확인하여, 다른 유저님들에게 불편이 없도록 부탁 드립니다.</p>
					<p>웹상에서의 욕설신고는 1:1문의하기 > 신고문의를 통해 신고해주시기 바랍니다.</p>
					<p>(욕설/음란성 단어가 포함된 게시물은 삭제되며 신고를 위한 게시물도 이에 해당됩니다)</p>
					<hr>
				</div>
				
				<div class="freeboard">
					<h5>제목을 입력해주세요</h5>
					<br><input type="text" size="135" placeholder="제목을 입력해주세요" name="board_title" id="board_title">
					<br><br>
					<textarea id="board_content" name="board_content" style="display:none"></textarea>
					<div id="summernote"></div>
				<br>
				<br>
				<div>
				<%
					// 서블릿에서 받아온 게시판 정보가 있을 경우
					// -> 게시판 수정
					if(boardVo != null){
				%>
						<input type="hidden" name="board_id" value="<%= boardVo.getBoard_id() %>">
				<%
					}
				%>
					<!-- 테스트용. 이후 삭제할 것 -->
					<input type="hidden" name="mem_id" value="<%=memInfo.getMem_id() %>">
					<input type="hidden" name="mem_nick" value="<%=memInfo.getMem_nick() %>">
					<!-- 테스트용. 이후 삭제할 것 -->
					
					
					<!-- 게시판 종류 -->
					<input type="hidden" name="job">
					<input type="hidden" name="board_type">
					
					<input type="button" class="btn btn-primary btn-lg backBtn" value="이전으로" id="prevBtn">
					<input type="button" class="btn btn-primary btn-lg writeBtn" value="등록" id="insertBtn">
				</div>
				</div>
			</div>
		</form>
	</div>
</section>

	<!-- footer section -->
	<div style="margin-bottom: 0">
		<footer>
			<hr />
			<div id="footerDiv">
				<p>전 세계 저가 항공권을 비교하고 예약하세요</p>
				<p>ⓒ HARANG Ltd. 2022-</p>
			</div>
		</footer>
	</div>
</body>
</html>


