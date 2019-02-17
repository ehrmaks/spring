<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript"
  src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
  charset="utf-8"></script>
<!-- <script type="text/javascript"
  src="http://code.jquery.com/jquery-1.11.3.min.js"></script> -->
  
<style type="text/css">
html, div, body, h3 {
  margin: 0;
  padding: 0;
}

h3 {
  display: inline-block;
  padding: 0.6em;
}
</style>
<script type="text/javascript">
$(function() {
	var name = ${result}.response.name;
	var email = ${result}.response.email;
	var userid = "naver" + ${result}.response.id;
	/* $("#name").html("환영합니다. "+name+"님");
	$("#email").html(email);
	$("#userid").html(userid); */
	
	$("#naverlogin").click(function() {
		document.getElementById("name").value = name;
		document.getElementById("email").value = email;
		document.getElementById("userid").value = userid;
		
		document.form1.action = "/insert_naver";
		document.form1.submit();
	});
});
  /* location.href = "${pageContext.request.contextPath}/"; */
</script>

</head>
<body>
<%@ include file="../include/menu.jsp" %>
  <div
    style="background-color: #15a181; width: 100%; height: 50px; text-align: center; color: white;">
    <h3>Naver_Login Success</h3>
  </div>
  <br>
 <!--  <h2 style="text-align: center" id="name"></h2>
  <h4 style="text-align: center" id="email"></h4>
  <h4 style="text-align: center" id="userid"></h4> -->
  <div class="container" align="center" style="width: 100%; overflow: scroll;">
  	<form name="form1" method="post">
  		<c:if test="${sessionScope.userid == null}">
  			<input type="button" value="추가정보기입하러가기" class="btn btn-info" id="naverlogin">
  			<input type="hidden" id="name" name="name">
  			<input type="hidden" id="email" name="email">
  			<input type="hidden" id="userid" name="userid">
  		</c:if>
  	</form>
  </div>
  <script>
    $(function () {
        $("body").hide();
        $("body").fadeIn(1000);  
     
        /* setTimeout(function(){$("body").fadeOut(1000);},1000);// 1초 뒤에 사라 지자 
        setTimeout(function(){location.href= "${pageContext.request.contextPath}/"},2000);
		// 2초 뒤에 메인 화면 으로 가자   */
    	
    });
  </script>

</body>
</html>