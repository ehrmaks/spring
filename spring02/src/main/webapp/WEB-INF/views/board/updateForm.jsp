<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- views/board/view.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript" src="${path}/include/js/commons.js"></script>
<!-- ckeditor의 라이브러리 -->
<script src="${path}/ckeditor/ckeditor.js"></script>

<script>
$(document).ready(function() {
	/* 게시글 관련 */
	
	// 1. 첨부파일 목록 불러오기 함수 호출
	listAttach();
	
	$("#btnSave").click(function(){
		var str="";
		var str2="";
		var content=$("#content").val();
		var title=$("#title").val();
		
		if(title=="") {
			alert("제목을 입력하세요.");
			document.form1.title.focus();
			return;
		}
		if(content==""){
			alert("내용을 입력하세요.");
			document.form1.content.focus();
			return;
		}
		document.form1.action="${path}/board/update.do";
		
		// 첨부파일 이름을 form에 추가
		var that = $("#form1");
		var str = "";
		// 태그들.each(함수)
		// id가 uploadedList인 태그 내부에 있는 hidden태그들
		// uploadedList 내부의 .file 태그 각각 반복
		$("#uploadedList .file").each(function(i){
			console.log(i);
			//hidden 태그 구성
			str += "<input type='hidden' name='files["+i+"]' value='"+$(this).val()+"'>";
		});
		
		$("#uploadedList .file2").each(function(j){
			console.log(j);
			//hidden 태그 구성
			str2 += "<input type='hidden' name='fileSize["+j+"]' value='"+$(this).val()+"'>";
		});
		
		//폼에 hidden 태그들을 붙임
		$("#form1").append(str, str2);
		// 폼에 입력한 데이터를 서버로 전송
		document.form1.submit();
		
	});
	
	/* // 2. 게시글 삭제
	$("#btnDelete").click(function() {
		if(confirm("삭제하시겠습니까?")) {
			document.form1.action = "${path}/board/delete.do";
			document.form1.submit();
		}
	}); */
	
	// 3. 목록 버튼
	$("#btnList").click(function(){
		location.href="${path}/board/list.do";
	});
	
	
	
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
		var formData=new FormData(); //폼 객체
		formData.append("file",file); //폼에 file 변수 추가
		//서버에 파일 업로드(백그라운드에서 실행됨)
		// contentType: false => multipart/form-data로 처리됨
		$.ajax({
			type: "post",
			url: "${path}/upload/uploadAjax",
			data: formData,
			dataType: "json",
			processData: false,
			contentType: false,
			success: function(data){
				//data : 업로드한 파일 정보와 Http 상태 코드
				console.log("data:"+data); //업로드된 파일 이름
				
				//console.log(data);
				//data : 업로드한 파일 정보와 Http 상태 코드
				var fileInfo=getFileInfo(data.fullName);
				var fileName = fileInfo.fileName;
				var fullName = fileInfo.fullName;
				var fileSize = data.fileSize;
				
				//console.log(fileInfo);
				var html="<div><a href='"+fileInfo.getLink+"'>"+
					fileName+"</a>&nbsp;&nbsp;";
				
				html+="<a href='#' class='fileDel' data-src='"
					+data+"'>[삭제]</a>&nbsp;&nbsp;";
				
				html+="파일용량 : "+fileSize+"(byte)";
					
				html += "<input type='hidden' class='file' value='"
					+fullName+"'>";
				html += "<input type='hidden' class='file2' value='"
					+fileSize+"'></div>";
				
				alert("업로드 Success!!");
				$("#uploadedList").append(html);
			}
		});
	}); //fileDrop 함수	
	
	
	$('#fileUp').on("click", function() {
		var form = new FormData(document.getElementById('uploadForm'));
		console.log("uploadForm:"+form);

		//서버에 파일 업로드(백그라운드에서 실행됨)
		// contentType: false => multipart/form-data로 처리됨
		$.ajax({
			type: "post",
			url: "/upload/uploadAjax",
			data: form,
			dataType: "json",
			processData: false,
			contentType: false,
			success: function(data){
				console.log("data:"+data); //업로드된 파일 이름
				
				//console.log(data);
				//data : 업로드한 파일 정보와 Http 상태 코드
				var fileInfo=getFileInfo(data.fullName);
				var fileName=fileInfo.fileName;
				var fullName=fileInfo.fullName;
				var fileSize=data.fileSize;
				
				//console.log(fileInfo);
				var html="<div><a href='"+fileInfo.getLink+"'>"
						+fileName+"</a>&nbsp;&nbsp;";
	
				html+="<a href='#' class='fileDel' data-src='"
					+data+"'>[삭제]</a>&nbsp;&nbsp;";
				
				html+="파일용량 : "+fileSize+"(byte)";
				
				html += "<input type='hidden' class='file' value='"
					+fullName+"'>";
				
				html += "<input type='hidden' class='file2' value='"
					+fileSize+"'></div>";
				alert("업로드 Success!!");
				$("#uploadedList").append(html);
				
			},
			error: function(data) {
				alert("실패");
			}
		});
	});
	
	
	//첨부파일 삭제 함수
	$("#uploadedList").on("click", ".fileDel", function(e){
		//현재 클릭한 태그
		var that=$(this);
//data: "fileName="+$(this).attr("data-src"),		
		$.ajax({
			url: "${path}/upload/deleteFile",
			type: "post",
			data: {
				fileName: $(this).attr("data-src")
			},
			dataType: "text",
			success: function(result){
				if(confirm('해당 파일을 삭제 하시겠습니까?')){
					if(result=="deleted") {
						that.parent("div").remove();
					}
				} else {
					
				}
			}
		});
	});
	
});

// -------------------------------------------------------	
	


//첨부파일 리스트를 출력하는 함수
function listAttach(){
	$.ajax({
		type: "post",
		url: "${path}/board/getAttach/${dto.bno}",
		dataType: "json",
		success: function(list){
			// list : json
			//console.log(list);
			$.each(list, function(i){
				console.log("i = " + i);
				var num = i%2;
				if(num < 1){
					i=i;
				} else {
					return;
				}
				
				var fileInfo=getFileInfo(list[i+1]);
				
				var html="<div><a href='"+fileInfo.getLink+"'>"+fileInfo.fileName+"</a>&nbsp;&nbsp;";
				
				html+="<a href='#' class='fileDel' data-src='"+list[i+1]+"'>[삭제]</a>&nbsp;&nbsp;";
				
				html+="파일용량 : "+list[i]+"(byte)</div>";
				
				$("#uploadedList").append(html);
			});
		}
	});
}

</script>

<style>
.fileDrop {
	width: 600px;
	height: 100px;
	border: 1px dotted gray;
	background-color: gray;
}
</style>


</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2>게시물 수정</h2>
<form id="form1" name="form1" method="post"
action="${path}/board/insert.do">
	<div>제목  <input name="title" id="title" size="80" 
	value="${dto.title}" placeholder="제목을 입력해주세요">
	</div>
	<div>조회수 : ${dto.viewcnt}	</div>
	<div style="width:800px;">
		내용 
		<textarea name="content" id="content" rows="4" 
		cols="80" placeholder="내용을 입력해주세요">
		${dto.content}</textarea>
<script>
// ckeditor 적용
CKEDITOR.replace("content",{
	filebrowserUploadUrl: "${path}/imageUpload.do",
	height: "300px"
});
</script>
	</div>
	<br><hr><br>
	
	
	<div style="width:700px; text-align:center;">
<!-- 수정,삭제에 필요한 글번호를 hidden 태그에 저장 -->	
		<input type="hidden" name="bno" value="${dto.bno}">
		
		<!-- 본인만 수정,삭제 버튼 표시 -->
		<c:if test="${sessionScope.userid == dto.writer}">
			<button type="button" id="btnSave">확인</button>
		</c:if>

		
		
		<button type="button" id="btnList">목록</button>
	</div>
	<br>
	<hr>
	<br>
</form>

	<div> 첨부파일을 아래박스에 드래그 하세요 또는&nbsp;
		<form id="uploadForm" enctype="multipart/form-data" method="post"
		action="/upload/uploadAjax">
			<input type="file" name="file">
		</form>
		<button id="fileUp">업로드</button>
		<!-- 첨부팡리 등록 영역 -->
		<div class="fileDrop"></div>
		<!-- 첨부파일의 목록 출력 영역 -->
		<div id="uploadedList"></div>
	</div>
	
	<br>	<br>	<br>	<br>


</body>
</html>



















