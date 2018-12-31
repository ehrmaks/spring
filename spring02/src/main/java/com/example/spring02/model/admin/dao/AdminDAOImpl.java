package com.example.spring02.model.admin.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.spring02.model.member.dto.MemberDTO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Inject
	SqlSession sqlSession;

	@Override
	public String loginCheck(MemberDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("admin.login_check", dto);
	}

	@Override
	public void insert(MemberDTO dto) {
		sqlSession.insert("admin.insert", dto);
	}

	@Override
	public MemberDTO viewMember(String userid) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("admin.viewMember", userid);
	}

	@Override
	public void update(MemberDTO dto) {
		sqlSession.update("admin.update", dto);
	}

	@Override
	public void delete(MemberDTO dto) {
		sqlSession.delete("admin.delete", dto);
	}

	@Override
	public int idCheck(String userid) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("admin.idcheck", userid);
	}

	@Override
	public String pwCheck(String userid) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("admin.pw_check", userid);
	}

}
