package com.example.spring02.model.admin.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.spring02.model.admin.dto.AdminDTO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public String loginCheck(AdminDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("admin.login_check", dto);
	}

	@Override
	public void insert(AdminDTO dto) {
		sqlSession.insert("admin.insert", dto);
	}

}
