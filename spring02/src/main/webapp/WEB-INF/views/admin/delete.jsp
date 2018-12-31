<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
</head>

<script>
	$(function() {
		$("#btnConfirm").click(function() {
			var passwd = $("#passwd").val();
			var passwd_check = $("#passwd_check").val();
			var userid = $("#userid2").val();
			console.log("userid" + userid);
			if(passwd_check == "") {
				alert("암호를 입력하세요.");
				$("#passwd_check").focus();
				return;
			}
			
			var con = confirm("정말로 탈퇴하시겠습니까?");
			if(con == true) {
				document.form1.action = "${path}/admin/secession.do";
				document.form1.submit();
			} else {
				alert("이전페이지로 이동");
				history.back();
			}
			
		});
		
	});
</script>

<body>
<%@ include file="../include/admin_menu.jsp" %>

	<form name="form1" method="post">
		<table class="table table-hover">
			<tr>
				<td>아이디</td>
				<td><input id="userid" name="userid" value="${dto.userid}" readonly="readonly">
					<input type="hidden" id="userid2" value="${sessionScope.admin_userid}">
				</td>
				
			</tr>
			
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="passwd_check" id="passwd_check">
					<div id="div1"></div>
				</td>
			</tr>
			
			<tr>
				<td>
					<input type="hidden" name="passwd" id="passwd" value="${dto.passwd}">
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="탈퇴" id="btnConfirm" class="btn btn-default btn-primary">
				</td>
			</tr>
		</table>
		
		
	</form>

</body>
</html>