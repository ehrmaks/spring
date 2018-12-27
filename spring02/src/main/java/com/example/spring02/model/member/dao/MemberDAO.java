package com.example.spring02.model.member.dao;

import com.example.spring02.model.member.dto.MemberDTO;

public interface MemberDAO {
	public String loginCheck(MemberDTO dto);
	public MemberDTO viewMember(String userid);
	public void insert(MemberDTO dto);
	public void update(MemberDTO dto);
}
