package com.example.spring02.model.member.dao;

import java.util.List;
import java.util.Map;

import com.example.spring02.model.member.dto.MemberDTO;
import com.example.spring02.model.shop.dto.CartDTO;

public interface MemberDAO {
	public Boolean loginCheck(MemberDTO dto);
	public MemberDTO viewMember(String userid);
	public void insert(MemberDTO dto);
	public void update(MemberDTO dto);
	public void delete(MemberDTO dto);
	public int idCheck(String userid);
	public String pwCheck(String userid);
	public void amount(String userid, int point, int total_amount);
	public int total_amount(String userid);
	public int point(String userid);
	public String rating(String userid);
}
