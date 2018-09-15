package com.example.spring02.service.board;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.example.spring02.model.board.dao.ReplyDAO;
import com.example.spring02.model.board.dto.ReplyDTO;

@Service //service bean
public class ReplyServiceImpl implements ReplyService {
	@Inject
	ReplyDAO replyDao;

	//댓글 목록
	@Override
	public List<ReplyDTO> list(int bno, int start, int end, HttpSession session) {
		List<ReplyDTO> items = replyDao.list(bno, start, end);
		
		String userid = (String) session.getAttribute("userid");

		for(ReplyDTO dto : items) {
			// 댓글 목록중에 비밀 댓글이 있으면
			if(dto.getSecret_reply().equals("y")) {
				if(userid==null) { // 비회원이라면 비밀댓글로 처리
					dto.setReplytext("비밀 댓글입니다.");
				} else {
					String writer = dto.getWriter(); // 게시물 작성자 저장
					String replyer = dto.getReplyer(); // 댓글 작성자 저장
					// 로그인 한 사용자가 게시물의 작성자 and 댓글작성자 가 아니라면 비밀댓글 처리
					if(!userid.equals(writer) && !userid.equals(replyer)) {
						dto.setReplytext("비밀 댓글입니다.");
					}
				}
			}
		}
		
		return items;
	}
	@Override
	public int count(int bno) {
		return replyDao.count(bno);
	}
//댓글 쓰기	
	@Override
	public void create(ReplyDTO dto) {
		replyDao.create(dto);
	}
	@Override
	public void update(ReplyDTO dto) {
		replyDao.update(dto);
	}
	@Override
	public void delete(int rno) {
		replyDao.delete(rno);
	}
	@Override
	public ReplyDTO detail(int rno) {
		return replyDao.detail(rno);
	}
}











