<%@page import="com.harang.vo.TicketVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.harang.vo.CommentVO"%>
<%@page import="com.harang.vo.BoardVO"%>
<%@page import="com.harang.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>관리자 페이지</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/bootstrap.min.css">
<!-- DataTables -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/dataTables.bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/font-awesome/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/_all-skins.min.css">
<!-- Google Font -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">

 <!-- modal -->
<!-- <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script> -->
<script src="<%= request.getContextPath() %>/js/jquery-3.6.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>

<script src="<%= request.getContextPath() %>/js/jquery.serializejson.js"></script>

<script>
<%
	// 회원 정보
	MemberVO memInfo = (MemberVO) session.getAttribute("memInfo");
	if(memInfo == null){
%>
		alert("로그인이 필요합니다.");
		location.href="<%= request.getContextPath() %>/view/login/login.jsp";
<%
	} else if (!memInfo.getMem_account().equals("관리자")){
%>
		alert("잘못된 접근입니다.");
		location.href="<%= request.getContextPath() %>/view/main/mainIndex.jsp";
<%
	}
	
	// 예매 목록
	List<TicketVO> ticketList = new ArrayList<>();
	List<?> tempTicketList = (List<?>) request.getAttribute("ticketList");
	for(Object obj : tempTicketList){
		if(obj instanceof TicketVO){
			ticketList.add((TicketVO) obj);
		}
	}

	// 자유게시판 게시물 목록
	List<BoardVO> freeList = new ArrayList<>();
	List<?> tempFreeList = (List<?>) request.getAttribute("freeList");
	for(Object obj : tempFreeList){
		if(obj instanceof BoardVO){
			freeList.add((BoardVO) obj);
		}
	}
	
	// 여행후기 게시판 게시물 목록
	List<BoardVO> reviewList = new ArrayList<>();
	List<?> tempReviewList = (List<?>) request.getAttribute("reviewList");
	for(Object obj : tempReviewList){
		if(obj instanceof BoardVO){
			reviewList.add((BoardVO) obj);
		}
	}
	
	// 문의 게시판 게시물 목록
	List<BoardVO> quesList = new ArrayList<>();
	List<?> tempQuesList = (List<?>) request.getAttribute("quesList");
	for(Object obj : tempQuesList){
		if(obj instanceof BoardVO){
			quesList.add((BoardVO) obj);
		}
	}
	
	// ------------------------------------------------------------------------
	
	// 자유 게시판 댓글 목록
	List<CommentVO> freeCommentList = new ArrayList<>();
	List<?> tempFreeCommtList = (List<?>) request.getAttribute("freeCommentList");
	for(Object obj : tempFreeCommtList){
		if(obj instanceof CommentVO){
			freeCommentList.add((CommentVO) obj);
		}
	}
	
	// 여행 후기 게시판 댓글 목록
	List<CommentVO> reviewCommentList = new ArrayList<>();
	List<?> tempReviewCommtList = (List<?>) request.getAttribute("reviewCommentList");
	for(Object obj : tempReviewCommtList){
		if(obj instanceof CommentVO){
			reviewCommentList.add((CommentVO) obj);
		}
	}
%>

</script>
</head>

<style>
#btnAdd {
	float: right;
}
.box-body{
	max-height : 400px;
	overflow : auto;
}
.board,.comment{
	cursor : pointer;
}
.board:hover,.comment:hover{
	text-decoration : underline;
}
#mainBtn {
	color : black;
	background : #1DE9B6;
	border-radius: 15px;
}
</style>


<body class="hold-transition skin-green sidebar-mini">
	<div class="wrapper">

		<header class="main-header">
			<!-- Logo -->
<!-- 			<a href="adminIndex.jsp" class="logo"> -->
			<a href="<%= request.getContextPath() %>/view/admin/adminIndex.jsp" class="logo">
			 <!-- logo for regular state and mobile devices -->
				<span class="logo-lg"><b>관리자 계정</b></span>
			</a>
			<!-- Header Navbar: style can be found in header.less -->
			<nav class="navbar navbar-static-top">
				<!-- Sidebar toggle button-->
				<a href="#" class="sidebar-toggle" data-toggle="push-menu"
					role="button"> <span class="sr-only">Toggle navigation</span>
				</a>
			</nav>
		</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- Sidebar user panel -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="<%=request.getContextPath()%>/images/admin/user.png"
							class="img-circle" alt="user Image">
					</div>
					<div class="pull-left info">
						<p>관리자</p>
						<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
					<input id="mainBtn" type="button" value="메인화면" onclick="main()">
					</div>
				</div>

				<!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu" data-widget="tree">
					<li class="header">Menu</li>
					<li class="active treeview"><a href="#"> <i
							class="fa fa-dashboard"></i> <span>회원 관리</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li class="active"><a href="<%=request.getContextPath()%>/member.do?job=list"><i class="fa fa-circle-o"></i> 회원 정보 조회</a></li>
							<li><a href="<%=request.getContextPath()%>/report.do?job=list"><i class="fa fa-circle-o"></i> 신고 받은 회원 조회</a></li>
							<li><a href="<%=request.getContextPath()%>/blacklist.do?job=list"><i class="fa fa-circle-o"></i> 블랙리스트 조회</a></li>
						</ul></li>

					<li class="treeview"><a href="#"> <i
							class="fa fa-dashboard"></i> <span>게시물 관리</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li><a href="<%=request.getContextPath()%>/admin.do?job=allBoard&board_type=freeboard"><i class="fa fa-circle-o"></i>자유 게시판</a></li>
            				<li><a href="<%=request.getContextPath()%>/admin.do?job=allBoard&board_type=quesboard"><i class="fa fa-circle-o"></i>문의 게시판</a></li>
							<li><a href="<%=request.getContextPath()%>/admin.do?job=allBoard&board_type=reviewboard"><i class="fa fa-circle-o"></i>후기 게시판</a></li>
						</ul></li>

					<li class="treeview"><a href="#"> <i
							class="fa fa-dashboard"></i> <span>여행지 관리</span> <span
							class="pull-right-container"> <i
								class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
						<ul class="treeview-menu">
							<li><a href="<%= request.getContextPath() %>/tour.do?job=listAdmin"><i class="fa fa-circle-o"></i>
									여행지 조회</a></li>
						</ul></li>
				</ul>
			</section>
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					회원 관리 <small></small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="<%= request.getContextPath() %>/view/admin/adminIndex.jsp">
						<i class="fa fa-dashboard"></i> Home</a>
					</li>
					<li class="active">
					<a href="<%= request.getContextPath()%>/member.do?job=list">회원 목록</a>
					</li>
					<li class="active">회원 상세보기</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-xs-12">

						<div class="box">
							<div class="box-header">
								<%
									MemberVO memVo = (MemberVO) request.getAttribute("memVo");
								%>
								<h3 class="box-title memHeader"><%=memVo.getMem_name() %>님 상세정보</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table id="example1" class="table table-bordered table-striped">
									<thead>
										<tr>
											<th style="width:15%;">회원 ID</th>
											<th style="width:10%;">이름</th>
											<th style="width:15%;">닉네임</th>
											<th style="width:10%;">생년월일</th>
											<th style="width:20%;">이메일</th>
											<th style="width:10%;">성별</th>
											<th style="width:15%;">연락처</th>
											<th style="width:5%;">상태</th>
										</tr>
									</thead>
									<tbody>
									<%
										String bir = memVo.getMem_bir().split(" ")[0];
									
										String gender = memVo.getMem_gender();
										if(gender == null) gender = "없음";
										
										String tel = memVo.getMem_tel();
										if(tel == null) tel = "없음";
										
										String status = memVo.getMem_status();
										switch(status){
										case "Y": status = "활동"; break;
										case "N": status = "탈퇴"; break;
										}
									%>
										<tr>
											<td class="tdId"><%=memVo.getMem_id()%></td>
											<td><%= memVo.getMem_name() %></td>
											<td><%= memVo.getMem_nick() %></td>
											<td><%= bir %></td>
											<td><%= memVo.getMem_mail() %></td>
											<td><%= gender %></td>
											<td><%= tel %></td>
											<td><%= status %></td>
										</tr>

									</tbody>
								</table>
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>
					<!-- /.col -->
				</div>

				<div class="row">
					<div class="col-xs-12">

						<div class="box">
							<div class="box-header">
								<h3 class="box-title">예매 목록</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table id="example1" class="table table-bordered table-striped">
									<thead>
										<tr>
											<th style="width:30%;">예매번호</th>
											<th style="width:25%;">항공편명</th>
											<th style="width:25%;">항공사명</th>
											<th style="width:20%;">출발일</th>

										</tr>
									</thead>
									<tbody>
										<%
											if (ticketList == null || ticketList.size() == 0) {
										%>

										<tr>
											<td colspan="4" style="text-align: center;">데이터가 존재하지 않습니다.</td>
										</tr>

										<%
											} else {
												for (TicketVO tvo : ticketList) {
													String date = tvo.getTicket_date().split(" ")[0];
										%>
													<tr id="<%= tvo.getTicket_id() %>" class="ticket">
														<td><%= tvo.getTicket_id() %></td>
														<td><%= tvo.getFli_id() %></td>
														<td><%= tvo.getAirline_name() %></td>
														<td><%= date %></td>
													</tr>

										<%
												}
											}
										%>
									</tbody>
								</table>
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>
					<!-- /.col -->
				</div>

				<div class="row">
					<div class="col-xs-12">

						<div class="box">
							<div class="box-header">
								<h3 class="box-title">자유게시판 게시글 목록</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table id="example1" class="table table-bordered table-striped">
									<thead>
										<tr>
											<th style="width:20%;">게시글 번호</th>
											<th style="width:60%;">글제목</th>
											<th style="width:20%;">작성일자</th>

										</tr>
									</thead>
									<tbody>
										<%
											if (freeList == null || freeList.size() == 0) {
										%>

										<tr>
											<td colspan="3" style="text-align: center;">데이터가 존재하지 않습니다.</td>
										</tr>

										<%
											} else {
												for (BoardVO bvo : freeList) {
										%>
										<tr id="<%= bvo.getBoard_id() %>" class="board freeboard">
											<td><%= bvo.getBoard_id() %></td>
											<td><%= bvo.getBoard_title() %></td>
											<td><%= bvo.getBoard_date() %></td>
										</tr>

										<%
												}
											}
										%>
									</tbody>
								</table>
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>
					<!-- /.col -->
				</div>

				<div class="row">
					<div class="col-xs-12">

						<div class="box">
							<div class="box-header">
								<h3 class="box-title">여행 후기게시글 목록</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table id="example1" class="table table-bordered table-striped">
									<thead>
										<tr>
											<th style="width:20%;">게시글 번호</th>
											<th style="width:60%;">글제목</th>
											<th style="width:20%;">작성일자</th>
										</tr>
									</thead>
									<tbody>
									
								<%
									if (reviewList == null || reviewList.size() == 0) {
								%>

										<tr>
											<td colspan="3" style="text-align: center;">데이터가 존재하지 않습니다.</td>
										</tr>

								<%
									} else {
										for (BoardVO bvo : reviewList) {
								%>

										<tr id="<%= bvo.getBoard_id() %>" class="board reviewboard">
											<td><%= bvo.getBoard_id() %></td>
											<td><%= bvo.getBoard_title() %></td>
											<td><%= bvo.getBoard_date() %></td>
										</tr>
										
								<%
										}
									}
								%>			
									</tbody>
								</table>
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>
					<!-- /.col -->
				</div>

				<div class="row">
					<div class="col-xs-12">

						<div class="box">
							<div class="box-header">
								<h3 class="box-title">문의게시판 게시글 목록</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table id="example1" class="table table-bordered table-striped">
									<thead>
										<tr>
											<th style="width:20%;">게시글 번호</th>
											<th style="width:60%;">글제목</th>
											<th style="width:20%;">작성일자</th>

										</tr>
									</thead>
									<tbody>
									
								<%
									if (quesList == null || quesList.size() == 0) {
								%>

										<tr>
											<td colspan="3" style="text-align: center;">데이터가 존재하지 않습니다.</td>
										</tr>

								<%
									} else {
										for (BoardVO bvo : quesList) {
								%>

										<tr id="<%= bvo.getBoard_id() %>" class="board quesboard">
											<td><%= bvo.getBoard_id() %></td>
											<td><%= bvo.getBoard_title() %></td>
											<td><%= bvo.getBoard_date() %></td>
										</tr>
										
								<%
										}
									}
								%>			
									</tbody>
								</table>
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>
					<!-- /.col -->
				</div>

				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-header">
								<h3 class="box-title">자유게시판 댓글 목록</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table id="example1" class="table table-bordered table-striped">
									<thead>
										<tr>
											<th style="width:20%;">댓글번호</th>
											<th style="width:60%;">댓글내용</th>
											<th style="width:20%;">작성시간</th>
										</tr>
									</thead>
									<tbody>
								<%
									if (freeCommentList == null || freeCommentList.size() == 0) {
								%>

										<tr>
											<td colspan="3" style="text-align: center;">데이터가 존재하지 않습니다.</td>
										</tr>

								<%
									} else {
										for (CommentVO cvo : freeCommentList) {
											String content = cvo.getCommt_content();
											if(content == null) content = "삭제된 댓글입니다.";
								%>

										<tr id="<%= cvo.getBoard_id() %>" class="comment freeboard">
											<td><%= cvo.getCommt_id() %></td>
											<td><%= content %></td>
											<td><%= cvo.getCommt_date() %></td>
										</tr>
										
								<%
										}
									}
								
								%>		
									</tbody>
								</table>
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>
					<!-- /.col -->
				</div>


				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-header">
								<h3 class="box-title">여행 후기게시판 댓글 목록</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table id="example1" class="table table-bordered table-striped">
									<thead>
										<tr>
											<th style="width:20%;">댓글번호</th>
											<th style="width:60%;">댓글내용</th>
											<th style="width:20%;">작성시간</th>
										</tr>
									</thead>
									<tbody>
								<%
									if (reviewCommentList == null || reviewCommentList.size() == 0) {
								%>

										<tr>
											<td colspan="3" style="text-align: center;">데이터가 존재하지 않습니다.</td>
										</tr>

								<%
									} else {
										for (CommentVO cvo : reviewCommentList) {
											String content = cvo.getCommt_content();
											if(content == null) content = "삭제된 댓글입니다.";
								%>

										<tr id="<%= cvo.getBoard_id() %>" class="comment reviewboard">
											<td><%= cvo.getCommt_id() %></td>
											<td><%= content %></td>
											<td><%= cvo.getCommt_date() %></td>
										</tr>
										
								<%
										}
									}
								
								%>		
									</tbody>
								</table>
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>
					<!-- /.col -->
				<div id="btnAdd">
					<input type="button" class="btn btn-success btn-sm blkBtn" data-toggle="modal" data-target="#myModal" value="블랙리스트 추가">
					<button type="button" class="btn btn-success" id="withdrawal" >회원탈퇴</button>
				</div>
				</div>

			</section>
		</div>
		<!-- /.row -->
		<!-- /.content -->
	</div>
	<!-- /.content-wrapper -->
	<footer class="main-footer">
		<div class="pull-right hidden-xs">
			<b>Version</b> 1.0
		</div>
		<strong>ⓒ HARANG Ltd. 2022-</strong>
	</footer>
	<!-- Control Sidebar -->

	<!-- 지우지 마시오 -->
	<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
		<li></li>
		<li></li>
	</ul>

<!-- modal 블랙리스트 추가 버튼 -->
<div class="modal fade" id="myModal" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content">
		      
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title" style="text-align : center;">블랙리스트 추가</h4>
			</div>
		        
					<!-- Modal body -->
			<div class="modal-body">
				<form id="blkForm">
					<input type="hidden" name="job" value="insert">
					<div id="insertDiv" class="form-group">
						<label for="memid">회원 ID </label><br>
						<input type="text" id="memid" name="mem_id" readonly>
					</div>
					  
					<div class="form-group">
						<label for="stopReason">정지사유</label>
						<textarea rows="5" cols="5" class="form-control" id="stopReason" placeholder="30자내외로 입력하세요." name="blk_type"></textarea>
					</div>
					  
					<div class="form-group">
						<label for="stopPeriod">정지기간 </label>
						<input type="text" class="form-control" id="stopPeriod" placeholder="숫자를 입력하세요." name="blk_period">
					</div>
					<input type="hidden" name="job" value="insertFromDetail">
					<button type="button" id="save" class="btn btn-success"  >저장</button>
				</form>
			</div>
		        
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-success" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>




	<!-- jQuery 3 -->
<!-- 	<script -->
<%-- 		src="<%=request.getContextPath()%>/js/jquery.min.js"></script> --%>
	<!-- DataTables -->
	<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/js/dataTables.bootstrap.min.js"></script>
	<!-- AdminLTE App -->
	<script src="<%=request.getContextPath()%>/js/adminlte.min.js"></script>
	<script>
		$(function() {
// 			$('#example1').DataTable()
// 			$('#example2').DataTable({
// 				'paging' : true,
// 				'lengthChange' : false,
// 				'searching' : false,
// 				'ordering' : true,
// 				'info' : true,
// 				'autoWidth' : false
// 			})
			
			// 회원 탈퇴
			$('#withdrawal').on('click', function(){
				
				var check = confirm('회원을 탈퇴 처리하시겠습니까?');
				if(!check) return false;
				
				var tmemId = $(this).parents('.content').find('.tdId').text();
					tmemId = tmemId.trim();
					location.href="<%=request.getContextPath()%>/admin.do?job=memDelete&memId=" + tmemId;
					
					alert('삭제되었습니다');
			})
			
			// 게시글 또는 댓글 클릭 시
			$(document).on('click', '.board,.comment', function(){
				var board_id = $(this).attr('id');
				var board_type = $(this).attr('class');
				board_type = board_type.split(" ")[1];
				
				console.log(board_id);
				console.log(board_type);
				
				location.href = "<%= request.getContextPath() %>/board.do?job=detail&board_type=" + board_type + "&board_id=" + board_id;
			})
			
			
			// 블랙리스트 추가 버튼 클릭 시
		    $('.blkBtn').on('click', function(){
		    	
		    	// 회원 아이디
		  	  	var tdid = $('#example1').find('.tdId').text();
		  	  	tdid = tdid.trim();
		  	  	
		  	  	$('#blkForm input[name=mem_id]').val(tdid);
		    });
		    
		    // 신고 폼에서 저장 클릭 시
		    $('#save').on('click', function(){
		    	
		    	var period = $('#stopPeriod').val();
		    	if(period < 1){
		    		alert("정지 기간은 1일 이상부터 가능합니다.");
		    		return false;
		    	}
		    	
		    	var blkType = $('#stopReason').val();
		    	blkType = blkType.trim();
		    	if(blkType.length == 0){
		    		alert("정지 사유를 입력해주세요.");
		    		return false;
		    	}
		    	
		    	var blkPeriod = $('#stopPeriod').val();
		    	if(blkPeriod == ""){
		    		alert("정지 기간을 입력해주세요.");
		    		return false;
		    	}
		    	
		    	
		    	var jsonData = $('#blkForm').serializeJSON();
		    	
		    	$.ajax({
		    		url : '<%= request.getContextPath() %>/blacklist.do',
		    		data : jsonData,
		    		type : 'post',
		    		success : function(res){
		    			
		    			if(res == "SUCCESS"){
		    				alert("블랙리스트에 추가되었습니다.");
		    			} else {
		    				alert('잠시 후 다시 시도해주세요.')
		    			}
		    			location.reload();
		    		},
		    		err : function(err){
		    			alert('잠시 후 다시 시도해주세요.')
		    		},
		    		dataType : 'json'
		    	});
		    });
			
		}); // function
		
//메인 화면 이동
 function main(){
		location.href="<%=request.getContextPath()%>/view/main/mainIndex.jsp";
	}
	</script>
</body>
</html>
