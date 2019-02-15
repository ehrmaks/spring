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
			/* document.form1.action="${path}/shop/product/list.do";
			document.form1.submit(); */
		});
		
		$("#btnDelete").click(function() {
			if(confirm("장바구니를 비우시겠습니까?")) {
				//location.href="${path}/shop/cart/deleteAll.do";
				document.form1.action="${path}/shop/cart/deleteAll.do";
				document.form1.submit();
			}
		});
		
		$("#btnUpdate").click(function() {
			document.form1.action="${path}/shop/cart/update.do";
			document.form1.submit();
		});
		
		$("#btnBuy").click(function() {
			document.form1.action="${path}/shop/cart/order.do";
			document.form1.submit();
		});
		
		$("input[name=amount]").keyup(function() {
			var targetArr = new Array();
			var obj = new Object();
			
			var cart_id = $("[name=cart_id]").map(function() {
				return this.value}).get();
			var amount = $("[name=amount]").map(function() {
				return this.value}).get();
			
			obj.cart_id = cart_id;
			obj.amount = amount;
			
			targetArr.push(obj);
			var param = JSON.stringify(targetArr);
			
			$.ajax({
				async : true,
				type : "post",
				url : "/shop/cart/update",
				data : param,
				dataType : "json",
				contentType : "application/json; charset=UTF-8",
				success : function(data) {
					var list = data.list;
					var count = data.count;
					var fee = data.fee;
					var sum = data.sum;
					var sumMoney = data.sumMoney;
					var cart_id = data.cart_id;
					var amount = data.amount;
					var html = "";
					
					html += '<td align="center"><input type="number" value='+amount+'>';
					html += '<input type="hidden" value='+cart_id+'></td>';
					
					html2 = '';
					html2 += '장바구니 금액 합계 : '+sumMoney+'<br>';
					html2 += '배송료 : '+fee+'<br>';
					html2 += '총합계 : '+sum+'';
					
					$("[name=amount]").html(html);
					$("[name=sum]").html(html2);
				}, error : function(data) {
					console.log(data);
				}
			});
		});
	});
</script>

<style type="text/css">
	#cart {
		overflow: scroll;
	}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2 align="center">장바구니</h2><br><br>
<div class="container" id="cart" style="font-size: 80%;">
	<c:choose>
		<c:when test="${map.count == 0}">
			<h5 align="left">장바구니가 비었습니다.</h5>
		</c:when>
		<c:otherwise>
			<form name="form1" method="post">
				<input type="hidden" value="${map.sumMoney}" name="sumMoney">
				<input type="hidden" value="${map.fee}" name="fee">
				<table border="1" class="table table-hover" name="table1">
					<tr align="center">
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
							<td><a href="/shop/product/detail/${row.product_id}"><img src="${path}/images/${row.picture_url}" width="50px"></a></td>
							<td><fmt:formatNumber value="${row.product_price}"
							pattern="###,###,###"></fmt:formatNumber></td>
							<td align="center"><input type="number" name="amount" id="amount"
							value="${row.amount}">
							<input type="hidden" name="cart_id" id="cart_id"
							value="${row.cart_id}"></td>
							<td name="money"><fmt:formatNumber value="${row.money}"
							pattern="###,###,###"></fmt:formatNumber></td>
							<td>
								<c:if test="${sessionScope.userid != null}">
									<a href="${path}/shop/cart/delete.do?cart_id=${row.cart_id}">삭제</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="5" align="right" name="sum">
							장바구니 금액 합계 : <fmt:formatNumber value="${map.sumMoney}"
							pattern="###,###,###"></fmt:formatNumber><br>
							배송료 : <fmt:formatNumber value="${map.fee}"
							pattern="###,###,###"></fmt:formatNumber><br>
							총합계 : <fmt:formatNumber value="${map.sum}"
							pattern="###,###,###"></fmt:formatNumber> 
						</td>
					</tr>
				</table>
				
				
					<button id="btnUpdate" class="btn btn-warning">적용</button>
					<button id="btnDelete" type="button" class="btn btn-default btn-danger"> 장바구니 비우기</button>
					<div align="right">
						<button id="btnBuy" type="button" class="btn btn-default btn-info">주문서 작성</button>
					</div><br>
			</form>
		</c:otherwise>
	</c:choose>
		<div align="right">
			<button type="button" id="btnList" class="btn btn-default btn-info">상품목록</button>
		</div>
	</div>
	

</body>
</html>