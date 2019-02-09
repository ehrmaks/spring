<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- views/board/view.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script src="${path}/include/js/commons.js"></script>
<!-- ckeditor의 라이브러리 -->
<script src="${path}/ckeditor/ckeditor.js"></script>

<script>
$(document).ready(function() {
	listAttach();
	
	/* 게시글 관련 */
	// 1. 수정 버튼
	$("#btnUpdate").click(function() {
		if(confirm("수정페이지로 이동 하시겠습니까?")) {
			document.form1.action="/notice/updateForm.do";
			document.form1.submit();
		}
	});
	
	
	
	// 2. 게시글 삭제
	$("#btnDelete").click(function() {
		if(confirm("삭제하시겠습니까?")) {
			document.form1.action = "/notice/delete.do";
			document.form1.submit();
		}
	});
	
	// 3. 목록 버튼
	$("#btnList").click(function(){
		location.href="/notice/list.do";
	});
	
	
	//첨부파일 삭제 함수
	$("#uploadedList").on("click", ".fileDel", function(e){
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
				
				if(confirm('해당 파일을 삭제 하시겠습니까?')){
					if(result=="deleted") {
						that.parent("div").remove();
					}
				} else {
					
				}
			}
		});
	});
	
	/* 댓글 관련 */
	// 1. 댓글 입력
	$("#btnReply").click(function() {
		//reply();
		replyJson();
	});
	
	// 2. 댓글 목록
	//listReply("1") // 고전방식
	//listReply2(); // json 리턴방식
	listReplyRest("1") // rest방식
});

// -------------------------------------------------------	
	
	
	// 1_1. 댓글 입력 함수(폼데이터 형식)
	function reply() {
		var replytext=$("#replytext").val(); //댓글 내용
		var bno="${dto.bno}"; //게시물 번호
		// 비밀댓글 체크 여부
		var secret_reply = "n";
		// 태그.js (":속성") 체크여부 true/false
		if($("#secretReply").is(":checked")) {
			secret_reply = "y";
		}
		
		//var param={ "replytext": replytext, "bno": bno};
		var param="replytext="+replytext+"&bno="+bno;
		$.ajax({
			type: "post",
			url: "/reply/insert.do",
			data: param,
			success: function(){
				alert("댓글이 등록되었습니다.");
				//listReplyRest("1"); //댓글 목록 출력
				listReply("1");
			}
		});
	}

	// 1_2. 댓글 입력 함수(json 형식)
     function replyJson(){
		
        var replytext=$("#replytext").val();
        var bno="${dto.bno}"
        // 비밀댓글 체크여부
        var secret_reply = "n";
        // 태그.is(":속성") 체크여부 true/false
        if( $("#secretReply").is(":checked") ){
        	secret_reply = "y";
        }
        $.ajax({                
            type: "post",
            url: "/reply/insertRest.do",
            headers: {
                "Content-Type" : "application/json"
            }, 
            dataType: "text",
            // param형식보다 간편
            data: JSON.stringify({
                bno : bno,
                replytext : replytext,
                secret_reply : secret_reply
            }),
            success: function(){
                alert("댓글이 등록되었습니다.");
                // 댓글 입력 완료후 댓글 목록 불러오기 함수 호출
                //listReply("1");     // 전통적인 Controller방식
                //listReply2();     // json리턴 방식
                listReplyRest("1"); // Rest 방식
            },
			error: function(e) {
				console.log(e);
				alert("실패");
			}
        });
    }


//타임스탬프값(숫자형)을 문자열 형식으로 변환
function changeDate(date){
	date = new Date(parseInt(date));
	year=date.getFullYear();
	month=date.getMonth();
	day=date.getDate();
	hour=date.getHours();
	minute=date.getMinutes();
	second=date.getSeconds();
	strDate = 
		year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
	return strDate;
}

//목록 보기 3가지 방식.
//2_1. 댓글 목록 - 전통적인 Controller방식
function listReply(num){
	$.ajax({
		type: "get",
		url: "/reply/list.do?bno=${dto.bno}&curPage="+num,
		success: function(result){
			//result : responseText 응답텍스트(html)
			$("#listReply").html(result);
		}
	});
}

//2_2. 댓글 목록 - RestController를 이용 json형식으로 리턴
function listReply2(){
		$.ajax({
            type: "get",
            //contentType: "application/json", ==> 생략가능(RestController이기때문에 가능)
            url: "/reply/listjson.do?bno=${dto.bno}",
            success: function(result){
                console.log(result);
                var output = "<table>";
                for(var i in result){
                    output += "<tr>";
                    output += "<td>"+result[i].user_name;
                    output += "("+changeDate(result[i].regdate)+")<br>";
                    output += result[i].replytext+"</td>";
                    output += "</tr>";
                }
                output += "</table>";
                $("#listReply").html(output);
		}
	});
}

//2_3. 댓글 목록 - Rest방식
function listReplyRest(num){
	
    $.ajax({
        type: "get",
        url: "/reply/list/${dto.bno}/"+num,
        success: function(result){
        // responseText가 result에 저장됨.
            $("#listReply").html(result);
        }
    });
}

//첨부파일 리스트를 출력하는 함수
function listAttach(){
	$.ajax({
		type: "post",
		url: "/notice/getAttach/${dto.bno}",
		dataType: "json",
		success: function(list){
			// list : json
			//console.log(list);
			$.each(list, function(i){
				console.log("i = "+i);
				var num = i%2;
				if(num < 1){
					i=i;
				} else {
					return;
				}
				// this는 fullName
				var fileInfo=getFileInfo(list[i+1]);

				// fileName
				var html="<div><a href='"+fileInfo.getLink+"'>"
					+fileInfo.fileName+"</a>&nbsp;&nbsp;";
				
				// 삭제
				<c:if test="${sessionScope.userid == dto.writer}">	
					html+="<a href='#' class='fileDel' data-src='"
						+list[i+1]+"'>[삭제]</a>&nbsp;&nbsp;";
				</c:if>
				
				// fileSize
				html+="파일용량 : "+list[i]+"(byte)</div>";
				$("#uploadedList").append(html);
			});
		}
	});
}


//**댓글 수정화면 생성 함수
function showReplyModify(rno){
	$.ajax({
        type: "get",
        url: "/reply/detail/"+rno,
        success: function(result){
            $("#modifyReply").html(result);
            // 태그.css("속성", "값")
            $("#modifyReply").css("visibility", "visible");
            $("#detailReplytext").focus();
        }
    })
}

</script>



<style>
	#modifyReply {
        width: 800px;
        height: 130px;
        background-color: gray;
        padding: 10px;
        z-index: 10;
        visibility: hidden;
	}
</style>


</head>
<body>
<%@ include file="../include/menu.jsp" %>
<h2 class="text-center">공지글 보기</h2><br><br>

<div class="container">
<form id="form1" name="form1" method="post"
action="/notice/insert.do" enctype="multipart/form-data">
	<table border="1" class="table table-striped table-bordered table-hover">
		<colgroup>
			<col width="10%"/>
			<col width="35%"/>
			<col width="10%"/>
			<col width="35%"/>
		</colgroup>

		<tbody>
			<tr>
				<th scope="row">글 번호</th>
				<td>
					${dto.bno}
					<input type="hidden" id="bno" name="bno" value="${dto.bno}">
				</td>
				<th scope="row">조회수</th>
				<td>${dto.viewcnt}</td>
			</tr>
			<tr>
				<th scope="row">작성자</th>
				<td>${dto.user_name}</td>
				<th scope="row">작성시간</th>
				<%-- <td><fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td> --%>
				<td>${dto.regdate}</td>
			</tr>
			<tr>
				<th scope="row">제목</th>
				<td colspan="3">
					${dto.title}
				</td>
			</tr>
			<tr>
				<th scope="row">내용</th>
				<td colspan="4">
					${dto.content}
				</td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td colspan="3">
					<div id="uploadedList"></div>
					
				</td>
			</tr>
		</tbody>
	</table>
	
	<hr>
	<br>
	
	<div class="container" style="width:700px; text-align:center;">
<!-- 수정,삭제에 필요한 글번호를 hidden 태그에 저장 -->	
		<input type="hidden" name="bno" value="${dto.bno}">
		
		<!-- 본인만 수정,삭제 버튼 표시 -->
		<c:if test="${sessionScope.userid == dto.writer || sessionScope.userid == 'admin'}">
			<button type="button" id="btnUpdate" class="btn btn-default btn-warning">수정</button>
			<button type="button" id="btnDelete" class="btn btn-default btn-danger">삭제</button>
		</c:if>
		
		<button type="button" id="btnList" class="btn btn-default btn-info">목록</button>
	</div>
	<br>
	<hr>
	<br>
</form>
<!-- 댓글 작성 -->
<div style="width:700px; text-align:center;" align="center" class="container">
	 <c:if test="${sessionScope.userid != null }">
	 	<textarea rows="5" cols="80" id="replytext"
	 		placeholder="댓글을 작성하세요"></textarea>
	 	<br>
	 	<input type="checkbox" id="secretReply"> 비밀댓글
	 	<button type="button" id="btnReply" class="btn btn-default btn-primary">댓글작성</button>
	 </c:if>
	 <br>
</div>
<!-- 댓글 목록 -->
<div id="listReply"></div>

<br>
<br>
<br>
</div>
</body>
</html>



















