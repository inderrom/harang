<%@page import="com.harang.vo.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.harang.vo.BlkVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>관리자 페이지</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
  <!-- DataTables -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/dataTables.bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/font-awesome/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/_all-skins.min.css">
  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
<!-- jQuery 3 -->
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<!-- DataTables -->
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/dataTables.bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="<%=request.getContextPath()%>/js/adminlte.min.js"></script>

<script src="<%=request.getContextPath()%>/js/jquery.serializejson.js"></script>
<script>

<%
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
%>

function main(){
	location.href="<%=request.getContextPath()%>/view/main/mainIndex.jsp";
}

  $(function () {
//     $('#example1').DataTable()
//     $('#example2').DataTable({
//       'paging'      : true,
//       'lengthChange': false,
//       'searching'   : false,
//       'ordering'    : true,
//       'info'        : true,
//       'autoWidth'   : false
//     })

	// 정지 기간 입력 시
	$('#stopPeriod').on('Keyup', function(){
		period = $(this).val().trim();
		reg = /^[0-9]{3}$/;
    	
    	if(reg.test(period)){
    		$(this).css('border','1px solid green')
    	}else{
    		$(this).css('border','1px solid red');
    	}
    	
    	regtest(reg, period);
	});
    
    // 행 클릭 시
	$(document).on('click', '.updateBtn', function(event){
		
		$(this).hide();
		$('#modifyForm').parent().find('.periodNum').show();
		
		// 수정폼이 나타난다.
		$('#modifyForm').show();
		
		var periodtd = $(this).parents('tr').find('.period');
		
		// 기존에 있던 숫자는 숨긴다.
		var periodNum = $('.periodNum', periodtd);
		periodNum.hide();
		// 정지 기간을 가져온다.
		var period = periodNum.text();
		period = period.trim();
		
		// 수정폼에 정지 기간을 삽입
		$('#stopPeriod').val(period);
		var blkNum = $(this).parents('tr').find('.sorting_1').text();
		blkNum = blkNum.trim();
		
		$('#modifyForm').find('input[name=blk_num]').val(blkNum);
		periodtd.append($('#modifyForm'));
	});
    
    // 수정폼 완료 선택 시
    $('#save').on('click', function(){
    	var period = $('#stopPeriod').val();
    	
    	// 정지 기간이 0일 경우 블랙리스트에서 삭제
    	if(period == '0'){
    		$('#path').val('delete');
    	}
    	
    	var data = $(this).parent().serializeJSON();
    	
    	$.ajax({
    		url : '<%=request.getContextPath()%>/blacklist.do',
    		data : data,
    		type : 'post',
    		success : function(res){
    			
    			if(res == "SUCCESS"){
    				if(period == '0'){
    					alert('블랙리스트에서 삭제되었습니다.');
    				} else {
	    				alert("정지 기간이 수정되었습니다.");
    				}
    				location.reload();
    			} else {
    				alert("잠시 후 다시 시도해주세요.");
    			}
    			
    		},
    		error : function(err){
    			alert('잠시 후 다시 시도해주세요.');
    		},
    		dataType : 'json'
    	});
    });
	
    // 수정폼 취소 선택 시
	$('#cancel').on('click', function(){
		// 기존의 정지 기간 숫자를 표시
		$(this).parents('.period').find('.periodNum').show();
		$(this).parents('.period').find('.updateBtn').show();
		
		// 수정폼 숨기고 내용 비우기
		$('#modifyForm').hide();
		$('#modifyForm input[name=number]').val('');
		$('#modifyForm').appendTo($('body'));
		
	});
    
    
});
</script>

<style>

#stopPeriod, #save { 
/*  	display: none; */
 	border-style : solid ;
 	border-color : #00a65a; 
 
}
a:hover{
	background-color: #00a65a;
	color : white;
}
.updateBtn{
	width :50px;
	height : 26px;
	float : right;
}
#modifyForm{
	display : inline-block;
	height : 10px;
	width : 290px;
}
#mainBtn {
	color : black;
	background : #1DE9B6;
	border-radius: 15px;
}	
</style>
</head>
<%
	List<BlkVO> blkList = new ArrayList<>();
	List<?> tempBlkList = (List<?>)request.getAttribute("blkList");
	for(Object obj : tempBlkList){
		if(obj instanceof BlkVO){
			blkList.add((BlkVO) obj);
		}
	}
	
%>

<body class="hold-transition skin-green sidebar-mini">
<div class="wrapper">

  <header class="main-header">
    <!-- Logo -->
    <a href="<%= request.getContextPath() %>/view/admin/adminIndex.jsp" class="logo">
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>관리자 계정</b></span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
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
          <img src="<%=request.getContextPath()%>/images/admin/user.png" class="img-circle" alt="user Image">
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
        <li class="active treeview">
          <a href="#">
            <i class="fa fa-dashboard"></i> <span>회원 관리</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="<%=request.getContextPath()%>/member.do?job=list"><i class="fa fa-circle-o"></i> 회원 정보 조회</a></li>
            <li><a href="<%=request.getContextPath()%>/report.do?job=list"><i class="fa fa-circle-o"></i> 신고 받은 회원 조회</a></li>
			<li class="active"><a href="<%=request.getContextPath()%>/blacklist.do?job=list"><i class="fa fa-circle-o"></i> 블랙리스트 조회</a></li>
          </ul>
        </li>

		 <li class="treeview">
          <a href="#">
            <i class="fa fa-dashboard"></i> <span>게시물 관리</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="<%=request.getContextPath()%>/admin.do?job=allBoard&board_type=freeboard"><i class="fa fa-circle-o"></i>자유 게시판</a></li>
            <li><a href="<%=request.getContextPath()%>/admin.do?job=allBoard&board_type=quesboard"><i class="fa fa-circle-o"></i>문의 게시판</a></li>
			<li><a href="<%=request.getContextPath()%>/admin.do?job=allBoard&board_type=reviewboard"><i class="fa fa-circle-o"></i>후기 게시판</a></li>
          </ul>
        </li>

		 <li class="treeview">
          <a href="#">
            <i class="fa fa-dashboard"></i> <span>여행지 관리</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="<%= request.getContextPath() %>/tour.do?job=listAdmin"><i class="fa fa-circle-o"></i> 여행지 조회</a></li>
          </ul>
        </li>
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
					<li class="active">블랙리스트 조회</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-xs-12">

						<div class="box">
							<div class="box-header">
								<h3 class="box-title">블랙리스트 조회</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table id="example1" class="table table-bordered table-striped">
									<thead>
										<tr>
											<th style="width:10%;">정지 번호</th>
											<th style="width:10%;">회원 ID</th>
											<th style="width:35%;">정지 사유</th>
											<th style="width:20%;">정지 일자</th>
											<th style="width:25%;">정지 기간</th>
										</tr>
									</thead>
									<tbody>
						
						<%
							if(blkList == null || blkList.size() == 0){
						%>		
								
							<tr><td colspan="5" style="text-align: center;">데이터가 존재하지 않습니다.</td></tr>	
								
						<%		
								
							} else {
								for(BlkVO blkVo : blkList){
						%>
										<tr>
											<td class="sorting_1"><%= blkVo.getBlk_num() %></td>
											<td id="memId"><%= blkVo.getMem_id() %></td>
											<td><%= blkVo.getBlk_type() %></td>
											<td><%= blkVo.getBlk_date() %></td>
											<td class="period"><span class="periodNum"><%= blkVo.getBlk_period() %></span><input type="button" class="updateBtn" value="수정"></td>
										</tr>
							<% 		}
								}	
							%>
									</tbody>
								</table>

							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.col -->
					</div>
					<!-- /.box -->
				</div>
		</section>
		</div>
		<!-- /.row -->
		
		<!-- 수정폼 -->
		<div id="modifyForm" style="display:none;">
			<form action="<%=request.getContextPath()%>/blacklist.do" method="post">
				<input id="path" type="hidden" name="job" value="update">
				<input type="hidden" name="blk_num">
				<input type="number" id="stopPeriod" name="blk_period" placeholder="0:삭제, 1~:기간수정" >
				<input type="button" id="save" class="btn btn-success btn-sm" value="완료">
				<input type="button" id="cancel" class="btn btn-success btn-sm" value="취소">
			</form>
		</div>
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
</body>
</html>
