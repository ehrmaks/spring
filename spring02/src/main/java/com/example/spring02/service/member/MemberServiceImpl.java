package com.example.spring02.service.member;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.spring02.model.member.dao.MemberDAO;
import com.example.spring02.model.member.dto.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	MemberDAO memberDao;
	
	@Override
	public Boolean loginCheck(MemberDTO dto, HttpSession session) {
		boolean result = memberDao.loginCheck(dto);
		
		if(result) {
			MemberDTO dto2 = viewMember(dto.getUserid());
			
			session.setAttribute("userid", dto.getUserid());
			session.setAttribute("name", dto2.getName());
			System.out.println(session.getAttribute("userid"));
			System.out.println(session.getAttribute("name"));
		}
		
		return result;
//		return memberDao.loginCheck(dto);
	}

	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}

	@Override
	public MemberDTO viewMember(String userid) {
		System.out.println("서비스의 userid = " + userid);
		return memberDao.viewMember(userid);
	}

	@Override
	public void insert(MemberDTO dto) {
		memberDao.insert(dto);
	}

	@Override
	public void update(MemberDTO dto) {
		memberDao.update(dto);
	}

	@Override
	public void delete(MemberDTO dto) {
		memberDao.delete(dto);
	}

	@Override
	public int idCheck(String userid) {
		// TODO Auto-generated method stub
		return memberDao.idCheck(userid);
	}
	
	@Transactional
	@Override
	public void amount(String userid, int point, int total_amount) {
		memberDao.amount(userid, point, total_amount);
	}

}
