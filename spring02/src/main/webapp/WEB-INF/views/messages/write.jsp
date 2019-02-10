<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>

<script>
$(document).ready(function() {
	$("#btnSend").click(function() {
		if(confirm("전송하시겠습니까?")){
			insert();
		}
	});
	
	
});

function insert() {
	var targetid = $("#targetid").val();
	var sender = $("#sender").val();
	var message = $("#message").val();
	console.log(targetid);
	
	$.ajax({
		type: "post",
		url: "/messages/send.do",
		headers: {
			"Content-Type" : "application/json"
		},
		dataType: "text",
		data: JSON.stringify({
			targetid : targetid,
			sender : sender,
			message : message
        }),
        success: function() {
			alert("전송 성공!!");
		},
		error: function(e) {
			console.log(e);
			alert("실패");
		}
	});
}
</script>

</head>
<body>
<%@ include file="../include/admin_menu.jsp" %>

<h2> 메시지 보내기 </h2>
	타겟ID : <input type="text" id="targetid" name="targetid"><br>
	보낸이 : <input type="text" id="sender" name="sender"><br>
	메시지 : <input type="text" id="message" name="message"><br>
	<button type="button" id="btnSend">전송</button>
<span style="color: red;">${message}</span>

</body>
</html>