<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<script>
$(function() {
	var idck = 0;
	$("input[name=userid]").keyup(function() {
		var userid = $("#userid").val();
		
		if(userid == "") {
			$("#div2").html("아이디를 입력하세요.").css("color","red");
		} else {
			$.ajax({
				async: true, // 비동기 통신 default는 true이다
				type: "post",
				data: userid,
				url: "/member/idcheck",
				dataType: "json",
				contentType: "application/json; charset=UTF-8",
				success: function(data) {
					if(data.cnt > 0) {
						$("#div2").html("아이디가 존재합니다. 다른 아이디를 입력해주세요.").css("color","red");
					} else {
						var idtext = $("#userid");
						var id = $("#userid").val();
						var regExp1 = /^[a-zA-Z0-9]{4,12}$/;
						
						if(!regExp1.test(id))
					    	// 아이디 검사 후 4~12자 영문 대소문자와 숫자의 유효성이 안맞다면
					    	// 공백을 주고 알람을 띄운다.
					    	// 밑에 동일한 유효성 검사
					    {
							$("#div2").html("4~12자 그리고 영문과 숫자만 입력하세요.").css("color","red");
					    	id = "";
					    	idtext.focus();
					    	return;
					    } else {
					    	$("#div2").html("사용가능한 아이디입니다.").css("color","blue");
					    }
								
						idck = 1;
					}
				}, error: function(error) {
					console.log(error);
					alert("error : " + error);
				}
			});
		}
	});
	
	
	
	
	$("#passwd").keyup(function() {
		var passwd = $("#passwd").val();
		var passwd_check = $("#passwd_check").val();
		
		if(passwd != passwd_check) {
			$("#div1").html("비밀번호가 일치하지 않습니다.").css("color","red");
		} else {
			$("#div1").html("일치 합니다.").css("color","blue");
		}
	});
	
	
	$("#passwd_check").keyup(function() {
		var passwd = $("#passwd").val();
		var passwd_check = $("#passwd_check").val();
		
		if(passwd != passwd_check) {
			$("#div1").html("비밀번호가 일치하지 않습니다.").css("color","red");
		} else {
			$("#div1").html("일치 합니다.").css("color","blue");
		}
	});
	
	$("#btnjoin").click(function() {
	var phone1 = $("#phone1").val();
	var phone2 = $("#phone2").val();
	var phone3 = $("#phone3").val();
		
	var idtext = $("#userid");
	var pwtext = $("#passwd");
	var cpwtext = $("#passwd_check");
	var nametext = $("#name");
	var emailtext = $("#email");
	var phonetext = $("#phone2");
	
	var id = $("#userid").val();
    var pw = $("#passwd").val();
    var cpw = $("#passwd_check").val();
    var name = $("#name").val();
    var email = $("#email").val();
    var phone = phone1 + "-" + phone2 + "-" + phone3;
    console.log(phone);
	
	var regExp1 = /^[a-zA-Z0-9]{4,12}$/;
    //id와 비밀번호의 유효성 검사
    var regExp2 = /[a-z0-9]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,}/i;
    //e-name의 유효성 검사
    var regname = /^[가-힝]{2,}$/;
    //이름의 유효성 검사
    var regtel = /^\d{3}-\d{3,4}-\d{4}$/;
    //연락처 유효성 검사

    if(!regExp1.test(id))
    	// 아이디 검사 후 4~12자 영문 대소문자와 숫자의 유효성이 안맞다면
    	// 공백을 주고 알람을 띄운다.
    	// 밑에 동일한 유효성 검사
    {
    	alert("형식에 맞춰 ID를 입력하세요.");
    	id = "";
    	idtext.focus();
    	return;
    }
    if(!regExp1.test(pw))
    {
    	alert("형식이 맞춰 비밀번호를 입력하세요.");
    	pw="";
    	pwtext.focus();
    	return;
    }
    if(!(cpw.slice(0,cpw.length) === pw.slice(0,pw.length))){
    	alert("비밀번호가 동일하지 않습니다.");
   		cpw="";
   		cpwtext.focus();
   		return;
    }
    
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
    /* document.form1.action="/member/join_check.do";
    document.form1.submit(); */
    
    
    
    $("form[name=form1]").attr("action","/member/join_check.do");
    $("form[name=form1]").submit();
	});
	
	$("#btnback").click(function() {
		history.back();
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



</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2 align="center">회원가입 페이지</h2><br><br>
<div class="container" style="overflow: scroll;">
<form name="form1" method="post">
<table class="table table-hover">
			<tr>
				<td>아이디</td>
				<td><input name="userid" id="userid" size="10">
					<div id="div2" style="color: red; font-style: inherit;"></div>
				</td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input name="name" id="name" size="10">
					
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="passwd" id="passwd"></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" name="passwd_check" id="passwd_check">
					<div id="div1" style="color: red; font-style: inherit;"></div>
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
				<td>우편번호</td>
				<td><input name="zipcode" id="zipcode" readonly="readonly" size="10">
				<input type="button" onclick="daumZipCode()" value="우편번호 찾기" class="btn btn-default btn-info"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input name="address1" id="address1" size="60"></td>
			</tr>
			<tr>
				<td>상세주소</td>
				<td><input name="address2" id="address2" size="60"></td>
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