<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
</head>

<script>
$(function() {
	$("#btnUpdate").click(function() {
		var passwd = $("#passwd").val();
		var passwd_check = $("#passwd_check").val();
		
		if(passwd == "") {
			alert("비밀번호를 입력하세요.");
			$("#passwd").focus();
			return;
		}
		if(passwd_check == "") {
			alert("비밀번호를 확인하세요.");
			$("#passwd_check").focus();
			return;
		}
		alert("수정 성공 하셨습니다!");
		
		document.form1.action = "${path}/member/member.do";
		document.form1.submit();
		
	});
});

function daumZipCode() {
	new daum.Postcode({
		oncomplete: function(data) {
			
			var fullAddr = ''; // 최종 주소 변수
			var extraAddr = '';
			
			if(data.userSelectedType === 'R') {
				fullAddr = data.roadAddress;
			} else {
				fullAddr = data.jibunAddress;
			}
			
			if(data.userSelectedType === 'R') {
				// 법정동명이 있을 경우 추가한다.
				if(data.bname !== '') {
					extraAddr += data.bname;
				}
				
				// 건물명이 있을 경우 추가한다.
				if(data.buildingName !== '') {
					extraAddr += (extraAddr !== '' ? ', ' + 
							data.buildingName : data.buildingName);
				}
				
				fullAddr += (extraAddr !== '' ? ' (' + extraAddr + 
						')' : '');
			}
			
			document.getElementById('zipcode').value =
				data.zonecode; // 5자리 새우편번호 사용
			
			document.getElementById('address1').value =
				fullAddr;
				
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById('address2').focus();
		}
	}).open();
}
</script>

<body>
<%@ include file="../include/menu.jsp" %>

	<form name="form1" method="post">
		<table class="table table-hover">
			<tr>
				<td>아이디</td>
				<td><input name="userid" value="${dto.userid}" readonly="readonly"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input name="name" value="${dto.name}"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="passwd" id="passwd"></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" name="passwd_check" id="passwd_check"></td>
			</tr>
			<tr>
				<td>이메일주소</td>
				<td><input name="email" value="${dto.email}"></td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td><input name="zipcode" id="zipcode" readonly="readonly" size="10">
				<input type="button" onclick="daumZipCode()" value="우편번호 찾기" class="btn btn-default btn-info"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input name="address1" id="address1" size="60" value="${dto.address1}"></td>
			</tr>
			<tr>
				<td>상세주소</td>
				<td><input name="address2" id="address2" size="60" value="${dto.address2}"></td>
			</tr>
			<tr>
				<td>회원가입날짜</td>
				<td><fmt:formatDate value="${dto.join_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="수정" id="btnUpdate" class="btn btn-default btn-primary">
					<input type="button" value="삭제" id="btnDelete" class="btn btn-default btn-danger">
				</td>
			</tr>
		</table>
		
		
	</form>

</body>
</html>