var second;
var timechecker=null;
// 한 페이지에 하나만 호출
window.onload=function(){
	ClearTime();
	initTimer();
	printClock();
}

function ClearTime() {
	second = 60*30;
}

Lpad = function(str,len) {
	str=str+"";
	while(str.length < len) {
		str="0" + str;
	}
	return str;
}

initTimer = function(){
	var timer = document.getElementById("timer");
	rMinute = parseInt(second/60);
	rMinute = rMinute % 60;
	
	rSecond = second % 60;
	
	if(second>0) {
		timer.innerHTML = "&nbsp;" + Lpad(rMinute,2) + "분" + 
		Lpad(rSecond,2) + "초";
		
		second--;
		// 1초간격으로 체크
		timechecker = setTimeout("initTimer()", 1000);
	} else {
		logout();
		alert("로그아웃 되었습니다.");
	}
}

function refreshTimer() {
	var xhr = initAjax();
	xhr.open("POST", "/member/login.do", false);
	xhr.send();
	ClearTime();
}

function logout(){
	ClearTime(timechecker);
	var xhr = initAjax();
	xhr.open("POST","/member/logout.do", false);
	xhr.send();
	location.reload();
}

function initAjax() {
	var xmlhttp;
	if(window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	return xmlhttp;
}