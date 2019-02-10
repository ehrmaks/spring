package com.example.spring02.model.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.spring02.model.board.dto.BoardDTO;

public interface BoardDAO {
	// 첨부파일 삭제
	public void deleteFile(String fullName);
	// 첨부파일 정보
	public List<Map<String, Object>> getAttach(int bno);
	// 첨부파일 저장
	public void addAttach(String fullName, String fileSize);
	// 첨부파일 수정
	public void updateAttach(String fileSize, String fullName, int bno);
	// 글쓰기
	public void create(BoardDTO dto) throws Exception;
	// 글수정
	public void update(BoardDTO dto) throws Exception;
	// 글삭제
	public void delete(int bno) throws Exception;
	
	//목록
	public List<BoardDTO> listAll(String search_option, String keyword,
			int start, int end);
	// 조회수 증가 처리
	public void increateViewcnt(int bno) throws Exception;
	// 레코드 갯수 계산
	public int countArticle(String search_option, String keyword) throws Exception;
	// 레코드 조회
	public BoardDTO read(int bno) throws Exception;

}
