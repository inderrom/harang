<%@page import="java.util.ArrayList"%>
<%@page import="com.harang.vo.CommentVO"%>
<%@page import="java.util.List"%>
<%@page import="com.harang.vo.BoardVO"%>
<%@page import="com.harang.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세보기</title>
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
 
 
<%-- <script src="<%= request.getContextPath() %>/js/jquery-3.6.1.min.js"></script> --%>
<script src="<%= request.getContextPath() %>/js/jquery.serializejson.js"></script>
 
 <script>
 
<%
	MemberVO memInfo = (MemberVO) session.getAttribute("memInfo");
	if(memInfo == null){
%>
		alert("로그인이 필요합니다.");
		location.href="<%= request.getContextPath() %>/view/login/login.jsp";
<%
	}
	
	// 게시물 정보
	BoardVO boardVo = (BoardVO) request.getAttribute("boardVo");
	
	List<CommentVO> commtList = new ArrayList<>();
	List<?> tempCommtList = (List<?>) request.getAttribute("commtList");
	
	if(tempCommtList != null){
		for(Object obj : tempCommtList){
			if(obj instanceof CommentVO){
				commtList.add((CommentVO) obj);
			}
		}
	}
	
	boolean isAdmin = false; // 관리자 여부
	boolean boardUpdateAuth = false; // 게시글 수정 권한
	boolean boardDeleteAuth = false; // 게시글 삭제 권한
	
	if(memInfo != null){
		
		if(memInfo.getMem_account().equals("관리자")) isAdmin = true;
		
		// 작성자 본인만 게시글 수정이 가능하다.
		if(memInfo.getMem_id().equals(boardVo.getMem_id())) boardUpdateAuth = true;
		
		// 작성자 본인과 관리자만 게시글 삭제가 가능하다.
		if(memInfo.getMem_id().equals(boardVo.getMem_id()) || isAdmin) boardDeleteAuth = true;
	}
%>
 
 
 
	$(function(){
		// 서브메뉴 내려갔다 올라왔다
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
		
	})
	
	var boardId;
	var boardType;
	var commtType;

	$(function(){
		
		boardId = "<%= request.getParameter("board_id") %>";
		boardType = "<%= request.getParameter("board_type") %>";
		
		
		commtType = boardType.substring(0, boardType.indexOf("board")) + "commt";
		
		$('input[name=board_id]').val(boardId);
		$('input[name=commt_type]').val(commtType);
		
		// 게시글 삭제 버튼
		$('#deleteBtn').on('click', function(){
		<%
			if(boardDeleteAuth){
		%>
				var check = confirm("게시글을 삭제할까요?")
				if(check){
					alert("게시글을 삭제했어요.");
					location.href = "<%= request.getContextPath() %>/board.do?job=delete&board_type=" + boardType + "&board_id=<%= boardVo.getBoard_id()%>";
				}
		<%
			} else {
		%>
				alert("작성자 본인만 삭제할 수 있어요.");
		<%
			}
		%>
			
		});
		// 게시글 수정 버튼
		$('#updateBtn').on('click', function(){
		<% 
			if(boardUpdateAuth){
		%>
				location.href = "<%= request.getContextPath() %>/board.do?job=form&board_type=" + boardType + "&board_id=<%= boardVo.getBoard_id() %>";
		<%
			} else {
		%>
				alert("작성자 본인만 수정할 수 있어요.");
		<%
			}
		%>
		});
		
		// 댓글 등록 버튼
		$('#commtBtn').on('click', function(){
			var commentContent = $(this).parent().find('textarea').val();
			
			if(commentContent.trim().length == 0){
				alert("내용을 입력해주세요.");
				return false;
			}
			
			$(this).parent().find('input[name=job]').val('insert');
			var jsonData = $(this).parent().serializeJSON();
			
			$.ajax({
				url : '<%= request.getContextPath() %>/comment.do',
				data : jsonData,
				type : 'post',
				success : function(res){
					
					if(res == "SUCCESS"){
						location.reload();
					} else{
						alert("잠시 후 다시 시도해주세요.");
					}
				},
				error : function(err){
					alert(err.status + " : " + err.statusText);
				},
				dataType : 'json'
			});
		});
		
		// 댓글 삭제 버튼
		$('.deleteCommtBtn').on('click', function(){
			
			var deleteCheck = confirm("댓글을 삭제할까요?");
			
			if(!deleteCheck) return false;
			var targetId = $(this).parents('.ml').attr('id');
			$.ajax({
				url : '<%= request.getContextPath() %>/comment.do',
				data : {
					"job" : "delete",
					"board_id" : boardId,
					"commt_id" : targetId,
					"commt_type" : commtType
				},
				type : 'post',
				success : function(res){
					if(res == "SUCCESS"){
						alert("댓글이 삭제되었어요.");
						location.reload();
					} else{
						alert("잠시 후 다시 시도해주세요.");
					}
				},
				error : function(err){
					alert(err.status + " : " + err.statusText);
				},
				dataType : 'json'
			});
			
			
		});
		
		// 댓글에서 답글 버튼 클릭 시
		$(document).on('click', '.replyTocommtBtn', function(){
			var replyForm = $('#targetCommtBox');
			var targetComment = $(this).parent();
			
			// 댓글 작성 폼을 해당 댓글의 아래로 이동
			$(targetComment).append($(replyForm));
			$('textarea', $(replyForm)).val(''); // 폼의 내용은 미리 비운다.
			
			$(replyForm).show();
			
			// 폼 타입을 insert로 변경
			$('input[name=job]', replyForm).val('insert');
		});
		
		// 댓글 작성 폼에서 작성 버튼 클릭 시
		$('#replyCommtBtn').on('click', function(){
			var content = $(this).parent().find('textarea').val();
			content = content.trim();
			
			// 작성된 내용이 없을 경우
			if(content.length == 0){
				alert("내용을 입력해주세요.");
				return false;
			}
			
			// 댓글의 대상이 되는 댓글
			var targetComment = $(this).parents('.ml');
			
			// 대상의 댓글 번호 가져오기
			var targetId = $(targetComment).attr('id');
			$('input[name=target_id]', '#replyCommtForm').val(targetId);
			
			var jsonData = $('#replyCommtForm').serializeJSON();
			
			$.ajax({
				url : '<%= request.getContextPath() %>/comment.do',
				data : jsonData,
				type : 'post',
				success : function(res){
					if(res == "SUCCESS"){
						location.reload();
					} else{
						alert("잠시 후 다시 시도해주세요.");
					}
				},
				error : function(err){
					alert(err.status + " : " + err.statusText);
				},
				dataType : 'json'
			});
		});
		
		// 댓글 작성폼에서 취소를 눌렀을 경우
		$('#replyCancelBtn').on('click', function(){
			var replyForm = $('#targetCommtBox');
			var targetComment = $(this).parents('.comment');
			
			// 수정폼 위치 초기화
			$('body').append($(replyForm));
			$('textarea', replyForm).val('');
			$(this).parent().find('input[name=commt_id]').val('');
			$('input[name=job]', replyForm).val('');
			$(replyForm).hide();
			
			// 댓글 위치에 숨긴 원본 댓글 보이기
			$('span', targetComment).show();
		});
		
		// 댓글에서 수정 버튼을 눌렀을 경우
		$(document).on('click', '.updateCommtBtn', function(){
			var replyForm = $('#targetCommtBox');
			var targetComment = $(this).parent().find('.comment');
			
			// 댓글란에서 내용을 가져오고 댓글란은 숨긴다.
			var comment = $(targetComment).text().trim();
			$('span', targetComment).hide();
			
			// 수정폼을 댓글 위치로 가져오고 기존 내용을 삽입한다.
			$(targetComment).append(replyForm);
			$('textarea', replyForm).val(comment);
			
			$(replyForm).show();
			
			// 수정하려는 댓글의 번호를 가져오고 폼 타입을 update로 변경
			var commt_id = $(this).parents('.ml').attr('id');
			$('input[name=commt_id]', replyForm).val(commt_id);
			$('input[name=job]', replyForm).val('update');
		});
		
		// ---------------------------------------
		
		// modal창 쿼리 입니다. 건들지마세요
		$('.reportBtn').on('click',function(){
			$("#myModal").modal();
		});
		$('.reportTocommtBtn').on('click',function(){
			$("#myModal").modal();
		});
		//(modal창 쿼리 끝...)
		
		// ---------------------------------------
		
		// 게시물에서 신고버튼을 눌렀을 때
		// 신고폼에 신고 대상의 닉네임과 아이디가 담긴다.
		$('#reportBtn').on('click', function(){
			var targetId = $('#writerId').val();
			var targetNick = $('#writerNick').text();
			targetNick = targetNick.trim();
			
			$('#targetId').val(targetId);
			$('#targetNick').text(targetNick);
		});
		
		// 신고폼에서 신고 버튼 클릭 시
		$('#reportSub').on('click', function(){
			
			var reportData = $('#reportForm').serializeJSON();
			
			$.ajax({
				url : '<%=request.getContextPath() %>/report.do',
				data : reportData,
				type : 'post',
				success : function(res){
					
					if(res == "SUCCESS"){
						alert('신고가 등록되었어요.');
						location.reload();
					} else{
						alert('잠시 후 다시 시도해주세요.');
					}
				},
				error : function(err){
					alert(err.status + " : " + err.statusText);
				},
				dataType : 'json'
			});
		});
		
		// 댓글에서 신고 버튼을 눌렀을 때
		// 신고폼에 신고 대상의 닉네임과 아이디가 담긴다.
		$(document).on('click','#repBtnTocommt', function(){
			var targetNick = $(this).parent().find('#commtToWriterNick').text();
			var targetId = $(this).parent().find('#commtToWriterId').val();
			targetNick = targetNick.trim();
			targetId = targetId.trim();
			
			$('#targetNick').text(targetNick);
			$('#targetId').val(targetId);
		});
		
// 		$('#reportSub').on('click', function(){
			
// 			var reportData = $('#reportForm').serializeJSON();
			
// 			$.ajax({
<%-- 				url : '<%=request.getContextPath() %>/report.do', --%>
// 				data : reportData,
// 				type : 'post',
// 				success : function(res){
					
// 					if(res == "SUCCESS"){
// 						alert('신고 처리되었습니다.');
// 						location.reload();
// 					} else{
// 						alert('잠시 후 다시 시도해주세요.');
// 					}
// 				},
// 				error : function(err){
// 					alert(err.status + " : " + err.statusText);
// 				},
// 				dataType : 'json'
// 			});
			
// 		});
	})
	
</script>
<style>
/* 기본값 style */
@import url('https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Gowun+Batang&family=Lobster&display=swap');

body{
	min-width : 1600px;
	height : 100%;
	background : linear-gradient(rgba( 29, 233, 182, 0.65 ), white);
}
#mainMenu{
		user-select : none;
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

/* ------------------------------------------------------------------- */
.fbtitle, .dt{
	color : #969696;
	/*font-family: 'Gowun Batang', serif;*/
	font-family: 'Noto Sans KR', sans-serif;
}

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

h2{
	font-family: 'Noto Sans KR', sans-serif;
}
.txt_bar{
	color : #969696;
	opacity: 0.8;
}

a:hover{
	color : #969696;
}

P, i{
	font-size: 17px;
	opacity: 0.8; 
}
.Btn1{
	float: right;
	background-color : #1DE9B6;
	border :0px;
	font-family: 'Noto Sans KR', sans-serif;
}
.Btn2, .reportBtn{
	background-color : #1DE9B6;
	border :0px;
	font-family: 'Noto Sans KR', sans-serif;
}

.Btn1:hover, .Btn2:hover, .modaling
.moziri{
	border : 0px;
	margin : -1px;
}

.comments{
	font-size : 14pt;
	font-family: 'Noto Sans KR', sans-serif;
}
.updateCommtBtn, .updateBtn, .reportCommtBtn, .reportTocommtBtn, .deleteCommtBtn, .deleteBtn, .replyTocommtBtn, .replyBtn, .cancelBtn{
	background-color : #1DE9B6;
	border : none;
	border-radius : 5px;

	font-size : 12pt;
	width : 50px;
	height : 30px;

	font-family: 'Noto Sans KR', sans-serif;
	color : white;
	
	margin-right : 5px;
	margin-bottom :10px;
	cursor : pointer;
}

.ml{
	font-family: 'Noto Sans KR', sans-serif;
}
.card-header{
	background-color : #0C654F;
	color : white;
}
.card-body{
	font-family: 'Noto Sans KR', sans-serif;
	color : #1C1C1C;
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
.comment{
	margin : 10px 0px 10px 20px;
}
.dateText{
	font-size: 12px;
}

.commentBox{
	padding: 30px;
	font-family: 'Noto Sans KR', sans-serif;
}
.modal-title{
	font-size : 20pt; 
	font-family: 'Noto Sans KR', sans-serif;
}
.reportModalText2{
	font-size : 14pt; 
	font-family: 'Noto Sans KR', sans-serif;
	margin-top : 20px;
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
	</nav>
<!-- subnavbar ==> header 이미지 위로 올라와야하므로 header section에 위치 -->
		<nav>
			<div id="imageSec" >
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
	<div class="wrap">
		<div class="cropping">
			<img src="<%=request.getContextPath() %>/images/layout/main02.png">
		</div>
		
	</div>
</header>
<!-- main section -->
<section>

<div class="container-fluid">
	<div>
		<h2><%= boardVo.getBoard_title() %></h2>
		<br>
		<p>
		<%
			if(isAdmin){
		%>
				<a href="<%= request.getContextPath() %>/admin.do?job=memInfo&memId=<%= boardVo.getMem_id() %>"><span class="fbtitle" id="writerNick"><%= boardVo.getMem_nick() %></span></a>
		<%
			} else {
		%>
				<span class="fbtitle" id="writerNick"><%= boardVo.getMem_nick() %></span>
		<%
			}
		%>
			<input type="hidden" id="writerId" value="<%= boardVo.getMem_id()%>">
			<span class="txt_bar">｜</span>
			<span class="fbtitle"><%= boardVo.getBoard_date()%></span>
			<span class="txt_bar">｜</span>
			<span class="fbtitle"><%= boardVo.getBoard_hit() %></span>
			<span class="txt_bar">｜</span>
		
		<%
			if(boardUpdateAuth){
		%>
			<span class="fbtitle" ><input class="updateBtn" type="button" value="수정" id="updateBtn"> </span>
			<span class="txt_bar">｜</span>
		<%
			}
		
			if(boardDeleteAuth){
		%>
			<span class="fbtitle"><input class="deleteBtn" type="button" value="삭제" id="deleteBtn"></span>
		<%
			}
		%>
		</p>
		<hr>
	</div>
	<div>
		<p><%= boardVo.getBoard_content() %></p>
	
	</div>
	<hr>
	
	<%
		// 게시판 종류 받아오기
		String boardType = request.getParameter("board_type");
		
		// 공지사항이나 여행 가이드가 아닌 곳에만 댓글이 있다.
		if(!boardType.equals("noticeboard") && !boardType.equals("guideboard")){
	%>
	
		<!-- 댓글 작성 영역 -->
		<div id="commtBox">
		<%
				// 문의 게시판이 아니라면 일반회원만 댓글 작성
				// 문의 게시판에서는 관리자만 댓글 작성
				if((!boardType.equals("quesboard") && !isAdmin) || (boardType.equals("quesboard") && isAdmin)){
		%>
					<div class="comment">
						<b><span class="comments">Comments</span></b>
					</div>
					
					<form id="commtForm">
						<textarea class="form-control" id="commtContent" name="commt_content"></textarea>
						
						<button type="button" class="btn btn-dark mt-3 Btn2" onclick="history.back(); return false;">목록으로</button>
						<%
							// 관리자는 댓글을 신고할 수 없다.
							if(!isAdmin){
						%>
						<button type="button" class="btn btn-dark mt-3 reportBtn" id="reportBtn" data-toggle="modal" data-target="#myModal">신고</button>
						<%
							}
						%>
						
						<button type="button" class="btn btn-dark mt-3 Btn1" id="commtBtn">등록</button>
						<hr>
						
						<input type="hidden" name="job">
						<input type="hidden" name="board_id">
					
						<input type="hidden" value="<%= memInfo.getMem_id() %>" name="mem_id">
						<input type="hidden" value="<%= memInfo.getMem_nick() %>" name="mem_nick">
				
						<!-- 게시판 종류 -->
						<input type="hidden" name="commt_type">
					</form>
		<%
				} else {
		%>		
					<button type="button" class="btn btn-dark mt-3 Btn2" onclick="history.back(); return false;">목록으로</button>
					<hr>
		<%		
				}
		%>	
		</div>
		<!-- 댓글 작성 영역 끝 -->
		
		<!-- 댓글 출력 영역 -->
		<div id="commentList">
		<%
			for(int i = 0; i < commtList.size(); i++){
				CommentVO commtVo = commtList.get(i);
				
				// 댓글 내용이 없을 경우 (삭제된 댓글인 경우)
				if(commtVo.getCommt_content() == null){
		%>
					<div class="commentBox" style="margin-left : <%= 64 * commtVo.getDepth() %>px; border : 1px solid gray; border-radius : 5px;">
						
						삭제된 댓글이에요.
					</div>
			<%
				} else {
					String comment = commtVo.getCommt_content();
					comment = comment.replaceAll("\r", "").replaceAll("\n", "<br>");
					int depth = commtVo.getDepth();
					
					boolean commtUpdateAuth = false;
					boolean commtDeleteAuth = false;
					
					// 댓글 수정은 작성자 회원 본인만 가능하다.
					if(memInfo.getMem_id().equals(commtVo.getMem_id())) commtUpdateAuth = true;
					
					// 댓글 삭제는 작성자 본인과 관리자만 가능하다.
					if(memInfo.getMem_id().equals(commtVo.getMem_id()) || isAdmin) commtDeleteAuth = true;
					
			%>
			
					<div id="<%= commtVo.getCommt_id() %>" class="ml" style="margin-left : <%= 64 * commtVo.getDepth() %>px">
						<div style="border : 1px solid gray; border-radius : 5px;">
						<p class="card-header p-2">
						<%
							if(isAdmin){
						%>
								작성자 : <a href="<%= request.getContextPath() %>/admin.do?job=memInfo&memId=<%= commtVo.getMem_id() %>" style="color : white;"><span id="commtToWriterNick"><%= commtVo.getMem_nick() %></span></a>
						<%
							} else {
						%>
								작성자 : <span id="commtToWriterNick"><%= commtVo.getMem_nick() %></span>
						<%
							}
						%>
							<input type="hidden" id="commtToWriterId" class="memId" value="<%= commtVo.getMem_id() %>"><br>
							<span class="dateText">작성일자 : <%= commtVo.getCommt_date() %></span>
						</p>
							<div class="comment">
								<span><%= comment %></span>
							</div>
		
						<div style="display : inline-block; width : 14px;"></div>
					<%	
						// 문의 게시판이 아니면서 관리자가 아닌 경우
						// 문의 게시판에서는 댓글에 답글을 작성할 수 없다.
						// 관리자는 댓글이나 답글을 작성할 수 없다.
						if(!boardType.equals("quesboard") && !isAdmin){ 
					%>
						<input type="button" value="답글" class="replyTocommtBtn">
						<input type="button" value="신고" class="reportTocommtBtn" id="repBtnTocommt" data-toggle="modal" data-target="#myModal">
							
					<%
						}
					
						if(commtUpdateAuth){
					%>
							<input type="button" value="수정" class="updateCommtBtn">
					<%
						}
					
						if(commtDeleteAuth){
					%>
						<input type="button" value="삭제" class="deleteCommtBtn">
					<%
						}
					%>
					</div>
				</div>
<%
			}
		}
		
		
	} else {
%>
		<button type="button" class="btn btn-dark mt-3 Btn2" onclick="history.back(); return false;">목록으로</button>
<%
	}
%>
	</div>
	<!-- 댓글 출력 영역 끝 -->
	
	<!-- 댓글 폼 -->
	<div id="targetCommtBox" style="display : none">
		<form id="replyCommtForm">
			<textarea name="commt_content"></textarea>
			<input type="button" value="등록" id="replyCommtBtn" class="replyBtn">
			<input type="button" value="취소" id="replyCancelBtn" class="cancelBtn">
			<input type="hidden" name="commt_id">
			<input type="hidden" name="job">
			<input type="hidden" name="board_id">
			
			<input type="hidden" value="<%=memInfo.getMem_id() %>" name="mem_id">
			<input type="hidden" value="<%=memInfo.getMem_nick() %>" name="mem_nick">
			<input type="hidden" name="target_id">
			<!-- 게시판 종류 -->
			<input type="hidden" name="commt_type">
		</form>
	</div>
	<div style="margin : 100px;">
</div>

<!-- The Modal -->
  <div class="modal fade modalForm" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
			<div class="modal-title">신고하기</div>
         	<button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        <form action="<%=request.getContextPath() %>/report.do" method="post" id="reportForm">	
         	<hr/>
         	<div class="reportModalText2">신고 대상 : <span id="targetNick"></span></div>
         	<input type="hidden" id="targetId" name="mem_id">
         	<hr/>
         	<div class="reportModalText2">신고 사유</div>
         	<select class="form-control" id="repType" name="rep_type">
				<option selected>스팸/홍보/도배글이에요.</option>
				<option>음란물이에요.</option>
				<option>불법정보를 포함하고 있어요.</option>
				<option>청소년에게 유해한 내용이에요.</option>
				<option>욕설/혐오/생명경시/차별적 표현이에요.</option>
				<option>개인정보 노출 게시글이에요.</option>
				<option>불쾌한 표현이 있어요.</option>
				<option>명예훼손/저작권이 침해되었어요.</option>
				<option>그 외</option>
			</select>
			<div class="reportModalText2">신고 내용을 자세히 적어주세요
			<textarea class="form-control" id="repContent" rows="5" name="rep_content"></textarea>
			<input type="hidden" name="job" value="report">
			</div>
		</form>
        </div>
	        <!-- Modal footer -->
    	    <div class="modal-footer">
    	      <button type="button" class="btn btn-danger" data-dismiss="modal" id="reportSub">신고</button>
    	      <button type="button" class="btn btn-primary" data-dismiss="modal" style="background-color : #1DE9B6; border : none;">취소</button>
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