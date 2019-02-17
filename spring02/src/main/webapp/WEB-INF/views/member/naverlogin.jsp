<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>          
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>LoginTest</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
  <style type="text/css">
  html, div, body,h3{
    margin: 0;
    padding: 0;
  }
  h3{
    display: inline-block;
    padding: 0.6em;
  }
  </style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div style="background-color:#15a181; width: 100%; height: 50px;text-align: center; color: white; ">
<h3>SIST Login</h3></div>
<br>
<!-- 네이버 로그인 화면으로 이동 시키는 URL -->
<!-- 네이버 로그인 화면에서 ID, PW를 올바르게 입력하면 callback 메소드 실행 요청 -->
<input type="hidden" value="${url}" id="url" name="url">
<div id="naver_id_login" style="text-align:center"><a href="#">
<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"></a></div>
<br>

<script type="text/javascript">
$(function() {
	var url = $("#url").val();
	//window.open(url,  '네이버로그인', 'width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes');
	//var url_string = "https://nid.naver.com/nidlogin.login";
	location.href = url;
	
});
</script>
</body>
</html>