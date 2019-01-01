<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header2.jsp" %>
<script>
//3. 댓글 수정
$("#btnReplyUpdate").click(function(){
    var detailReplytext = $("#detailReplytext").val();
    $.ajax({
        type: "put",
        url: "${path}/reply/update/${dto.rno}",
        // 기본값 text/html을 json으로 변경
        headers: {
            "Content-Type":"application/json"
        },
        // 데이터를 json형태로 변환
        data: JSON.stringify({
            replytext : detailReplytext
        }),
        dataType: "text",
        success: function(result){
            if(result == "success"){
                $("#modifyReply").css("visibility", "hidden");
                // 댓글 목록 갱신
                listReplyRest("1");
            }
        }
    });
});
	
	// 4. 댓글 상세화면 닫기
	$("#btnReplyClose").click(function() {
		$("#modifyReply").css("visibility", "hidden");
	});
	
	// 5. 댓글 삭제
	$("#btnReplyDelete").click(function() {
		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				type: "delete",
				url: "${path}/reply/delete/${dto.rno}",
				success: function(result) {
					alert("삭제되었습니다.");
					$("#modifyReply").css("visibility","hidden");
					listReplyRest("1");
				}
			});
		}
	});

</script>

</head>
<body>
<%@ include file="../include/menu2.jsp" %>
<div style="color: blue; font-size: 20px; font-style: italic;">댓글 번호 : ${dto.rno}<br></div>
<div align="center">
<textarea id="detailReplytext" rows="3" cols="50" id="detail"><c:if test="${dto.secret_reply == 'y'}"><c:if test="${!sessionScope.userid==dto.writer && !sessionScope.userid==dto.replyer}">비밀 댓글입니다.</c:if>
<c:if test="${sessionScope.userid==dto.writer || sessionScope.userid==dto.replyer || sessionScope.userid=='admin'}">${dto.replytext}</c:if></c:if>
<c:if test="${dto.secret_reply == 'n'}">${dto.replytext}</c:if></textarea>
</div>
<div style="text-align: center;" align="center">
	<!-- 본인 댓글/관리자만 수정, 삭제가 가능하도록 처리 -->
	<c:if test="${sessionScope.userid == dto.replyer || sessionScope.userid == 'admin'}">
		<button type="button" id="btnReplyUpdate" class="btn btn-default btn-warning">수정</button>
		<button type="button" id="btnReplyDelete" class="btn btn-default btn-danger">삭제</button>
	</c:if>
	<button type="button" id="btnReplyClose" class="btn btn-default btn-primary">닫기</button>
</div>

</body>
</html>