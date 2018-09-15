<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- views/upload/uploadAjax.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script src="${path}/include/js/commons.js"></script>

<style>
.fileDrop {
	width: 100%;
	height: 200px;
	border: 1px dotted blue;
}
small {
	margin-left:3px;
	font-weight: bold;
	color: gray;
}
</style>
<script>
$(function(){
	//드래그 기본 효과를 막음
	$(".fileDrop").on("dragenter dragover", function(e){
		e.preventDefault();
	});
	$(".fileDrop").on("drop",function(e){
		//drop이 될 때 기본 효과를 막음
		e.preventDefault();
		//첨부파일 배열
		var files=e.originalEvent.dataTransfer.files;
		var file=files[0]; //첫번째 첨부파일
		// 콘솔에서 파일정보 확인
		console.log(file);
		// ajax로 전달할 폼 객체
		var formData=new FormData(); //폼 객체
		// 폼 객체에 파일추가, append("변수명", 값)
		formData.append("file",file); //폼에 file 변수 추가
		//서버에 파일 업로드(백그라운드에서 실행됨)
		// contentType: false => multipart/form-data로 처리됨
		$.ajax({
			type: "post",
			url: "/upload/uploadAjax",
			data: formData,
			dataType: "json",
			processData: false,
			contentType: false,
			success: function(data){
				console.log("data:"+data); //업로드된 파일 이름
				
				var fileInfo=getFileInfo(data.fullName);
				var fileName=fileInfo.fileName;
				var fullName=fileInfo.fullName;
				var fileSize=data.fileSize;
				
				
				alert("이미지파일 업로드");
				var str="<div><a href='"+fileInfo.getLink+"'>"
					+fileName+"&nbsp;&nbsp;";
				str+="<img width='30' height='30' src='"+fileInfo.getLink+"'></a>";
				
				str+="<span data-src="+data+">[삭제]</span></div>";
				$(".uploadedList").append(str);
			}
		});
	}); //fileDrop 함수
	//첨부파일 삭제 함수
	$(".uploadedList").on("click", "span", function(e){
		alert("파일 삭제");
		//현재 클릭한 태그
		var that=$(this);
//data: "fileName="+$(this).attr("data-src"),		
		$.ajax({
			url: "/upload/deleteFile",
			type: "post",
			data: {
				fileName: $(this).attr("data-src")
			},
			dataType: "text",
			success: function(result){
				if(result=="deleted"){
					that.parent("div").remove();
				}
			}
		});
	});
	
	/* function getOriginalName(fileName){
		if(checkImageType(fileName)){ //이미지 파일이면 skip
			return;
		}
		var idx=fileName.indexOf("_")+1; //uuid를 제외한 파일이름
		return fileName.substr(idx);
	}
	function getImageLink(fileName){
		if(!checkImageType(fileName)){//이미지 파일이 아니면 skip
			return;
		}
		var front=fileName.substr(0,12);//연월일 경로
		var end=fileName.substr(14);// s_ 제거
		console.log(front); // /2018/08/05/
		console.log(end); // 43ff34388td-fdf~~.png
				
		return front+end;
	}
	function checkImageType(fileName){
		var pattern=/jpg|png|jpeg/i; //정규표현식(대소문자 무시)
		return fileName.match(pattern); //규칙에 맞으면 true
	} */
});
</script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2>Ajax File Upload</h2>
<!-- 파일을 업로드할 영역 -->
<div class="fileDrop"></div>
<!-- 업로드된 파일 목록을 출력할 영역 -->
<div class="uploadedList"></div>

</body>
</html>



















