package com.example.spring02.model.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.spring02.model.board.dto.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	SqlSession sqlSession;
	
	// 첨부파일 레코드 삭제
	@Override
	public void deleteFile(String fullName) {
		sqlSession.delete("board.deleteFile", fullName);
	}

	// 첨부파일 리스트
	@Override
	public List<Map<String, Object>> getAttach(int bno) {
		return sqlSession.selectList("board.getAttach", bno);
	}

	
	@Override
	public void addAttach(String fullName, String fileSize) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fullName", fullName);
		map.put("fileSize", fileSize);
		
		sqlSession.insert("board.addAttach", map);	
	}

	// 첨부파일 정보 수정
	@Override
	public void updateAttach(String fileSize, String fullName, int bno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fileSize", fileSize);
		map.put("fullName", fullName);
		map.put("bno", bno);
		sqlSession.insert("board.updateAttach", map);
	}

	@Override
	public void create(BoardDTO dto) throws Exception {
		sqlSession.insert("board.insert", dto);
	}
	//레코드 수정	
	@Override
	public void update(BoardDTO dto) throws Exception {
		sqlSession.update("board.update", dto);
	}

	@Override
	public void delete(int bno) throws Exception {
		sqlSession.delete("board.delete", bno);
	}

	@Override
	public List<BoardDTO> listAll(String search_option, String keyword, int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		map.put("start", start);
		map.put("end", end);
		// mapper에는 2개 이상의 값을 전달할 수 없음.(dto 또는 map 사용)
		
		return sqlSession.selectList("board.listAll", map);
	}

	@Override
	public void increateViewcnt(int bno) throws Exception {
		sqlSession.update("board.increaseViewcnt", bno);
	}

	@Override
	public int countArticle(String search_option, String keyword) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		
		return sqlSession.selectOne("board.countArticle", map);
	}

	@Override
	public BoardDTO read(int bno) throws Exception {
		return sqlSession.selectOne("board.read", bno);
	}

}
