/*views/include/js/commons.js*/
/*이미지 파일인지 확인

/정규표현식/

*/

// 이미지 파일 여부 판단
function checkImageType(fileName) {
	var pattern = /jpg|gif|png|jpeg/i;
	return fileName.match(pattern);
}

// 업로드 파일 정보
function getFileInfo(fullName) {
	var fileName, imgsrc, getLink, fileLink;
	
	// 이미지 파일일 경우
	if(checkImageType(fullName)) {
		// 이미지 파일 경로(썸네일)
		imgsrc = "/upload/displayFile?fileName="+fullName;
		console.log(imgsrc);
		
		// 업로드 파일명
		fileLink = fullName.substr(14);
		console.log(fileLink);
		
		// 파일사이즈
		//fileSize = fullName.substr(fileLink.lastIndexOf('-')+15);
		//console.log(fileSize);
		
		// 날짜별 디렉토리 추출
		var front = fullName.substr(0,12);
		console.log(front);
		
		// s_를 제거한 업로드이미지파일명
		var end = fullName.substr(14);
		console.log(end);
		
		
		// 원본이미지 파일 디렉토리
		getLink = "/upload/displayFile?fileName="+front+end;
		console.log(getLink);
	} else { // 이미지 파일이 아닐 경우
		// UUID를 제외한 원본파일명
		fileLink = fullName.substr(12);
		console.log(fileLink);
		
		// 일반 파일 디렉토리
		getLink = "/upload/displayFile?fileName="+fullName;
		console.log(getLink);		
	}
	
	var fdir = fileLink.lastIndexOf("_");
	// 목록에 출력할 원본파일명
	fileName=fileLink.substr(fdir+1);
	console.log(fileName);
	
	// {변수:값} json 객체 리턴
	return {fileName:fileName, imgsrc:imgsrc, getLink:getLink, fullName:fullName};
}

