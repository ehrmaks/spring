<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../include/header.jsp"%>
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		$("img[name=rating]").show().fadeOut("slow").slideDown("slow");

	});
</script>

<style type="text/css">
.d-flex p-5 {
	border: 4px dashed #bcbcbc;
}

.thumbnail {
	
}

.description {
	border: 4px dashed #bcbcbc;
	height: 100px;
	text-align: left;
}

.ec-base-box.gHalf:before {
	position: absolute;
	top: 0;
	left: 50%;
	display: block;
	content: "";
	width: 1px;
	height: 100%;
	background-color: #eaeaea;
}

.ec-base-box.gHalf {
	position: relative;
	padding: 0 0;
	border: 10;
	border-color: gray;
	background-color: ivory;
}

.title {
	float: left;
	text-align: left;
	width: 50%;
	box-sizing: border-box;
	font-weight: normal;
	padding: 0 10px 0 10px;
}

.user-data {
	float: left;
	text-align: right;
	width: 50%;
	box-sizing: border-box;
	font-weight: normal;
	padding: 0 10px 0 10px;
}

.xans-myshop-asyncbankbook ul li {
	float: left;
	margin: 5px 0;
	padding: 0 45px;
	width: 50%;
	height: 20px;
	font-size: 12px;
	line-height: 1.6;
	vertical-align: top;
	box-sizing: border-box;
}

.mypoint {
	background-color: blue;
}
</style>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>

	<div class="container" align="center">
		<h2 align="center">마이쇼핑</h2>
		<br> <br>
			<div class="d-flex p-5">
				<p class="thumbnail">
					<img src="/images/rating_${map.rating}.png" style="width: 80%"
						name="rating">
				</p>
				<div class="description">
					<p>
						저희 쇼핑몰을 이용해주셔서 감사합니다. <strong>${map.name}</strong> 님은 [<strong>${map.rating}</strong>]회원이십니다.
					</p>
					<p>
						총 <strong>${map.total_amount}</strong>원을 구매하셨습니다.
					</p>
				</div>
			</div>

			<form name=form1 method="post">
				<div id="wrapper">
					<div
						class="xans-element- xans-myshop xans-myshop-asyncbankbook ec-base-box gHalf">
						<div
							class="xans-element- xans-myshop xans-myshop-asyncbankbook ec-base-box.gHalf:before">
							<ul>
								<li><strong class="title">가용적립금</strong> <strong
									class="user-data"><span>${map.available}원</span>&nbsp; <a href="#"><img
											src="/images/조회.png" name="rating"></a></strong></li>
								<li><strong class="title">총적립금</strong> <strong
									class="user-data"><span>${map.point}원</span>&nbsp; </strong></li>
								<li><strong class="title">사용적립금</strong> <strong
									class="user-data"><span>${map.use_point}원</span>&nbsp; </strong></li>
								<li><strong class="title">예치금</strong> <strong
									class="user-data"><span>0원</span>&nbsp; <a href="#"><img
											src="/images/조회.png" name="rating"></a></strong></li>
								<li><strong class="title">총주문</strong> <strong
									class="user-data"><span>${map.total_amount}원</span>&nbsp;
								</strong></li>
								<li><strong class="title">쿠폰</strong> <strong
									class="user-data"><span>${map.coupon}개</span>&nbsp; <a href="#"><img
											src="/images/조회.png" name="rating"></a></strong></li>
							</ul>
						</div>
					</div>
					</div>
			</form>
			</div>

</body>
</html>