<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script>
$(function(){
	$("#btnWrite").click(function(){
		location.href="/board/write.do";
	});
	
	$("#keyword").keyup(function() {
		var arr = new Array(); // Object를 배열로 저장할 배열
		var obj = new Object(); // key, value 형태로 저장할 오브젝트
		var keyword = $("#keyword").val();
		var search_option = $("#search_option").val();
		var curPage = 1;
		
		console.log("keyword : " + keyword);
		console.log("search_option : " + search_option);
		console.log("curPage : " + curPage);
		
		obj.keyword = keyword;
		obj.search_option = search_option;
		obj.curPage = curPage;
		arr.push(obj);
		
		$.ajax({
			async: true, // 비동기 통신 default는 true이다
			type: "post",
			url: "/board/search",
			data: JSON.stringify(arr), // 배열을 json string형태로 변환
			dataType: "json",
			contentType: "application/json; charset=UTF-8",
			success: function(data) {
				$("#count").html(data.count + "개의 게시물이 있습니다.").css("color", "orange");
				
				var date = new Date();
				var list = data.list;
				var html = "";
				var html2 = "";
				
				html += '<tr>';
				html += '<td>번호</td>';
				html += '<td>제목</td>';
				html += '<td>이름</td>';
				html += '<td>날짜</td>';
				html += '<td>조회수</td>';
				for(var i=0; i<list.length; i++){
					var regdate = list[i].regdate;
					console.log("typeof : " + typeof(regdate));
					
					html += '<tr>';
					html += '<td>'+list[i].bno+'</td>';
					html += '<td><a href="/board/view.do?bno='+list[i].bno+'">'+list[i].title+'</a>';
					if(list[i].cnt > 0) {
						html += '<span style="color:red;">( '+list[i].cnt+' )</span>';
					}
					html += '</td>';
					
					html += '<td>'+list[i].user_name+'</td>';
					html += '<td>'+regdate+'</td>';
					html += '<td>'+list[i].viewcnt+'</td>';
					html += '</tr>';
				}
				html += '</tr>';
				
				html2 += '<tr>';
				html2 += '<td colspan="5" align="center" class="page-item">';
				if(data.pager.curBlock >= 1) {
					var j = 1;
					html2 += '<a href="#" onclick="list('+j+')">[처음]</a>';
				}
				if(data.pager.curBlock >= 1) {
					html2 += '<a href="#" onclick="list('+data.pager.prevPage+')">[이전]</a>&nbsp;&nbsp;';
				}
				
				for(var num=data.pager.blockBegin; num<=data.pager.blockEnd; num++) {
					if(num == data.pager.curPage) {
						html2 += '<span style="color:red;">'+num+'</span>&nbsp;&nbsp;';
					} else {
						html2 += '<a href="#" onclick="list('+num+')">'+num+'</a>&nbsp;&nbsp;';
					}
				}
				
				if(data.pager.curBlock <= data.pager.totBlock) {
					html2 += '<a href="#" onclick="list('+data.pager.nextPage+')">[다음]</a>';
				}
				
				if(data.pager.curPage <= data.pager.totPage) {
					html2 += '<a href="#" onclick="list('+data.pager.totPage+')">[끝]</a>';
				}
				
				html2 += '<div class="container">';
				html2 += '<button type="button" id="btnWrite" class="btn btn-primary float-right">글쓰기</button>';
				html2 += '</div>';
				html2 += '</td>';
				html2 += '</tr>';
				
				$("#table1").html(html);
				$("#table2").html(html2);
			
			}, error: function(e) {
				console.log(e);
				alert("실패");
			}
		});
	});
});
function list(page){
	location.href="/board/list.do?curPage="+page;
}

</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2 align="center">게시판</h2>

<!-- 검색폼 -->
<form name="form1" method="post"
	action="/board/list.do">
	<div align="right">
	<select name="search_option" id="search_option">
		<option value="all" <c:out value="${map.search_option == 'all'?'selected':''}"/> >제목+이름+제목</option>
        <option value="user_name" <c:out value="${map.search_option == 'user_name'?'selected':''}"/> >이름</option>
        <option value="content" <c:out value="${map.search_option == 'content'?'selected':''}"/> >내용</option>
        <option value="title" <c:out value="${map.search_option == 'title'?'selected':''}"/> >제목</option>
	</select>
	
	<input name="keyword" id="keyword" value="${map.keyword}">
	<input type="submit" value="조회" class="btn btn-primary float-right">
	
	</div>
	<div id="count" align="right">
		${map.count}개의 게시물이 있습니다.
	</div>
	<div align="right">
	
	</div>
</form>
<!-- table-striped table-bordered  -->
<table class="table table-hover" border="1" id="table1">
	<tr> 
		<th>번호</th>
		<th>제목</th>
		<th>이름</th>
		<th>날짜</th>
		<th>조회수</th>
	</tr>
	<!-- forEach var="개별데이터" items="집합데이터" -->
<c:forEach var="row" items="${map.list}">
	<tbody>
	<tr>
		<td>${row.bno}</td>
		<td>
			<a href="/board/view.do?bno=${row.bno}">
			${row.title}
			</a>
			<c:if test="${row.cnt > 0}">
				<span style="color:red;">( ${row.cnt} )</span>
			</c:if>
		</td>
		
		<td>${row.user_name}</td>

		<%-- <td><fmt:formatDate value="${row.regdate}"
			pattern="yyyy-MM-dd HH:mm:ss"/> </td>
		<td>${row.viewcnt}</td> --%>
		<td>${row.regdate}</td>
		<td>${row.viewcnt}</td>
	</tr>
	</tbody>
</c:forEach>	
</table>

<br>
<table class="container" id="table2">
	<!-- 페이지 네비게이션 출력 -->
	<tr>
		<td colspan="5" align="center" class="page-item">
			<c:if test="${map.pager.curBlock > 1}">
				<a href="#" onclick="list('1')">[처음]</a>
			</c:if>
			<c:if test="${map.pager.curBlock > 1}">
				<a href="#" onclick="list('${map.pager.prevPage}')">
				[이전]</a>
			</c:if>
			
			<c:forEach var="num" 
				begin="${map.pager.blockBegin}"
				end="${map.pager.blockEnd}">
				<c:choose>
					<c:when test="${num == map.pager.curPage}">
					<!-- 현재 페이지인 경우 하이퍼링크 제거 -->
						<span style="color:red;">${num}</span>
					</c:when>
					<c:otherwise>
							<a href="#" onclick="list('${num}')">${num}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${map.pager.curBlock < map.pager.totBlock}">
				<a href="#" 
				onclick="list('${map.pager.nextPage}')">[다음]</a>
			</c:if>
			<c:if test="${map.pager.curPage < map.pager.totPage}">
				<a href="#" 
				onclick="list('${map.pager.totPage}')">[끝]</a>
			</c:if>
			
			<div class="container">
				<button type="button" id="btnWrite" class="btn btn-primary float-right">글쓰기</button>
			</div>
		</td>
		
	</tr>
	
</table>
</body>
</html>



















