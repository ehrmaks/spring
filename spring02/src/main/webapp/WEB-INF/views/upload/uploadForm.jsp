<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- views/upload/uploadForm.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
	<style>
	iframe {
		width: 500px;
		height: 100px;
		border: 1px;
		border-style: solid;
	}
	</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

<!-- 파일 업로드를 위한 필수 속성
enctype="multipart/form-data" -->

	<form action="/upload/uploadForm"
	method="post" enctype="multipart/form-data" target="iframe1" >
		<input type="file" name="file">
		<input type="submit" value="업로드">
	</form>
	<!-- iframe에 업로드 결과 출력 -->
	<iframe name="iframe1"></iframe>

	<script>
	function addFilePath(msg) {
		console.log(msg); // 파일명 콘솔 출력
		document.getElementById("form1").reset(); 
		// iframe에 업로드결과를 출력 후 form에 저장된 데이터 초기화
	}
	</script>

</body>

</html>



















