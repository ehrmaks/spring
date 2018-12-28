package com.example.spring02.service.member;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.example.spring02.model.member.dao.MemberDAO;
import com.example.spring02.model.member.dto.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	MemberDAO memberDao;
	
	@Override
	public String loginCheck(MemberDTO dto) {
//		boolean result = memberDao.loginCheck(dto);
//		
//		if(result) { // �α��� ����
//			// ���Ǻ����� �� ����
//			System.out.println("서비스impl dto2 접근 시도");
//			MemberDTO dto2 = viewMember(dto.getUserid());
//			System.out.println("dto2 출력 : "+dto2);
//			
//			//setAttribute (������,��)
//			session.setAttribute("userid", dto.getUserid());
//			session.setAttribute("name", dto2.getName());
//			System.out.println(session.getAttribute("userid"));
//			System.out.println(session.getAttribute("name"));
//		}
//		
//		return result;
		return memberDao.loginCheck(dto);
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

}
