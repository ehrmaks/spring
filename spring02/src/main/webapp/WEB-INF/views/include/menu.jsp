<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- views/include/menu.jsp -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin - Dashboard</title>

<!-- Bootstrap core CSS-->
<link href="/resources/sbadmin/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template-->
<link href="/resources/sbadmin/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">

<!-- Page level plugin CSS-->
<link
	href="/resources/sbadmin/vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/resources/sbadmin/css/sb-admin.css" rel="stylesheet">

</head>

<body id="page-top">

	<nav class="navbar navbar-expand navbar-dark bg-dark static-top">

		<a class="navbar-brand mr-1" href="/">Portfolio</a>

		<button class="btn btn-link btn-sm text-white order-1 order-sm-0"
			id="sidebarToggle" href="#">
			<i class="fas fa-bars"></i>
		</button>

		<!-- Navbar Search -->
		<form
			class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="Search for..."
					aria-label="Search" aria-describedby="basic-addon2">
				<div class="input-group-append">
					<button class="btn btn-primary" type="button">
						<i class="fas fa-search"></i>
					</button>
				</div>
			</div>
		</form>

		<!-- Navbar -->
		<ul class="navbar-nav ml-auto ml-md-0">
			<li class="nav-item dropdown no-arrow mx-1"><a
				class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <span
					class="badge badge-danger">9+</span>
			</a>
				<div class="dropdown-menu dropdown-menu-right"
					aria-labelledby="alertsDropdown">
					<a class="dropdown-item" href="#">Action</a> <a
						class="dropdown-item" href="#">Another action</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">Something else here</a>
				</div></li>
			<li class="nav-item dropdown no-arrow mx-1"><a
				class="nav-link dropdown-toggle" href="#" id="messagesDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-envelope fa-fw"></i> <span
					class="badge badge-danger">7</span>
			</a>
				<div class="dropdown-menu dropdown-menu-right"
					aria-labelledby="messagesDropdown">
					<a class="dropdown-item" href="#">Action</a> <a
						class="dropdown-item" href="#">Another action</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">Something else here</a>
				</div></li>
			<li class="nav-item dropdown no-arrow"><a
				class="nav-link dropdown-toggle" href="#" id="userDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-user-circle fa-fw"></i>
			</a>
				<div class="dropdown-menu dropdown-menu-right"
					aria-labelledby="userDropdown">
					<c:choose>
						<c:when test="${sessionScope.userid == null }">
							<!-- 로그인하지 않은 상태 -->
							<a class="dropdown-item" href="/member/join.do">Register</a>
							<a class="dropdown-item" href="/member/login.do">login</a>
							<a class="dropdown-item" href="/admin/login.do">admin login</a>
						</c:when>

						<c:otherwise>
							<c:if test="${sessionScope.userid != 'admin' }">
								<a class="dropdown-item" href="#">${sessionScope.name}님</a>
								<a class="dropdown-item"
									href="/member/${sessionScope.userid}/form">회원정보수정</a>
							</c:if>


							<c:if test="${sessionScope.userid == 'admin' }">
								<a class="dropdown-item" href="#">${sessionScope.name}님</a>
								<a class="dropdown-item"
									href="/admin/${sessionScope.admin_userid}/form">회원정보수정</a>
							</c:if>

							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="/member/logout.do"
								data-toggle="modal" data-target="#logoutModal">Logout</a>

						</c:otherwise>
					</c:choose>
				</div></li>
		</ul>
	</nav>



	<div id="wrapper">
		<!-- Sidebar -->
		<ul class="sidebar navbar-nav">
			<li class="nav-item active"><a class="nav-link" href="/"> <i
					class="fas fa-fw fa-tachometer-alt"></i> <span>Home</span>
			</a></li>
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-fw fa-folder"></i> <span>Menu</span>
			</a>
				<div class="dropdown-menu" aria-labelledby="pagesDropdown">
					<h6 class="dropdown-header">Test Menu:</h6>
					<a class="dropdown-item" href="/upload/uploadForm">Upload Test</a>
					<a class="dropdown-item" href="/upload/uploadAjax">Upload(Ajax)
						Test</a> <a class="dropdown-item" href="/chatting.do">Websocket
						Test</a>

					<c:if test="${sessionScope.admin_userid != null}">
						<a class="dropdown-item" href="/messages/write.do">Message
							Test</a>
					</c:if>


					<div class="dropdown-divider"></div>

					<!-- <h6 class="dropdown-header">Other Pages:</h6>
            <a class="dropdown-item" href="/resources/sbadmin/404.html">404 Page</a>
            <a class="dropdown-item" href="/resources/sbadmin/blank.html">Blank Page</a> -->
				</div></li>


			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-fw fa-table"></i> <span>고객문의</span>
			</a>

				<div class="dropdown-menu" aria-labelledby="pagesDropdown">
					<h6 class="dropdown-header">Board Menu:</h6>
					<a class="dropdown-item" href="#">공지사항</a> <a class="dropdown-item"
						href="/board/list.do">상품문의</a>
				</div></li>

			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-fw fa-table"></i> <span>Shop</span>
			</a>

				<div class="dropdown-menu" aria-labelledby="pagesDropdown">
					<h6 class="dropdown-header">Shop Menu:</h6>
					<a class="dropdown-item" href="/shop/product/list.do">상품목록</a>
					<c:if test="${sessionScope.userid != null}">
						<a class="dropdown-item" href="/shop/cart/list.do">장바구니</a>
					</c:if>

					<c:if test="${sessionScope.admin_userid != null}">
						<div class="dropdown-divider"></div>
						<h6 class="dropdown-header">Admin Pages:</h6>
						<a class="dropdown-item" href="/shop/product/write.do">상품등록</a>
					</c:if>
				</div></li>

			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="pagesDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-fw fa-table"></i> 
				<span>My Page</span>
			</a>

				<div class="dropdown-menu" aria-labelledby="pagesDropdown">
					<h6 class="dropdown-header">My Menu:</h6>
					<c:choose>
						<c:when test="${sessionScope.userid == null }">
							<!-- 로그인하지 않은 상태 -->
							<a class="dropdown-item" href="/member/join.do">Register</a>
							<a class="dropdown-item" href="/member/login.do">login</a>
							<a class="dropdown-item" href="/admin/login.do">admin login</a>
						</c:when>

						<c:otherwise>
							<c:if test="${sessionScope.userid != 'admin' }">
								<a class="dropdown-item" href="#">${sessionScope.name}님</a>
								<a class="dropdown-item"
									href="/member/${sessionScope.userid}/form">회원정보수정</a>
							</c:if>


							<c:if test="${sessionScope.userid == 'admin' }">
								<a class="dropdown-item" href="#">${sessionScope.name}님</a>
								<a class="dropdown-item"
									href="/admin/${sessionScope.admin_userid}/form">회원정보수정</a>
							</c:if>

							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="/member/logout.do"
								data-toggle="modal" data-target="#logoutModal">Logout</a>

							<script type="text/javascript" charset="utf-8"
								src="/include/js/timeoutchk.js"></script>
							<a class="dropdown-item" href="#">Session:<span id="timer"></span></a>
							<a class="dropdown-item" href="javascript:refreshTimer();">Session Time 연장</a>
						</c:otherwise>
					</c:choose>
				</div></li>

			<c:if test="${sessionScope.admin_userid != null}">
				<li class="nav-item active"><a class="nav-link"
					href="/admin/adminhome.do"> <i
						class="fas fa-fw fa-tachometer-alt"></i> <span>Admin Home</span>
				</a></li>
			</c:if>
		</ul>



		<div id="content-wrapper">
			<div class="container-fluid">
				<footer class="sticky-footer">
					<div class="container my-auto">
						<div class="copyright text-center my-auto">
							<span>Copyright © Your Website 2019</span>
						</div>
					</div>
				</footer>
			</div>


			<!-- Scroll to Top Button-->
			<a class="scroll-to-top rounded" href="#page-top"> <i
				class="fas fa-angle-up"></i>
			</a>

			<!-- Logout Modal-->
			<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">Ready to
								Leave?</h5>
							<button class="close" type="button" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">Select "Logout" below if you are
							ready to end your current session.</div>
						<div class="modal-footer">
							<button class="btn btn-secondary" type="button"
								data-dismiss="modal">Cancel</button>
							<a class="btn btn-primary" href="/member/logout.do">Logout</a>
						</div>
					</div>
				</div>
			</div>

			<!-- Bootstrap core JavaScript-->
			<script src="/resources/sbadmin/vendor/jquery/jquery.min.js"></script>
			<script
				src="/resources/sbadmin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

			<!-- Core plugin JavaScript-->
			<script
				src="/resources/sbadmin/vendor/jquery-easing/jquery.easing.min.js"></script>

			<!-- Page level plugin JavaScript-->
			<script src="/resources/sbadmin/vendor/chart.js/Chart.min.js"></script>
			<script
				src="/resources/sbadmin/vendor/datatables/jquery.dataTables.js"></script>
			<script
				src="/resources/sbadmin/vendor/datatables/dataTables.bootstrap4.js"></script>

			<!-- Custom scripts for all pages-->
			<script src="/resources/sbadmin/js/sb-admin.min.js"></script>

			<!-- Demo scripts for this page-->
			<script src="/resources/sbadmin/js/demo/datatables-demo.js"></script>
			<script src="/resources/sbadmin/js/demo/chart-area-demo.js"></script>
</body>

</html>
