<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- views/member/login.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script>
$(function(){
	$("#btnLogin").click(function(){
		var userid=$("#userid").val(); //태그의 value 속성값
		var passwd=$("#passwd").val();
		if(userid==""){
			//alert("아이디를 입력하세요.");
			$("#userid").focus(); //입력 포커스 이동
			return; //함수 종료
		}
		if(passwd==""){
			//alert("비밀번호를 입력하세요.");
			$("#passwd").focus();
			return;
		}
		if(userid!="admin") {
			alert("관리자 아이디가 아닙니다.")
			$("#userid").focus();
			return;
		}
		//폼 데이터를 서버로 제출
		document.form1.action="${path}/admin/login_check.do";
		document.form1.submit();
	});
});

$(function() {
	$("#btnjoin").click(function() {
		document.form1.action="${path}/admin/join.do";
		document.form1.submit();
	});
});
</script>
</head>
<body>
<%@ include file="../include/admin_menu.jsp" %>
<!-- <br><br><br><br><br><br><br><br><br> -->
<h2 class="text-center">Please sign in</h2><br>
<form name="form1" method="post">
<table class="container-fluid" style="width: 350px;">
	<tr>
		<!-- <td>아이디</td> -->
		<td><input name="userid" id="userid" class="form-control" placeholder="Admin ID"><br></td>
	</tr>
	<tr>
		<!-- <td>비밀번호</td> -->
		<td><input type="password" name="passwd" id="passwd" class="form-control" placeholder="Password"><br></td>
	</tr>
	<tr>
		<td align="center">
			<c:if test="${param.message == 'nologin' }">
				<div style="color:red;">
					로그인 하신 후 사용가능합니다.
				</div>				
			</c:if>
			<c:if test="${message == 'error' }">
				<div id="div1" style="color:red;">
					아이디 또는 비밀번호가 일치하지 않습니다.
				</div>
			</c:if>
			<c:if test="${message == 'logout' }">
				<div style="color:blue;">
					로그아웃 처리되었습니다.
				</div>
			</c:if>
			<br>
			
			<input type="button" id="btnLogin" class="btn btn-default btn-primary" value="로그인">&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" id="btnjoin" class="btn btn-default btn-primary" value="회원가입">
		</td>
	</tr>
</table>
</form>
</body>
</html>



















