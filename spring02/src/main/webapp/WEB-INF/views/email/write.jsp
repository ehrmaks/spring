<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
</head>
<body>
<%@ include file="../include/admin_menu.jsp" %>
<h2>이메일 보내기</h2>
<form action="${path}/email/send.do" method="post">
	발신자 이름 : <input name="senderName"><br>
	발신자 이메일 : <input name="senderMail"><br>
	수신자 이메일 : <input name="receiveMail"><br>
	제목 : <input name="subject"><br>
	내용 : <textarea rows="5" cols="80" name="message"></textarea>
	<br>
	<input type="submit" value="전송">
</form>
<span style="color: red;">${message}</span>

</body>
</html>