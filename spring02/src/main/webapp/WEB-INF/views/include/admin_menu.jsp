<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- views/include/admin_menu.jsp -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title> Admin Region </title>

    <!-- Bootstrap core CSS -->
    <link href="${path}/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:500,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Muli:400,400i,800,800i" rel="stylesheet">
    <link href="${path}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${path}/resources/css/resume.min.css" rel="stylesheet">
	<link rel="stylesheet" href="${path}/resources/include/style.css">
  </head>

  <body id="page-top">

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top" id="sideNav">
      <a class="navbar-brand js-scroll-trigger" href="/">
        <span class="d-block d-lg-none">Spring Project</span>
        <span class="d-none d-lg-block">
          <img class="img-fluid img-profile rounded-circle mx-auto mb-2" src="${path}/resources/img/profile.jpg" alt="">
        </span>
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="${path}/shop/product/list.do">상품목록</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="${path}/shop/product/write.do">상품등록</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="${path}/email/write.do">이메일 발송</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/admin/admin.do">관리자 홈</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/">Home</a>
          </li> 
        </ul>
      </div>
    </nav>
    

<div style="text-align: right;">
	<c:choose>
		<c:when test="${sessionScope.admin_userid == null}">
			<!-- 로그인 하지 않은 상태 -->
			<a href="/member/login.do">로그인</a> | 
			<a href="/admin/login.do">관리자 로그인</a>
		</c:when>
		
		<c:otherwise>
			<!-- 로그인 상태 -->
			관리자 : ${sessionScope.admin_name}님이 로그인중입니다.
			<a href="/admin/logout.do">로그아웃</a>
		</c:otherwise>
	</c:choose>
</div>
<hr>

    <!-- Bootstrap core JavaScript -->
    <script src="${path}/resources/vendor/jquery/jquery.min.js"></script>
    <script src="${path}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="${path}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for this template -->
    <script src="${path}/resources/js/resume.min.js"></script>

  </body>

</html>






<!-- -------------------------------- -->
<%-- <a href="${path}/shop/product/list.do">상품목록</a> |
<a href="${path}/shop/product/write.do">상품등록</a> |
<a href="${path}/pdf/list.do">PDF</a> |
<a href="${path}/chart/chart1.do">구글차트(json)</a> |
<a href="${path}/chart/chart2.do">구글차트(db)</a> |
<a href="${path}/jchart/chart1.do">JFreeChart(png)</a> |
<a href="${path}/jchart/chart2.do">JFreeChart(pdf)</a> |
<a href="${path}/email/write.do">이메일 발송</a> |
<a href="/admin/admin.do">관리자 홈</a> |
<a href="/">Home</a> | --%>


    