<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
#chatdata {
	border: solid;
	overFlow: scroll;
	max-height: 400px;
	/* //width: 80%; */
}
</style>

<%@ include file="../include/header.jsp"%>

<!-- SocketJS CDN -->
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>

<title>Chatting page</title>
</head>



<body>
	<%@ include file="../include/menu.jsp"%>
	<table class="container-fluid" style="width: 80%; border: solid;">
		<tr>
			<td>
				<div>
					<h3>Chatting Page (id: ${userid})</h3>
				</div>
				<hr>
				<div>
					<div class="well" id="chatdata">
						<!-- User Session Info Hidden -->
						<input type="hidden" value='${userid}' id="sessionuserid">
						<input type="hidden" value='${name}' id="sessionname">
					</div>
					<br>
					<div>
						<input type="text" id="message" style="size: 80%;" /> 
						<input type="button" id="sendBtn" value="전송" />
					</div>

				</div>
			</td>
		</tr>
	</table>

</body>

<script type="text/javascript">

//websocket을 지정한 URL로 연결
var sock= new SockJS("<c:url value="/echo"/>");
sock.onopen = onOpen;
//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
sock.onmessage = onMessage;
//websocket 과 연결을 끊고 싶을때 실행하는 메소드
sock.onclose = onClose;
$(function(){
	$("#message").focus();
	
	$("#sendBtn").click(function(){
		console.log('send message...');
        sendMessage();
        $('#message').val('');
        $("#message").focus();
    });
	
	$("#message").keypress(function() {
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if(keycode == '13') {
			console.log('send message...');
			sendMessage();
			$('#message').val('');
			$("#message").focus();
		}
	});
});

function onOpen(evt) {
	$("#chatdata").append("연결 됨.");
}
        
function sendMessage(){      
	//websocket으로 메시지를 보내겠다.
  	sock.send($("#message").val());     
}
            
//evt 파라미터는 websocket이 보내준 데이터다.
function onMessage(evt){  //변수 안에 function자체를 넣음.
	var data = evt.data;
	var sessionName = null;
	var message = null;
	var sessionId = null;
	
	
	console.log("data : " + data);
	//문자열을 splite//
	var strArray = data.split(':');
	
	for(var i=0; i<strArray.length; i++){
		console.log('str['+i+']: ' + strArray[i]);
	}
	
	//current session id//
	var currentuser_session = $('#sessionuserid').val();
	var currentuser_name = $('#sessionname').val();
	console.log('current session id: ' + currentuser_session);
	console.log('current session name: ' + currentuser_name);
	
	sessionName = strArray[0]; //현재 메세지를 보낸 사람의 세션 등록//
	console.log("sessionName : " + sessionName);
	message = strArray[1]; //현재 메세지를 저장//
	console.log("message : " + message);
	sessionId = strArray[2];
	console.log("sessionId : " + sessionId);
	
	//나와 상대방이 보낸 메세지를 구분하여 영역을 나눈다.//
	if(sessionId == currentuser_session){
		var printHTML = "<div class='well'>";
		printHTML += "<div class='alert alert-info'>";
		printHTML += "<strong>["+sessionName+"] -> "+message+"</strong>";
		printHTML += "</div>";
		printHTML += "</div>";
		
		$("#chatdata").append(printHTML);
	} else{
		var printHTML = "<div class='well'>";
		printHTML += "<div class='alert alert-warning'>";
		printHTML += "<strong>["+sessionName+"] -> "+message+"</strong>";
		printHTML += "</div>";
		printHTML += "</div>";
		
		$("#chatdata").append(printHTML);
	}
	
	$("#chatdata").scrollTop($("#chatdata")[0].scrollHeight);
	
	console.log('chatting data: ' + data);
	
  	/* sock.close(); */
}
    
function onClose(evt){
	$("#chatdata").append("연결 끊김");
}    
</script>
</html>