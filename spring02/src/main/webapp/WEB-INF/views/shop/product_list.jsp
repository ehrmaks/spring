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
<%@ include file="../include/menu.jsp" %>
<h2>상품목록</h2>
<table border="1" width="500px">
	<tr>
		<th>상품코드</th>
		<th>이미지</th>
		<th>상품명</th>
		<th>가격</th>
	</tr>
	
	<c:forEach var="row" items="${list}">
		<tr>
			<td align="center">${row.product_id}</td>
			<td align="center"><img src="${path}/images/${row.picture_url}"
			width="100px" height="100px"></td>
			
			<td align="center">
				<a href="${path}/shop/product/detail/${row.product_id}">
				${row.product_name}</a>
				<!-- 관리자에게만 편집 버튼표시 -->
				<c:if test="${sessionScope.admin_userid != null}">
					<br>
					<a href="${path}/shop/product/edit/${row.product_id}">
					[편집]</a>
				</c:if>
			</td>
			
			<td align="center"><fmt:formatNumber value="${row.product_price}"
			pattern="###,###,###"/></td>
		</tr>
	</c:forEach>
</table>

</body>
</html>