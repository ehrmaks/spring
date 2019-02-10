<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp"%>

<script type="text/javascript">
	function list(page) {
		location.href = "/shop/product/list.do?curPage=" + page;
	}
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2 align="center">상품목록</h2><br><br>
<div class="container">


<table border="1" width="80%" class="table table-hover">
	<tr align="center">
		<th>상품코드</th>
		<th>이미지</th>
		<th>상품명</th>
		<th>가격</th>
	</tr>
	
	<c:forEach var="row" items="${map.list}">
		<tr>
			<td align="center">${row.product_id}</td>
			<td align="center">
				<a href="${path}/shop/product/detail/${row.product_id}">
				<img src="${path}/images/${row.picture_url}"
				width="100px" height="100px"></a>
			</td>
			
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

<table class="container">
	<tr>
		<td colspan="5" align="center" class="page-item">
			<c:if
				test="${map.paper.curBlock > 1}">
				<a href="#" onclick="list('1')">[처음]</a>
			</c:if> 
			<c:if test="${map.paper.curBlock > 1}">
				<a href="#" onclick="list('${map.paper.prevPage}')">[이전]</a>
			</c:if> 
			
			<c:forEach var="num" begin="${map.paper.blockBegin}"
				end="${map.paper.blockEnd}">
				<c:choose>
					<c:when test="${num == map.paper.curPage}">
						<!-- 현재 페이지인 경우 하이퍼링크 제거 -->
						<span style="color: red;">${num}</span>
					</c:when>
					<c:otherwise>
						<a href="#" onclick="list('${num}')">${num}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach> 
			<c:if test="${map.paper.curBlock < map.paper.totBlock}">
				<a href="#" onclick="list('${map.paper.nextPage}')">[다음]</a>
			</c:if> 
			<c:if test="${map.paper.curPage < map.paper.totPage}">
				<a href="#" onclick="list('${map.paper.totPage}')">[끝]</a>
			</c:if>
		</td>
	</tr>
</table>

<form action="/shop/product/list.do" name="form1" method="post">
	<div align="right">
		<select name="search_option" id="search_option">
			<option value="all"
			<c:out value="${map.search_option == 'all'?'selected':''}"></c:out>>모두검색</option>
			<option value="product_name"
			<c:out value="${map.search_option == 'product_name'?'selected':''}"></c:out>>상품이름</option>
			<option value="product_id"
			<c:out value="${map.search_option == 'product_id'?'selected':''}"></c:out>>상품번호</option>
			<option value="product_desc"
			<c:out value="${map.search_option == 'product_desc'?'selected':''}"></c:out>>상품내용</option>
		</select>
		
		<div
			class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
			<div class="input-group">
				<input type="text" class="form-control"
					placeholder="Search for..." aria-label="Search"
					aria-describedby="basic-addon2" name="keyword" id="keyword"
					value="${map.keyword}">
				<div class="input-group-append">
					<button class="btn btn-primary" type="submit">
						<i class="fas fa-search"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
</form>
</div>


</body>
</html>