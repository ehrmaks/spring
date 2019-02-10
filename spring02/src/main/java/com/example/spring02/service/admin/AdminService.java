package com.example.spring02.service.admin;

import javax.servlet.http.HttpSession;

import com.example.spring02.model.member.dto.MemberDTO;

public interface AdminService {
	public String loginCheck(MemberDTO dto);
	public void insert(MemberDTO dto);
	public void logout(HttpSession session);
	public MemberDTO viewMember(String userid);
	public void update(MemberDTO dto);
	public void delete(MemberDTO dto);
	public int idCheck(String userid);
	
}
