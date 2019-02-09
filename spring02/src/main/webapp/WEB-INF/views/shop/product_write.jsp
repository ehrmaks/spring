<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script src="${path}/ckeditor/ckeditor.js"></script>
</head>
<body>
<%@ include file="../include/admin_menu.jsp" %>

<script>
	function product_write() {
		var product_name=$("#product_name").val();
		var product_price=$("#product_price").val();
		var product_desc=$("#product_desc").val();
		
		if(product_name==""){
			alert("상품이름을 입력하세요.");
			$("#product_name").focus();
			return;
		}
		if(product_price==""){
			alert("가격을 입력하세요.");
			$("#product_price").focus();
			return;
		}
		/* if(product_desc==""){
			alert("상품 설명을 입력하세요.");
			$("#product_desc").focus();
			return;
		} */
		
		document.form1.action="${path}/shop/product/insert.do";
		document.form1.submit();
	}
</script>

<div class="container">
<h2 align="center">상품등록</h2><br><br>

<form name="form1" method="post" 
enctype="multipart/form-data">
	<table class="table table-hover" width="80%" border="1">
		<tr>
			<td>상품명</td>
			<td><input name="product_name" id="product_name" width="20%"></td>
		</tr>
		
		<tr>
			<td>가격</td>
			<td><input name="product_price" id="product_price" width="20%"></td>
		</tr>
		
		<tr>
			<td>상품설명</td>
			<td><textarea rows="5" cols="60"
			name="product_desc" id="product_desc"></textarea>
		<script>
			CKEDITOR.replace("product_desc", {
				filebrowserUploadUrl : "${path}/imageUpload.do"
			});
		</script>
			</td>
		</tr>
		
		<tr>
			<td>상품이미지</td>
			<td>
				<input type="file" name="file1" id="file1">
			</td>
		</tr>
		
		<tr>
			<td colspan="2" align="center">
				<input type="button" value="등록" 
				onclick="javascript:product_write()" class="btn btn-default btn-info">
				<input type="button" value="목록"
				onclick="location.href='${path}/shop/product/list.do'" class="btn btn-default btn-warning">
			</td>
		</tr>
	</table>
</form>
</div>
</body>
</html>