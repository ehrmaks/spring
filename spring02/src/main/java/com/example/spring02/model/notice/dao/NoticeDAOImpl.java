package com.example.spring02.model.notice.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.spring02.model.board.dto.BoardDTO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Inject
	SqlSession sqlSession;

	@Override
	public void deleteFile(String fullName) {
		sqlSession.delete("notice.deleteFile", fullName);
	}

	@Override
	public List<Map<String, Object>> getAttach(int bno) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("notice.getAttach", bno);
	}

	@Override
	public void addAttach(String fullName, String fileSize) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fullName", fullName);
		map.put("fileSize", fileSize);
		
		sqlSession.insert("notice.addAttach", map);
	}

	@Override
	public void updateAttach(String fileSize, String fullName, int bno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fileSize", fileSize);
		map.put("fullName", fullName);
		map.put("bno", bno);
		sqlSession.insert("notice.updateAttach", map);
	}

	@Override
	public void create(BoardDTO dto) throws Exception {
		sqlSession.insert("notice.insert", dto);
	}

	@Override
	public void update(BoardDTO dto) throws Exception {
		sqlSession.update("notice.update", dto);
	}

	@Override
	public void delete(int bno) throws Exception {
		sqlSession.delete("notice.delete", bno);
	}

	@Override
	public List<BoardDTO> listAll(String search_option, String keyword, int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("notice.listAll", map);
	}

	@Override
	public void increateViewcnt(int bno) throws Exception {
		sqlSession.update("notice.increaseViewcnt", bno);
	}

	@Override
	public int countArticle(String search_option, String keyword) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search_option", search_option);
		map.put("keyword", "%"+keyword+"%");
		
		return sqlSession.selectOne("notice.countArticle", map);
	}

	@Override
	public BoardDTO read(int bno) throws Exception {
		return sqlSession.selectOne("notice.read", bno);
	}
}
