package com.example.spring02.model.admin.dao;

import com.example.spring02.model.admin.dto.AdminDTO;

public interface AdminDAO {
	public String loginCheck(AdminDTO dto);
	public void insert(AdminDTO dto);
}
