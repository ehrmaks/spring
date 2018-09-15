package com.example.spring02.model.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.spring02.model.board.dto.ReplyDTO;
@Repository //dao bean
public class ReplyDAOImpl implements ReplyDAO {
	@Inject //의존관계 주입
	SqlSession sqlSession;

	//댓글 목록
	@Override
	public List<ReplyDTO> list(int bno, int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno", bno);
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("reply.listReply", map);
	}
	
	// 댓글 갯수
	@Override
	public int count(int bno) {
		return sqlSession.selectOne("reply.countReply", bno);
	}
	//댓글 추가	
	@Override
	public void create(ReplyDTO dto) {
		sqlSession.insert("reply.insertReply", dto); 
	}
	// 댓글 수정
	@Override
	public void update(ReplyDTO dto) {
		sqlSession.update("reply.updateReply", dto);
	}
	// 댓글 삭제
	@Override
	public void delete(int rno) {
		sqlSession.delete("reply.deleteReply", rno);
	}
	// 상세보기
	@Override
	public ReplyDTO detail(int rno) {
		return sqlSession.selectOne("reply.detailReply", rno);
	}
}













