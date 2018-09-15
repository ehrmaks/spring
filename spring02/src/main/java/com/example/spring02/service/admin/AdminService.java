package com.example.spring02.service.admin;

import javax.servlet.http.HttpSession;

import com.example.spring02.model.admin.dto.AdminDTO;

public interface AdminService {
	public String loginCheck(AdminDTO dto);
	public void insert(AdminDTO dto);
	public void logout(HttpSession session);
	
}
