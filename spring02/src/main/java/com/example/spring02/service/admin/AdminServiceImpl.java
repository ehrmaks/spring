package com.example.spring02.service.admin;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.example.spring02.model.admin.dao.AdminDAO;
import com.example.spring02.model.admin.dto.AdminDTO;
import com.example.spring02.model.member.dto.MemberDTO;

@Service
public class AdminServiceImpl implements AdminService {

	@Inject
	AdminDAO adminDao;
	
	@Override
	public String loginCheck(AdminDTO dto) {
		return adminDao.loginCheck(dto);
	}

	@Override
	public void insert(AdminDTO dto) {
		adminDao.insert(dto);
	}

	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}
	
	
	
	

}
