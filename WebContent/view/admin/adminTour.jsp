<%@page import="com.harang.vo.MemberVO"%>
<%@page import="com.harang.vo.AirportVO"%>
<%@page import="com.harang.vo.TourVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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

 <!-- modal -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>


<style>

@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400&display=swap');
body{
	min-width : 1600px;
	height : 100%;
	background : linear-gradient(rgba( 29, 233, 182, 0.65 ), white)
}
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
	text-align : center;
}

.textsp{
	color : black;
}
.card-img-top{ width:300px; height: 350px; overflow: hidden; position: relative;}

.card-img-top > img{
	position: absolute;
	height : 100%;
  	top: 50%;
  	left: 50%;
  	transform: translate(-50%, -50%);
}

/*--------------------------------------------------------------*/
#stopPeriod, #save { 
 	display: none;
 	border-style : solid ;
 	border-color : #00a65a; 
 
}
a:hover{
	background-color: #00a65a;
	color : white;
}
#memId{
	cursor: pointer;
}

.modiDel{text-align: center;}
.modiDel1{ display:inline-block;}

#mainBtn {
	color : black;
	background : #1DE9B6;
	border-radius: 15px;
}	

/* #fileInput{visibility: hidden;} */
/*----------------------------------------------------------------*/
<!--modal -->
.form-group{width:100px; height:100px; overflow: hidden; position : relateive;}
.form-group > img{
	position : absolute;
	height: 50%;
	top:50%;
	left:50%;
	transform: translate(-50%. -50%);
}

/* ---------------------------------------------------------------------- */
.cardArticle{
	margin : 10px;
	padding:20px;
	border-radius: 20px;
}

.Kyotoimg{
	width : 350px;
	height : 200px;
	overflow:hidden;
	position : relative;
	border-radius : 10px;
}

</style>
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
	
	// 공항 목록
	List<AirportVO> airportList = new ArrayList<>();
	List<?> tempAirportList = (List<?>) request.getAttribute("airportList");
	
	for(Object obj : tempAirportList){
		if(obj instanceof AirportVO){
			airportList.add((AirportVO) obj);
		}
	}
	
	// 여행지 목록
	List<TourVO> tourList = new ArrayList<>();
	List<?> tempTourList = (List<?>) request.getAttribute("tourList");
	for(Object obj : tempTourList){
		if(obj instanceof TourVO){
			tourList.add((TourVO) obj);
		}
	}
%>
</script>
</head>


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
            <li><a href="<%=request.getContextPath()%>/member.do?job=list"><i class="fa fa-circle-o"></i> 회원 정보 조회</a></li>
            <li><a href="<%=request.getContextPath()%>/report.do?job=list"><i class="fa fa-circle-o"></i> 신고 받은 회원 조회</a></li>
			<li><a href="<%=request.getContextPath()%>/blacklist.do?job=list"><i class="fa fa-circle-o"></i> 블랙리스트 조회</a></li>
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

		 <li class="active treeview">
          <a href="#">
            <i class="fa fa-dashboard"></i> <span>여행지 관리</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li class="active"><a href="<%= request.getContextPath() %>/tour.do?job=listAdmin"><i class="fa fa-circle-o"></i> 여행지 조회</a></li>
          </ul>
        </li>
	  </ul>
    </section>
  </aside>
  <!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>여행지 관리</h1>
				<ol class="breadcrumb">
					<li>
						<a href="<%= request.getContextPath() %>/view/admin/adminIndex.jsp">
						<i class="fa fa-dashboard"></i> Home</a>
					</li>
					<li class="active">여행지 관리</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="row">
					<div class="col-xs-12">

						<div class="box">
							<div class="box-header">
								<button type="button" id="addBtn" class="btn btn-success" 
								data-toggle="modal" data-target="#myModal1">여행지 추가</button>
							</div>
							<!-- /.box-header -->
							<div class="box-body">

								<div id="ulBox">
									<ul class="facilityList">
									<%
										for(int i = 0; i < tourList.size(); i++){
											TourVO tourVo = tourList.get(i);
									%>
											<li id="list" class="info">
												<div class="card">
													<div class="card-img-top">
												<%
													if(tourVo.getTour_file() != null){
												%>
														<img src="<%=request.getContextPath()%>/images/tour/<%= tourVo.getTour_file() %>" class="rounded" alt="Card image">
												<%
													} else {
												%>
														<img src="<%=request.getContextPath()%>/images/layout/main02.png" class="rounded" alt="Card image">
												<%
													}
												%>
													</div>
													<div class="card-body">
														<input type="hidden" class="tourNum" value="<%= tourVo.getTour_num() %>">
														<input type="hidden" class="tourPort" value="<%= tourVo.getAirport_id() %>">
														<h4 class="card-title tourName"><%= tourVo.getTour_name() %></h4>
														<p class="card-text tourPhrase"><%= tourVo.getTour_phrase() %></p>
														<hr>
														<div class="modiDel">
															<button type="button" class="btn btn-success modiDel1 updateBtn" data-toggle="modal" data-target="#myModal">수정</button>
															<button type="button" class="btn btn-success modiDel1 deleteBtn">삭제</button>
														</div>
													</div>
												</div>
											</li>
									<%
										}
									%>
									</ul>
								</div>
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
    
<!-- modal 여행지 수정버튼 -->
<div class="modal fade" id="myModal" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content">
		  
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title" style="text-align : center;">여행지 수정</h4>
			</div>
		
			<!-- Modal body -->
			<div class="modal-body">
				<form action="<%= request.getContextPath() %>/tour.do" id="updateForm" method="post" enctype="multipart/form-data">
					<input type="hidden" id="updateNum" name="tour_num">
					<div class="form-group">
						<label for="updateFile">사진변경</label>
						<input type="file" id="updateFile" name="tour_file">
					</div>
					<div class="form-group">
						<label for="updateAirport">공항 선택</label>
			         	<select class="form-control" id="updateAirport" name="airport_id">
			         	<%
							for(int i = 0; i < airportList.size(); i++){
								AirportVO airportVo = airportList.get(i);
			         	%>
								<option value="<%= airportVo.getAirport_id() %>"><%= airportVo.getAirport_name() %></option>
						<%
							}
						%>
						</select>
					</div>
					<div class="form-group">
						<label for="updateName">여행지명</label>
						<input type="text" class="form-control" id="updateName" placeholder="여행지명입력" name="tour_name">
					</div>
					<div class="form-group">
						<label for="updatePhrase">여행지 안내글 </label>
						<textarea rows="5" cols="5" class="form-control" id="updatePhrase" placeholder="안내글입력" name="tour_phrase"></textarea>
					</div>
					<input type="hidden" name="job" value="update">
					<button type="submit" class="btn btn-success">수정</button>
				</form>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-success" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- modal 여행지 추가버튼 -->
<div class="modal fade" id="myModal1" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
			<h4 class="modal-title" style="text-align : center;">여행지 추가</h4>
			</div>
			<!-- Modal body -->
			<div class="modal-body">
				<form action="<%= request.getContextPath() %>/tour.do" id="insertForm" method="post" enctype="multipart/form-data">
					<div class="form-group">
						<label for="tfile1">사진추가</label>
						<input type="file" id="fileInput" name="tour_file">
					</div>
					<div class="form-group">
						<label for="tname1">공항 선택</label>
			         	<select class="form-control" name="airport_id">
			         	<%
							for(int i = 0; i < airportList.size(); i++){
								AirportVO airportVo = airportList.get(i);
			         	%>
								<option value="<%= airportVo.getAirport_id() %>"><%= airportVo.getAirport_name() %></option>
						<%
							}
						%>
						</select>
					</div>
					<div class="form-group">
						<label for="tname1">여행지명 </label>
						<input type="text" class="form-control" id="tName1" placeholder="여행지명입력" name="tour_name">
					</div>
					<div class="form-group">
						<label for="ttext">여행지 안내글 </label>
						<textarea rows="5" cols="5" class="form-control" id="tText1" placeholder="안내글입력" name="tour_phrase"></textarea>
					</div>
					<input type="hidden" name="job" value="insert">
					<button type="button" id="insertBtn" class="btn btn-success">저장</button>
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
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<!-- DataTables -->
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/dataTables.bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="<%=request.getContextPath()%>/js/adminlte.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.serializejson.js"></script>

<script>
$(function () {
    $('#example1').DataTable()
    $('#example2').DataTable({
      'paging'      : true,
      'lengthChange': false,
      'searching'   : false,
      'ordering'    : true,
      'info'        : true,
      'autoWidth'   : false
    });
	
// 	$('.modal-dialog').draggable({
// 	      handle: ".modal-header"
//     });

	// 여행지 추가폼에서 저장 버튼 클릭 시
	$('#insertBtn').on('click', function(){
		
		var tourTitle = $('#tName1').val();
		tourTitle = tourTitle.trim();
		
		if(tourTitle.length == 0){
			alert("여행지명을 입력해주세요.");
			return false;
		}
		
		$('#insertForm').submit();
	});

	// 여행지 카드에서 삭제 버튼 클릭 시
	$('.deleteBtn').on('click', function(){
		
		// 삭제 전 확인 절차
		var check = confirm("여행지를 삭제하시겠습니까?");
		
		if(!check){
			return false;
		}
		
		
		var tourNum = $(this).parents('.card-body').find('.tourNum').val();
		
		$.ajax({
			url : '<%= request.getContextPath() %>/tour.do',
			data : {
				"job" : "delete",
				"tour_num" : tourNum
			},
			type : 'get',
			success : function(res){
				
				if(res == "SUCCESS"){
					alert("여행지가 삭제되었습니다.");
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
	})
	
	// 수정 버튼 클릭 시
	$('.updateBtn').on('click', function(){
		
		// 기존 여행지 데이터 가져오기
		var tourNum = $(this).parents('.card-body').find('.tourNum').val();
		var tourPort = $(this).parents('.card-body').find('.tourPort').val();
		var tourName = $(this).parents('.card-body').find('.tourName').text();
		tourName = tourName.trim();
		var tourPhrase = $(this).parents('.card-body').find('.tourPhrase').text();
		tourPhrase = tourPhrase.trim();
		
		// 수정폼에 기존 데이터를 넣어준다.
		var updateForm = $('#updateForm');
		$('#updateNum', updateForm).val(tourNum);
		$('#updateAirport', updateForm).val(tourPort);
		$('#updateName', updateForm).val(tourName);
		$('#updatePhrase', updateForm).val(tourPhrase);
		
	});
})
  
// 메인 화면 이동
function main(){
	location.href="<%=request.getContextPath()%>/view/main/mainIndex.jsp";
}
  


  
</script>
</body>
</html>
