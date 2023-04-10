
<%@page import="com.harang.vo.MemberVO"%>
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
<!-- AdminLTE App -->
<script src="<%=request.getContextPath()%>/js/adminlte.min.js"></script>
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
// 메인 화면 이동
function main(){
	location.href="<%=request.getContextPath()%>/view/main/mainIndex.jsp";
}

</script>

<style>
#mainBtn {
	color : black;
	background : #1DE9B6;
	border-radius: 15px;
}	
</head>
</style>
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
        <li class="treeview">
          <a href="#">
            <i class="fa fa-dashboard"></i> <span>회원 관리</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li class=""><a href="<%=request.getContextPath()%>/member.do?job=list"><i class="fa fa-circle-o"></i> 회원 정보 조회</a></li>
            <li class=""><a href="<%=request.getContextPath()%>/report.do?job=list"><i class="fa fa-circle-o"></i> 신고 받은 회원 조회</a></li>
			<li class=""><a href="<%=request.getContextPath()%>/blacklist.do?job=list"><i class="fa fa-circle-o"></i> 블랙리스트 조회</a></li>
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
        관리자 계정입니다.
        <small>메뉴를 클릭해주세요.</small>
      </h1>
      <ol class="breadcrumb">
        <li>
        	<a href="<%= request.getContextPath() %>/view/admin/adminIndex.jsp">
        	<i class="fa fa-dashboard"></i> Home</a>
        </li>
        <li class="active">관리자 메인</li>
      </ol>
    </section>
    <!-- /.content -->
  </div>
</div>


  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 1.0
    </div>
    <strong>ⓒ HARANG Ltd. 2022-</strong>
  </footer>

    <!-- 지우지마세요 -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li></li>
      <li></li>
    </ul>

</body>
</html>
    