<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../include/header.jsp" %>
<title>Insert title here</title>

<script type="text/javascript">
$(function() {
	$("#btnjoin").click(function() {
		var phone1 = $("#phone1").val();
		var phone2 = $("#phone2").val();
		var phone3 = $("#phone3").val();
			
		var nametext= $("#name");
		var emailtext = $("#email");
		var phonetext = $("#phone2");
		
		var name = $("#name").val();
	    var email = $("#email").val();
	    var phone = phone1 + "-" + phone2 + "-" + phone3;
	    console.log(phone);
		
	    var regname = /^[가-힝]{2,}$/;
	    //이름의 유효성 검사
	    var regExp2 = /[a-z0-9]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
	    //e-name의 유효성 검사
	    var regtel = /^\d{3}-\d{3,4}-\d{4}$/;
	    //연락처 유효성 검사

	    
	    if(!regname.test(name))
	    {
	    	alert("이름을 형식에 맞춰 입력하세요.");
	    	name="";
	    	nametext.focus();
	    	return;
	    }
	    if(!regtel.test(phone))
	    {
	    	alert("휴드폰번호를 형식에 맞춰 입력하세요.");
	    	phone="";
	    	phonetext.focus();
	    	return;
	    }
	    
	    if(!regExp2.test(email))
	    {
	    	alert("이메일을 형식에 맞춰 입력하세요.");
	    	email="";
	    	emailtext.focus();
	    	return;
	    }
	    
	    document.getElementById("phone").value = phone;
	    
		alert("가입 성공 하셨습니다!");
	    
	    $("form[name=form1]").attr("action","/kakao_insert.do");
	    $("form[name=form1]").submit();
	});
});
</script>

</head>
<body>
<%@ include file="../include/menu.jsp" %>

<h2 align="center">회원가입 페이지</h2><br><br>
<div class="container" style="overflow: scroll;">
<form name="form1" method="post">
<table class="table table-hover">
			<tr>
				<td>아이디</td>
				<td>
					<input value="${map.userid}" name="userid" id="userid" readonly="readonly" size="10">
				</td>
			</tr>
			<tr>
				<td>이름</td>
				<td>
					<input type="text" value="${map.name}" name="name" id="name" size="10">
				</td>
			</tr>
			<tr>
				<td>이메일주소</td>
				<td><input type="text" name="email" id="email" size="30"></td>
			</tr>
			<tr>
				<td>핸드폰번호</td>
				<td> <input type="hidden" id="phone" name="phone">
				<select id="phone1" name="phone1">
					<option value="010">010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="017">017</option>
					<option value="018">018</option>
					<option value="019">019</option>
					</select> - 
					<input name="phone2" id="phone2" size="7"> - 
					<input name="phone3" id="phone3" size="7">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="가입신청" id="btnjoin" class="btn btn-default btn-primary">
					<input type="button" value="취소" id="btnback" class="btn btn-default btn-danger">
				</td>
			</tr>
		</table>
</form>
</div>
</body>
</html>