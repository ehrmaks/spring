<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>

<script>
	$(function() {
		$("#btnList").click(function() {
			// 장바구니 목록으로 이동
			location.href="${path}/shop/product/list.do";
		});
		
		$("#btnDelete").click(function() {
			if(confirm("장바구니를 비우시겠습니까?")) {
				location.href="${path}/shop/cart/deleteAll.do";
			}
		});
	});
</script>

</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2>장바구니</h2>
	<c:choose>
		<c:when test="${map.count == 0}">
			장바구니가 비었습니다.
		</c:when>
		<c:otherwise>
			<form action="${path}/shop/cart/update.do"
			name="form1" method="post">
				<table border="1" width="800px">
					<tr>
						<th>상품명</th>
						<th>이미지</th>
						<th>단가</th>
						<th>수량</th>
						<th>금액</th>
						<th>&nbsp;</th>
					</tr>
					
					<c:forEach var="row" items="${map.list}">
						<tr align="center">
							<td>${row.product_name}</td>
							<td><img src="${path}/images/${row.picture_url}"
							width="100px" height="100px"></td>
							<td><fmt:formatNumber value="${row.product_price}"
							pattern="###,###,###"></fmt:formatNumber></td>
							<td align="center" width="1px"><input type="number" name="amount"
							value="${row.amount}">
							<input type="hidden" name="cart_id"
							value="${row.cart_id}"></td>
							
							<td><fmt:formatNumber value="${row.money}"
							pattern="###,###,###"></fmt:formatNumber></td>
							<td>
								<c:if test="${sessionScope.userid != null}">
									<a href="${path}/shop/cart/delete.do?cart_id=${row.cart_id}">삭제</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="5" align="right">
							장바구니 금액 합계 : <fmt:formatNumber value="${map.sumMoney}"
							pattern="###,###,###"></fmt:formatNumber><br>
							배송료 : <fmt:formatNumber value="${map.fee}"
							pattern="###,###,###"></fmt:formatNumber><br>
							총합계 : <fmt:formatNumber value="${map.sum}"
							pattern="###,###,###"></fmt:formatNumber> 
						</td>
					</tr>
				</table>
				
				<button id="btnUpdate">수정</button>
				<button id="btnDelete" type="button"> 장바구니 비우기</button>
			</form>
		</c:otherwise>
	</c:choose>
	<button type="button" id="btnList">상품목록</button>

</body>
</html>