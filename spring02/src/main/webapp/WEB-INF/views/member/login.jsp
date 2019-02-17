<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- views/member/login.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
<%@ include file="../include/header.jsp" %>
<script>
$(function(){
	$("#userid").focus();
	
	$("#btnLogin").click(function(){
		var userid=$("#userid").val(); //태그의 value 속성값
		var passwd=$("#passwd").val();
		
		if(userid==""){
			alert("아이디를 입력하세요.");
			$("#userid").focus(); //입력 포커스 이동
			return; //함수 종료
		}
		if(passwd==""){
			alert("비밀번호를 입력하세요.");
			$("#passwd").focus();
			return;
		}
		if(userid=="admin") {
			alert("해당 아이디로 로그인 불가합니다.");
			$("#userid").focus();
			return;
		}
		
		//폼 데이터를 서버로 제출
		/* document.form1.action="${path}/member/login_check.do";
		document.form1.submit(); */
		$("form[name=form1]").attr("action","${path}/member/login_check.do");
		$("form[name=form1]").submit();
	});
	
	$("#userid").keypress(function() {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		
		if(keycode == '13') {
			var userid=$("#userid").val(); //태그의 value 속성값
			var passwd=$("#passwd").val();
			
			if(userid==""){
				alert("아이디를 입력하세요.");
				$("#userid").focus(); //입력 포커스 이동
				return; //함수 종료
			}
			if(passwd==""){
				alert("비밀번호를 입력하세요.");
				$("#passwd").focus();
				return;
			}
			if(userid=="admin") {
				alert("해당 아이디로 로그인 불가합니다.");
				$("#userid").focus();
				return;
			}
			
			//폼 데이터를 서버로 제출
			$("form[name=form1]").attr("action","${path}/member/login_check.do");
			$("form[name=form1]").submit();
		}
	});
	
	$("#passwd").keypress(function() {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		
		if(keycode == '13') {
			var userid=$("#userid").val(); //태그의 value 속성값
			var passwd=$("#passwd").val();
			
			if(userid==""){
				alert("아이디를 입력하세요.");
				$("#userid").focus(); //입력 포커스 이동
				return; //함수 종료
			}
			if(passwd==""){
				alert("비밀번호를 입력하세요.");
				$("#passwd").focus();
				return;
			}
			if(userid=="admin") {
				alert("해당 아이디로 로그인 불가합니다.");
				$("#userid").focus();
				return;
			}
			
			//폼 데이터를 서버로 제출
			$("form[name=form1]").attr("action","${path}/member/login_check.do");
			$("form[name=form1]").submit();
		}
	});
	
	$("#btnJoin").click(function() {
		$("form[name=form1]").attr("action","/member/join.do");
		$("form[name=form1]").submit();
		/* document.form1.action="/member/join.do";
		document.form1.submit(); */
	});
	
});

function kakao_login() {
	//window.open('https://kauth.kakao.com/oauth/authorize?client_id=4df0a212b67066319be28e560b93c078&redirect_uri=https://test.kjsfk.com/kakaologin&response_type=code','카카오톡로그인','width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes');
	location.href="https://kauth.kakao.com/oauth/authorize?client_id=4df0a212b67066319be28e560b93c078&redirect_uri=https://test.kjsfk.com/kakaologin&response_type=code";
	/* var win = window.open("", "_self");
    win.close(); */
}

function naver_login() {
	location.href="/naverlogin";
	//window.open('/naverlogin', '네이버로그인', 'width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes');
	
	/* var win = window.open("", "_self");
    win.close(); */
}

</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<!-- <br><br><br><br><br><br><br><br><br> -->
<h2 class="text-center">Please sign in</h2><br>
<form name="form1" method="post">
<table class="container-fluid" style="width: 350px;">
	<tr>
		<!-- <td>아이디</td> -->
		<td><input name="userid" id="userid" class="form-control" placeholder="User ID"><br></td>
	</tr>
	<tr>
		<!-- <td>비밀번호</td> -->
		<td><input type="password" name="passwd" id="passwd" class="form-control" placeholder="Password"><br></td>
	</tr>
	<tr>
		<td align="center">
		
			<c:if test="${param.message == 'nologin' }">
				<div style="color:red;">
					로그인 하신 후 사용하세요.
				</div>				
			</c:if>
			<c:if test="${message == 'error' }">
				<div style="color:red;">
					아이디 또는 비밀번호가 일치하지 않습니다.
				</div>
			</c:if>
			<c:if test="${message == 'logout' }">
				<div style="color:blue;">
					로그아웃 처리되었습니다.
				</div>
			</c:if>
			<c:if test="${message == 'secession' }">
				<div style="color:blue;">
					탈퇴처리 되었습니다.
				</div>
			</c:if>
			<br>
		
			<input type="button" id="btnLogin" value="로그인" class="btn btn-default btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" id="btnJoin" value="회원가입" class="btn btn-default btn-primary"> <br><br>
			
			<a href="#">
				<img src="/images/kakaologin.png" 
				onclick="kakao_login()">
			</a>
			
			<a href="#">
				<br><br>
				<!-- <img src="/images/naverlogin.png"> -->
				<img src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" width="60%" onclick="naver_login()">
			</a>
		</td>
	</tr>
</table>
</form>
	
	<!-- <img src="/images/kakaologin.png" onclick="window.open('https://kauth.kakao.com/oauth/authorize?client_id=4df0a212b67066319be28e560b93c078&redirect_uri=https://localhost/kakaologin&response_type=code','login','width=1024,height=800')"> -->
<!-- onclick="window.open('https://kauth.kakao.com/oauth/authorize?client_id=4df0a212b67066319be28e560b93c078&redirect_uri=https://localhost/kakaologin&response_type=code','login','width=1024,height=800')" -->
</body>
</html>



















