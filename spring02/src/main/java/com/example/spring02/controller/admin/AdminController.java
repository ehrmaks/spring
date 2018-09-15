package com.example.spring02.controller.admin;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring02.model.admin.dto.AdminDTO;
import com.example.spring02.model.member.dto.MemberDTO;
import com.example.spring02.service.admin.AdminService;
import com.example.spring02.service.member.MemberService;

@Controller
@RequestMapping("admin/*") //공통적인 url mapping
public class AdminController {
	@Inject //의존관계 주입
	AdminService adminService; 
	
	@Inject
	MemberService memberService;
	
	@RequestMapping("admin.do")
	public ModelAndView admin(ModelAndView mav) {
		mav.setViewName("admin/admin");
		
		return mav;
	}
	
	@RequestMapping("login.do") //세부적인 url mapping
	public String login() {
		return "admin/login"; //views/admin/login.jsp로 이동
	}
	
	@RequestMapping("login_check.do")
	public ModelAndView login_check(AdminDTO dto
			, MemberDTO dto2 ,HttpSession session, ModelAndView mav) {
		
		String name = adminService.loginCheck(dto); //로그인 체크
		String name2 = memberService.loginCheck(dto2);
		if(name != null) { //로그인 성공=>세션변수 저장
			//관리자용 세션변수
			session.setAttribute("admin_userid", dto.getUserid());
			session.setAttribute("admin_name", name);
			//일반 사용자용 세션변수
			session.setAttribute("userid", dto2.getUserid());
			session.setAttribute("name", name2);
			mav.setViewName("admin/admin"); //admin.jsp로 이동
		}else{ //로그인 실패
			mav.setViewName("admin/login"); //login.jsp로 이동
			mav.addObject("message","error");
		}
		return mav;
	}
	
	@RequestMapping("logout.do")
	public ModelAndView logout(HttpSession session, ModelAndView mav) {
		adminService.logout(session);
		
		mav.setViewName("admin/login");
		mav.addObject("message", "logout");
		
		//관리자 로그인 페이지로 이동
		return mav;
	}
	
	@RequestMapping("join.do")
	public String join(AdminDTO dto) {
		return "admin/join";
	}
	
	@RequestMapping("join_check.do")
	public String join_check(AdminDTO dto) {
		adminService.insert(dto);
		return "admin/login";
	}
}















