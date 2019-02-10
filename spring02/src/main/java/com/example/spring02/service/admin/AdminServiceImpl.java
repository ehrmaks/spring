package com.example.spring02.service.admin;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.example.spring02.model.admin.dao.AdminDAO;
import com.example.spring02.model.member.dto.MemberDTO;

@Service
public class AdminServiceImpl implements AdminService {

	@Inject
	AdminDAO adminDao;
	
	@Override
	public String loginCheck(MemberDTO dto) {
		return adminDao.loginCheck(dto);
	}

	@Override
	public void insert(MemberDTO dto) {
		adminDao.insert(dto);
	}

	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}

	@Override
	public MemberDTO viewMember(String userid) {
		// TODO Auto-generated method stub
		return adminDao.viewMember(userid);
	}

	@Override
	public void update(MemberDTO dto) {
		adminDao.update(dto);
		
	}

	@Override
	public void delete(MemberDTO dto) {
		adminDao.delete(dto);
	}

	@Override
	public int idCheck(String userid) {
		// TODO Auto-generated method stub
		return adminDao.idCheck(userid);
	}
	
	
	
	

}
