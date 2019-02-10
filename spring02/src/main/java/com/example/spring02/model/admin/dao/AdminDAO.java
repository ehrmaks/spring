package com.example.spring02.model.admin.dao;

import com.example.spring02.model.member.dto.MemberDTO;

public interface AdminDAO {

	public String loginCheck(MemberDTO dto);
	public void insert(MemberDTO dto);
	public MemberDTO viewMember(String userid);
	public void update(MemberDTO dto);
	public void delete(MemberDTO dto);
	public int idCheck(String userid);
	public String pwCheck(String userid);
}
