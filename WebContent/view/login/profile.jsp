<%@page import="com.harang.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HARANG PROFILE LOGIN</title>
 <meta name="viewport" content="width=device-width, initial-scale=1">
 
  <!-- Bootstrap 적용 -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="icon" href="<%=request.getContextPath()%>/images/layout/Union.png">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/navbar.css">
  
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
		
	});
	
	// form에 경고문띄우기 부트스트랩
	$(function() {
 		 window.addEventListener('load', function() {
    		var forms = document.getElementsByClassName('needs-validation');
   		 	var validation = Array.prototype.filter.call(forms, function(form) {
     			form.addEventListener('submit', function(event) {
        			if (form.checkValidity() === false) {
          				event.preventDefault();
          				event.stopPropagation();
        			}
        			form.classList.add('was-validated');
      			}, false);
    		});
  		}, false);
	});
	
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
	})
	
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
	max-width : 650px;
	margin-top : 50px;
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
	max-height : initial;
	margin-top: -20%;
	filter:brightness(60%);
	transform: translate( 0px, 300px );
	z-index : 2;
}
.text{
	position : absolute;
	transform: translate( 800px, -200px );
	font-size : 40pt;
	color : white;
}
.text2{
	position : absolute;
	transform: translate( 760px, -170px );
	font-size : 20pt;
	color : white;
}

/* --------------------------------------------- */
.btn1, .btn2{
	float : left;
	width : 325px;
	height : 75px;
	border : 0px;
	border-radius : 0px;
	margin-top : 0px;
	background-color : rgba( 29, 233, 182, 0.9 );
	font-family: 'Noto Sans KR', sans-serif;
}
.btn2{
	border : 0px;
	background-color : #013E8D;
}
.alignbtn{
	display : inline-block; 
}

.chkBtn:hover, .btn1:hover, .btn2:hover{
	background  : #FF7E47;
	color : white;
}
.chkBtn{
	margin : 10px;
	float : right;
	border : none;
	background-color : #1DE9B6;
	font-family: 'Noto Sans KR', sans-serif;
} 

.form-group{
	margin-top : 30px;
	margin-left: 70px;
	margin-right: 70px;
	margin-bottom : 50px;
	font-family: 'Noto Sans KR', sans-serif;
}
.signupText{
	margin-left : 70px;
	font-family: 'Noto Sans KR', sans-serif;
}
.col-sm-3{
	margin : 10px;
	padding : 5px;
	width : 50px;
}

.upComplete, .cancel{
	display : none;
}
.update{
	float : right;
	background-color : #1DE9B6;
	border : none;
}
.updateCpl, .updateCancel{
	background-color : #1DE9B6;
	border : none;
}
.changeBtn{
	float : right;
	background-color : #1DE9B6;
	color : white;
	border : none;
}
/* ------------------------------------- */
.modal-title{
	font-size : 20pt; 
	font-family: 'Noto Sans KR', sans-serif;
}
.withdrawalModalText{
	font-size : 14pt; 
	font-family: 'Noto Sans KR', sans-serif;
	margin-top : 20px;
}
</style>
<script>
	
	$(function(){
		
		
		
		
		// -----------------------------------------------------------
		
		var flag = false;
		
		// 비밀번호 입력 시
		$("#mem_passChk").on('keyup', function(){
			
	 		var pass1 = $("#mem_pass").val();
	 		var pass2 = $("#mem_passChk").val();
	 		passreg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()+]).{8,14}$/;
	 		
	 		if(!passreg.test(pass1)){
	 			$("#passChkResult").html("<span style='color:red'>비밀번호는 영어 대소문자와, 숫자, 특수문자를 포함해야 합니다.</span>");
	 			flag = false;
	 		}else if(pass1!=pass2) {
	 			$("#passChkResult").html("<span style='color:red'>비밀번호를 다시 확인해주세요</span>");
	 			flag = false;
	 		}else{
	 			$("#passChkResult").empty();
	 			flag = true;
	 		}
	 	});
		
		
		// 닉네임 입력 시
 		$("#mem_nick").on('keyup',function(){
 			var nickName = $("#mem_nick").val();
 			
 			// 한글 포함 1,14글자
 			var nickLength = nickName.length;
 			
 			if(nickLength > 1 && nickLength < 15 ){
 				$("#nicknameResult").empty();
 				flag = true;
 			} else {
 				$("#nicknameResult").html("<span style='color: red'>닉네임은 2~14자 사이로 입력해주세요.</span>");
 				flag = false;
 			}
 		});
		
		// 성별 변경 시
		$('#genderList').on('change', function(){
			var gender = $(this).val();
			$('#mem_gender').val(gender); // hidden 타입의 input 태그에 선택 값을 준다.
			flag = true;
		});
		
		// 전화번호 입력 시
	 	$("#mem_tel").on('keyup', function(){
	 		
	 		var tel = $("#mem_tel").val();
	 		telreg=/^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	 		
	 		if(telreg.test(tel) || tel == "") {
	 			$("#telChkResult").empty();
	 			flag = true;
	 		}else{
	 			$("#telChkResult").html("<span style='color:red'>전화번호 형식이 맞지 않습니다.</span>");
	 			flag = false;
	 		}
	 	});
		
		
	 	// 프로필의 비밀번호는 기본 readonly상태이고, 수정버튼을 누르면 readonly해제, 취소를 누르면 다시 readonly로
	 	
		// 수정 버튼 클릭 시
		$('.update').on('click',function(){
			// 수정 버튼이 사라지고 완료 / 취소 버튼이 나타난다.
			var parent = $(this).parent();
			parent.find('.updateCpl, .updateCancel').show();
			$(this).hide();
			
			// 값이 적혀있던 p 태그가 사라지고 수정폼이 나타난다.
			$(this).closest('.form-group').find('p').hide();
			$(this).closest('.form-group').find('.updateForm').show();
			
			// 비밀번호 란의 경우 readonly로 변경
			$(this).closest('.form-group').find('.form-control').prop('readonly', false);
			$(this).closest('.form-group').next().find('.form-control').prop('readonly', false);
		});
		
		//취소버튼을 누르면 p태그로 돌아옴
		$('.updateCancel').on('click',function(){
			// 완료 / 취소 버튼이 사라지고 수정 버튼이 나타난다.
			var parent = $(this).parent();
			parent.find('.updateCpl, .updateCancel').hide();
			parent.find('.update').show();
			
			// 값이 적혀있던 p 태그가 다시 나타나고 수정폼은 비워진 뒤 숨겨진다.
			$(this).closest('.form-group').find('p').show();
			$(this).closest('.form-group').find('.updateForm').val('');
			$(this).closest('.form-group').find('.updateForm').hide();
			
			// 비밀번호 란의 경우 readonly로 변경
			$(this).closest('.form-group').find('.form-control').prop('readonly', true);
			$(this).closest('.form-group').next().find('.form-control').prop('readonly', true);
			
			// 비밀번호 란에 입력했던 값을 초기화
			$(this).closest('.form-group').find('.form-control').val('');
			$(this).closest('.form-group').next().find('.form-control').val('');
			
			// 경고문을 모두 숨긴다.
			$('.resultSpan').empty();
		});
		
// 		//완료버튼을 누르면 p태그로 돌아옴
// 		$('.updateCpl').on('click',function(){
// 			var pTag = $(this).closest('.form-group').find('p');
// 			var form = $(this).closest('.form-group').find('.updateForm');
			
// 			// 입력 란에 입력한 값을 P 태그에 적용한다.
// 			pTag.text(form.val());
// 			pTag.show();
// 			form.hide();
			
// 			// 비밀번호 란의 경우 readonly로 변경
// 			$(this).closest('.form-group').find('.form-control').prop('readonly', true);
// 			$(this).closest('.form-group').next().find('.form-control').prop('readonly', true);
// 		});
		
		// 완료 버튼 클릭 시 해당 항목 수정
		$('.updateCpl').on('click', function(){
			
			if(!flag){
				return false;
			}
			
			var target = $(this).parent().find('input');
			
			var type = target.attr('name');
			var value = target.val();
			
			// 보낼 데이터를 준비한다.
			var data = {};
			data["job"] = "profile";
			data["mem_id"] = "<%= memInfo.getMem_id() %>",
			data[type] = value;
			
			$.ajax({
				url : "<%=request.getContextPath() %>/memberProfile.do",
				type : 'post',
				data : data,
				success : function(res){
					
					if(res == "SUCCESS"){
						alert("프로필이 수정되었습니다.");
						location.reload();
					} else {
						alert("잠시 후 다시 시도해주세요.");
					}
					
				},
				error : function(err){
					alert(err.status + " : " + err.statusText);
				},
				dataType : 'json'
			});
		});
		
		// 회원 탈퇴 버튼 클릭 시
		$('#withdrawalBtn').on('click', function(){
			var id = "<%= memInfo.getMem_id() %>";
			var pass = $('#withdrawalPass').val();
			
			$.ajax({
				url : '<%= request.getContextPath() %>/member.do',
				data : {
					"job" : "memCheck",
					"mem_id" : id,
					"mem_pass" : pass
				},
				type : 'post',
				success : function(res){
					
					if(res == "SUCCESS"){
						withdrawal(id);
					} else {
						alert("비밀번호를 확인해주세요.");
					}
					
				},
				error : function(err){
					alert(err.status + " : " + err.statusText);
				},
				dataType : 'json'
			});
		});
	})
	
	// 회원 탈퇴 처리
	function withdrawal(id){
		$.ajax({
			url : '<%= request.getContextPath() %>/member.do',
			data : {
				"job" : "delete",
				"mem_id" : id
			},
			type : 'post',
			success : function(res){
				
				if(res == "SUCCESS"){
					alert("회원 탈퇴가 완료되었어요. 다음에 또 만나요.");
					location.href = '<%= request.getContextPath()%>/memberLogout.do?job=logout';
				} else {
					alert("잠시 후 다시 시도해주세요.");
				}
				
			},
			error : function(err){
				alert(err.status + " : " + err.statusText);
			},
			dataType : 'json'
		});
	}
	
	


</script>
</head>
<body>

<!-- header navbar -->
<header>
<nav class="navbar navbar-expand-sm bg-white navbar-white">
	<a class="navbar-brand" href="<%= request.getContextPath() %>/view/main/mainIndex.jsp" style="color:#1DE9B6;"><img src="<%=request.getContextPath()%>/images/layout/Union.png" id="icon"> Harang</a>
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
		<div class="col-sm-3 auto"></div>	
	</nav>
	
	
<!-- subnavbar ==> header 이미지 위로 올라와야하므로 header section에 위치 -->
		<nav>
		<div id="imageSec" >
			<div class="col-md-12" id="subMenuList" style="display:none;">
				<div class="col-md-4" style="margin-right : 50px;"></div>
				<div class="subMenuBlock">
					<div class="subMenuBlock">
					<ul class="subMenu">
						<li><a href="javascript:void(0)" id="goSearchAirplane">항공권 예매</a></li>
					</ul>
				</div>
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
			<h1 class="text">회원정보</h1><br>
		</div>
	</div>
</header>

<!-- main section -->
<section>
	<div class="container-fluid">
		<div class="row">
			<div>
			<h2 class="signupText">회원정보</h2>
			<br>
			<form class="needs-validation" novalidate>
			<input type= "hidden" name = "job" value ="profile" >
				<div class="form-group">
					
					<label for="uId">아이디 <span style="color:red;">*</span></label>
						<p><%=memInfo.getMem_id() %></p>
					<hr/>										
				</div>
				
				<div class="form-group">
					
					<label for="pwd1">비밀번호 <span style="color:red;">*</span></label> 
					<button type="button" class="col-sm-3 btn btn-primary update">수정</button>
					<button type="button" class="col-sm-3 btn btn-primary updateCpl" style="display : none;">완료</button>
					<button type="button" class="col-sm-3 btn btn-primary updateCancel" style="display : none;">취소</button><br/>
					<input type="password" class="form-control" placeholder="********" id="mem_pass"  name="mem_pass" required readonly>
					<div class="invalid-feedback">비밀번호는 특수문자를 포함한 8자리 이상으로 작성해주십시오.</div>
					<span id="passChkResult" class="resultSpan"></span>
				</div>
				

				<div class="form-group">
					<label for="pwd2">비밀번호 확인 <span style="color:red;">*</span></label> 
					<input type="password" class="form-control" placeholder="********" id="mem_passChk" name="mem_passChk" required readonly>
					<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
					<hr/>
				</div>

				<div class="form-group">
					<label for="uName">이름 <span style="color:red;">*</span></label>
										
					<p><%=memInfo.getMem_name()%></p>	
					<hr/>
				</div>
				
				<div class="form-group">
					<label for="uName">닉네임 <span style="color:red;">*</span></label> 
					<button type="button" class="col-sm-3 btn btn-primary update">수정</button>	
					<button type="button" id= "nickChanging" class="col-sm-3 btn btn-primary updateCpl" style="display : none;">완료</button>	
					<button type="button" class="col-sm-3 btn btn-primary updateCancel" style="display : none;">취소</button><br/>	
					<p id="nickChange"><%=memInfo.getMem_nick() %></p>
					<input class="form-control updateForm" type="text" value= "<%=memInfo.getMem_nick() %>" id= "mem_nick" name= "mem_nick" style="display:none;" readonly>
					<span id="nicknameResult" class="resultSpan"></span>
					<hr/>
				</div>

				<div class="form-group">
					<label for="ubir">생년월일 <span style="color:red;">*</span></label> 
					<p><%=memInfo.getMem_bir().substring(0,10) %></p>
					<hr/>
				</div>


				<div class="form-group">
					<label for="umail">본인 확인 이메일 <span style="color:red;">*</span></label> 
					<p><%= memInfo.getMem_mail() %></p>	
					<hr/>
				</div>
				
				<div class="form-group">
					<label for="ujhender">성별</label> 
					<button type="button" class="col-sm-3 btn btn-primary update">수정</button>	
					<button type="button"  id="hpChanging" class="col-sm-3 btn btn-primary updateCpl" style="display : none;">완료</button>	
					<button type="button" class="col-sm-3 btn btn-primary updateCancel" style="display : none;">취소</button><br/>
					<%
						String gender = memInfo.getMem_gender();
						String genderStr = "";
						
						if(gender != null){
							switch(gender){
							case "M":
								genderStr = "남자";
								break;
							case "W":
								genderStr = "여자";
								break;
							}
						} else {
							genderStr = "없음";
						}
					%>
					<p><%= genderStr %></p>
					<input class="form-control updateForm" type="hidden" id="mem_gender" name="mem_gender" readonly>
					<select class="form-control updateForm" id="genderList" style="display:none;">
						<option value="" selected>없음</option>
						<option value="M">남자</option>
						<option value="W">여자</option>
					</select>
					<hr/>
				</div>
	
				<div class="form-group">
					<label for="mem_tel">휴대전화</label> 
					<button type="button" class="col-sm-3 btn btn-primary update">수정</button>	
					<button type="button"  id="hpChanging" class="col-sm-3 btn btn-primary updateCpl" style="display : none;">완료</button>	
					<button type="button" class="col-sm-3 btn btn-primary updateCancel" style="display : none;">취소</button><br/>
					<%
						// 회원가입 시 전화번호를 입력하지 않았을 경우
						String tel = memInfo.getMem_tel();
						if(tel == null) tel = "없음";
					%>
					<p><%= tel %></p>
					<input class="form-control updateForm" type="text" id="mem_tel" name="mem_tel" style="display:none;" readonly>
					<span id="telChkResult" class="resultSpan"></span>
					<hr/>					
				</div>
				
				<div class="form-group" style="">
					<a href="#" data-toggle="modal" data-target="#myModal">회원 탈퇴</a>
<!-- 					<button type="button" id="change" class="btn btn-primary changeBtn" style="float: right;">회원정보 변경</button> -->
				</div>
			
				<!-- 회원등록 버튼을 누르면 회원가입이 완료되었다는 alert창이 뜨고 로그인 화면으로 넘겨주면 되겠습니다. - 수정완료시 이 주석은 삭제바람-->
				<div class="alignbtn">
					<button type="button" class="col-sm-6 btn btn-primary btn1" onclick="location.href='<%= request.getContextPath() %>/ticket.do?job=mylist&mem_id=<%= memInfo.getMem_id() %>'">예매정보 확인</button>
					<button type="button" class="col-sm-6 btn btn-primary btn2" onclick="location.href='<%= request.getContextPath() %>/view/main/mainIndex.jsp'">메인으로</button>
				</div>
			</form>
			</div>
		</div>
	</div>
</section>


<div class="modal fade modalForm" id="myModal">
	<div class="modal-dialog">
		<div class="modal-content">
  
		<!-- Modal Header -->
			<div class="modal-header">
				<div class="modal-title">회원탈퇴</div>
				<button type="button" class="close" data-dismiss="modal">×</button>
			</div>
     
<!-- Modal body -->
			<div class="modal-body">
				<form>	
					<label class="withdrawalModalText">탈퇴 사유<br>
						<select class="form-control">
							<option selected>사이트를 이용하지 않아서</option>
							<option>항공권이 비싸서</option>
							<option>사이트 이용이 불편해서</option>
							<option>불친절해서</option>
							<option>다른 회원과의 마찰로 인해</option>
						</select>
					</label>
					<label class="withdrawalModalText">비밀번호<br>
						<input type="password" id="withdrawalPass" name="mem_pass">
					</label>
					<input type="hidden" name="job" value="delete">
					<input type="hidden" name="mem_id" value="<%= memInfo.getMem_id() %>">
				</form>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal" id="withdrawalBtn">탈퇴하기</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal" style="background-color : #1DE9B6; border : none;">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- footer section -->
<div style="margin-bottom:0; margin-top: 100px">
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