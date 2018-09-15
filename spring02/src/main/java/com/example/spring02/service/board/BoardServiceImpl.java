package com.example.spring02.service.board;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.spring02.controller.upload.AjaxUploadController;
import com.example.spring02.model.board.dao.BoardDAO;
import com.example.spring02.model.board.dto.BoardDTO;
import com.example.spring02.model.member.dto.MemberDTO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	BoardDAO boardDao;
	
	//첨부파일 레코드 삭제
	@Override
	public void deleteFile(String fullName) {
		System.out.println("삭제할 fullName = " + fullName);
		boardDao.deleteFile(fullName);
	}

	@Override
	public List<Map<String, Object>> getAttach(int bno) {
		
		return boardDao.getAttach(bno);
	}

	// 1. 글쓰기 - 게시물 번호 생성
	// 2. 첨부파일 등록 - 게시물 번호 사용
	@Transactional
	@Override
	public void create(BoardDTO dto) throws Exception {
		
		String title = dto.getTitle();
	    String content = dto.getContent();
	    String writer = dto.getWriter();
	  
	    title = title.replace("<", "&lt;");
	    title = title.replace("<", "&gt;");
	    writer = writer.replace("<", "&lt;");
	    writer = writer.replace("<", "&gt;");
	    title = title.replace("  ",    "&nbsp;&nbsp;");
	    writer = writer.replace("  ",    "&nbsp;&nbsp;");
	    content = content.replace("\n", "<br>");
	    dto.setTitle(title);
	    dto.setContent(content);
	    dto.setWriter(writer);
	    
		// board 테이블에 레코드 추가
		boardDao.create(dto);
		
		
		// attach 테이블에 레코드 추가
		String[] files = dto.getFiles(); // 첨부파일 이름 배열
		String[] fileSize=dto.getFileSize();
		
		String name = null;
		String name2 = null;
		
		if(files==null) return; // 첨부파일이 없으면 skip
		
//		for(String name : files) {
//			System.out.println("서비스 fileName : " + name);
//			
//		}

		
		for(int i=0; i<files.length; i++) {
			name = files[i];
			System.out.println("업로드 서비스 파일명 : "+ name);

			name2 = fileSize[i];
			System.out.println("업로드 서비스 용량 : " + name2);
			boardDao.addAttach(name, name2); // attach 테이블에 insert
		}
		

	}

	@Override
	public BoardDTO read(int bno) throws Exception {
		
		return boardDao.read(bno);
	}

	@Override
	public void update(BoardDTO dto) throws Exception {
		boardDao.update(dto); // board 테이블 수정
		
		// attach 테이블 수정
		String[] files = dto.getFiles();
		String[] fileSize = dto.getFileSize();
		
		String name = null;
		String name2 = null;
		
		if(files==null) {
			System.out.println("업로드 된 파일이 없습니다.");
			return;
		}
		
		for(int i=0; i<files.length; i++) {
			name=files[i];
			name2=fileSize[i];
			boardDao.updateAttach(name2, name, dto.getBno());
		}
	}

	// 트랜잭션 처리 메소드
	@Transactional
	@Override
	public void delete(int bno) throws Exception {
		// reply 레코드 삭제
		// attach 레코드 삭제
		// 첨부파일 삭제
		// board 레코드 삭제
		System.out.println("삭제 서비스");
		boardDao.delete(bno);
		
	}

	@Override
	public List<BoardDTO> listAll(String search_option, String keyword, int start, int end) throws Exception {
		
		return boardDao.listAll(search_option, keyword, start, end);
	}

	//조회수 증가 처리
	@Override
	public void increaseViewcnt(int bno, HttpSession session) 
				throws Exception {
		long update_time=0;
		if(session.getAttribute("update_time_"+bno)!=null) {
			//최근에 조회수를 올린 시간
			update_time=
					(Long)session.getAttribute("update_time_"+bno);
		}
		long current_time= System.currentTimeMillis();
		//일정 시간이 경과한 후 조회수 증가 처리
		if(current_time - update_time > 5*1000) {
			//조회수 증가 처리
			boardDao.increateViewcnt(bno);
			//조회수를 올린 시간 저장
			session.setAttribute("update_time_"+bno, current_time);
		}
	}

	@Override
	public int countArticle(String search_option, String keyword) throws Exception {
		return boardDao.countArticle(search_option, keyword);
	}

}
