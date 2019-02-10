package com.example.spring02.model.member.dto;

import java.util.Date;

public class MemberDTO {
	private String userid;
	private String passwd;
	private String name;
	private String email;
	private Date join_date; 
	private String address1;
	private String address2;
	private Date updatesys;
	private String zipcode;
	private String passwd_check;
	// getter,setter, toString(), �⺻������
	
	
	
	public MemberDTO() {
		// TODO Auto-generated constructor stub
	}



	public String getUserid() {
		return userid;
	}



	public void setUserid(String userid) {
		this.userid = userid;
	}



	public String getPasswd() {
		return passwd;
	}



	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getEmail() {
		return email;
	}



	public void setEmail(String email) {
		this.email = email;
	}



	public Date getJoin_date() {
		return join_date;
	}



	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}



	public String getAddress1() {
		return address1;
	}



	public void setAddress1(String address1) {
		this.address1 = address1;
	}



	public String getAddress2() {
		return address2;
	}



	public void setAddress2(String address2) {
		this.address2 = address2;
	}



	public Date getUpdatesys() {
		return updatesys;
	}



	public void setUpdatesys(Date updatesys) {
		this.updatesys = updatesys;
	}



	public String getZipcode() {
		return zipcode;
	}



	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}



	public String getPasswd_check() {
		return passwd_check;
	}



	public void setPasswd_check(String passwd_check) {
		this.passwd_check = passwd_check;
	}



	@Override
	public String toString() {
		return "MemberDTO [userid=" + userid + ", passwd=" + passwd + ", name=" + name + ", email=" + email
				+ ", join_date=" + join_date + ", address1=" + address1 + ", address2=" + address2 + ", updatesys="
				+ updatesys + ", zipcode=" + zipcode + ", passwd_check=" + passwd_check + "]";
	}


	

}
