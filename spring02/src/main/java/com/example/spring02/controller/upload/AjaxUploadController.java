package com.example.spring02.controller.upload;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring02.service.board.BoardService;
import com.example.spring02.util.MediaUtils;
import com.example.spring02.util.UploadFileUtils;

@Controller
public class AjaxUploadController {

	private static final Logger logger = 
			LoggerFactory.getLogger(AjaxUploadController.class);
	
	@Inject
	BoardService boardService;
	
	// 업로드 디렉토리 root-context.xml에 설정 되어있음.
	@Resource(name = "uploadPath")
	String uploadPath;
	
	// 파일첨부 페이지로 이동
	@RequestMapping(value = "/upload/uploadAjax", 
			method=RequestMethod.GET)
	public String uploadAjax() {
		// uploadAjax.jsp 로 포워딩
		return "/upload/uploadAjax";
	}
	
	// 업로드 한 파일은 MultipartFile 변수에 저장됨.
	@ResponseBody // json 형식으로 리턴
	@RequestMapping(value = "/upload/uploadAjax",
	method = RequestMethod.POST,
	produces = "text/plain;charset=utf-8")
	public ModelAndView uploadAjax(MultipartFile file) throws Exception {
		logger.info("originalName : " + file.getOriginalFilename());
		logger.info("size : " + file.getSize());
		logger.info("contentType : " + file.getContentType());
		
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String fileName = file.getOriginalFilename();
		
		long fileSize1 = file.getSize();
		String fileSize = Long.toString(fileSize1);
		
		String fullName = UploadFileUtils.uploadFile(uploadPath, fileName, file.getBytes());
		
		map.put("fileSize", fileSize);
		map.put("fullName", fullName);
		mav.addAllObjects(map);
		mav.setViewName("jsonView");
		

		return mav;
	}
	
	
	// 이미지 표시 기능
	@ResponseBody // view가 아닌 데이터 리턴
	@RequestMapping("/upload/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		
		// 서버의 파일을 다운로드 하기 위한 스트림
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		try {
			// 확장자 검사
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			MediaType mType = MediaUtils.getMediaType(formatName);
			
			// 헤더 구성 객체
			HttpHeaders headers = new HttpHeaders();
			
			// InputStream 생성
			in = new FileInputStream(uploadPath + fileName);
			
			//if(mType != null) { // 이미지 파일이면
				//headers.setContentType(mType);
			//} else { // 이미지가 아니면
				fileName = fileName.substring(fileName.lastIndexOf("_")+1);
				
				// 다운로드용 컨텐트 타입
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				
				// 큰 따옴표 내부에 " \" "
				// 바이트 배열을 스트링으로			
				// iso-8859-1 서유럽언어
				// new String(fileName.getBytes("utf-8"),"iso-8859-1");
				headers.add("Content-Disposition", 
						"attachment; filename=\"" + new String(
								fileName.getBytes("utf-8"), "iso-8859-1")+ "\"");
			//}
			
			// 바이트배열, 헤더
			entity = new ResponseEntity<byte[]>(
					IOUtils.toByteArray(in), headers, HttpStatus.OK);
		
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(
					HttpStatus.BAD_REQUEST);
		}finally {
			if(in != null)
				in.close(); // 스트림 닫기
		}
		
		return entity;
		
	}
	
	// 파일 삭제 매핑
	@ResponseBody // 데이터 리턴
	@RequestMapping(value="/upload/deleteFile", 
	method=RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName) {
		logger.info("fileName:"+fileName);
		System.out.println("fileName : "+ fileName);
		// 확장자 검사
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		MediaType mType = MediaUtils.getMediaType(formatName);
		
		if(mType != null) { // 이미지 파일이면 원본이미지 삭제
			String front = fileName.substring(0,12);
			String end = fileName.substring(14);
			
			// File.separatorChar : 유닉스 / 윈도우즈 \
			new File(uploadPath+(front+end).replace('/', 
					File.separatorChar)).delete();
		}
		
		// 원본 파일 삭제(이미지이면 썸네일 삭제)
		new File(uploadPath + fileName.replace('/', 
				File.separatorChar)).delete();
		
		// 레코드 삭제
		boardService.deleteFile(fileName);
		
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	
}
