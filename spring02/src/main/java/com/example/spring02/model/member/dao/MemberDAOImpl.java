package com.example.spring02.model.member.dao;


import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.spring02.model.member.dto.MemberDTO;
import com.example.spring02.model.shop.dto.CartDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public Boolean loginCheck(MemberDTO dto) {
		String name = sqlSession.selectOne("member.login_check", dto);
		
		return (name==null) ? false : true;
	}

	@Override
	public MemberDTO viewMember(String userid) {
		return sqlSession.selectOne("member.viewMember", userid);
	}
	
	public void insert(MemberDTO dto) {
		sqlSession.insert("member.insert", dto);
	}

	@Override
	public void update(MemberDTO dto) {
		sqlSession.update("member.update", dto);
	}

	@Override
	public void delete(MemberDTO dto) {
		sqlSession.delete("member.delete", dto);
	}

	@Override
	public int idCheck(String userid) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.idcheck", userid);
	}

	@Override
	public String pwCheck(String userid) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.pw_check", userid);
	}

	@Override
	public void amount(String userid, int point, int total_amount) {
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("point", point);
		map.put("total_amount", total_amount);
		
		sqlSession.update("member.update_amount", map);
	}

	@Override
	public int total_amount(String userid) {
		return sqlSession.selectOne("member.total_amount", userid);
	}

	@Override
	public int point(String userid) {
		return sqlSession.selectOne("member.point", userid);
	}

	@Override
	public String rating(String userid) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.rating", userid);
	}

	@Override
	public void updateRating(String userid, String rating) {
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("rating", rating);
		
		sqlSession.update("member.update_rating", map);
	}

	@Override
	public MemberDTO shopMember(String userid) {
		return sqlSession.selectOne("member.shop_member", userid);
	}

	@Override
	public String kakaoJoinCheck(String userid) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.kakao_join_check", userid);
	}

	@Override
	public Boolean kakaoLoginCehck(MemberDTO dto) {
		String name = sqlSession.selectOne("member.kakao_login_check", dto);
		return (name==null) ? false : true;
	}

	@Override
	public void kakaoInsert(MemberDTO dto) {
		sqlSession.insert("member.kakao_insert", dto);
	}
}
