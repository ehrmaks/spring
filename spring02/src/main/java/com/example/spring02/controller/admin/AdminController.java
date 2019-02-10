package com.example.spring02.controller.admin;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring02.controller.member.MemberController;
import com.example.spring02.model.admin.dao.AdminDAO;
import com.example.spring02.model.member.dto.MemberDTO;
import com.example.spring02.service.admin.AdminService;
import com.example.spring02.service.member.MemberService;

@Controller
@RequestMapping("admin/*") //공통적인 url mapping
public class AdminController {
	//로깅을 위한 변수
		private static final Logger logger=
				LoggerFactory.getLogger(MemberController.class);
	
	@Inject //의존관계 주입
	AdminService adminService; 
	@Inject
	BCryptPasswordEncoder bcryptPasswordEncoder;
	@Inject
	MemberService memberService;
	@Inject
	AdminDAO adminDao;
	
	
	@RequestMapping("login.do") //세부적인 url mapping
	public String login(HttpSession session) {
		String userid = (String) session.getAttribute("userid");
		
		if(userid != null) {
			return "home";
		} else {
			return "admin/login"; //views/admin/login.jsp로 이동
		}
	}
	@RequestMapping("adminhome.do")
	public String adminHome() {
		return "admin/admin";
	}
	
	@RequestMapping("login_check.do")
	public ModelAndView login_check(MemberDTO dto ,HttpSession session, ModelAndView mav) {
		
		String pw = dto.getPasswd();
		String pw2 = adminDao.pwCheck(dto.getUserid());
		
		if(bcryptPasswordEncoder.matches(pw, pw2)) {
			logger.info("비밀번호 일치");
			dto.setPasswd(pw2);
			String name = adminService.loginCheck(dto); //로그인 체크
			
			if(name != null) { //로그인 성공=>세션변수 저장
				//관리자용 세션변수
				session.setAttribute("admin_userid", dto.getUserid());
				session.setAttribute("admin_name", name);
				// 일반 사용자 세션변수
				session.setAttribute("userid", dto.getUserid());
				session.setAttribute("name", name);
				mav.setViewName("home"); //admin.jsp로 이동
			}
		}else { //로그인 실패
			logger.info("비밀번호 불일치");
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
	public String join(MemberDTO dto) {
		return "admin/join";
	}
	
	@RequestMapping("join_check.do")
	public String join_check(MemberDTO dto) {
		String passwd = bcryptPasswordEncoder.encode(dto.getPasswd());
		dto.setPasswd(passwd);
		adminService.insert(dto);
		return "admin/login";
	}
	
	@RequestMapping("{userid}/form")
	public ModelAndView updateForm(@PathVariable String userid, ModelAndView mav) {
		if(userid == null) {
			throw new IllegalArgumentException("사용자 아이디는 null입니다.");
		}
		MemberDTO dto = adminDao.viewMember(userid);
		mav.addObject("dto", dto);
		mav.setViewName("admin/view");
		return mav;
	}
	
	@RequestMapping("admin.do")
	public String view(@ModelAttribute MemberDTO dto) {
		String passwd = bcryptPasswordEncoder.encode(dto.getPasswd());
		dto.setPasswd(passwd);
		adminService.update(dto);
		return "admin/admin";
	}
	
	@RequestMapping("delete.do")
	public ModelAndView delete(String userid, ModelAndView mav) {
		MemberDTO dto = adminDao.viewMember(userid);
		mav.addObject("dto", dto);
		mav.setViewName("admin/delete");
		return mav;
	}
	
	@RequestMapping("secession.do")
	public ModelAndView secession(@ModelAttribute MemberDTO dto,
			HttpSession session, HttpServletResponse response, ModelAndView mav) throws Exception {
		String pw = dto.getPasswd_check();
		logger.info("암호화 안됨 : " + pw);
		String userid = (String) session.getAttribute("userid");
		String pw2 = adminDao.pwCheck(userid);
		logger.info("암호화 됨 : " + pw2);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if(bcryptPasswordEncoder.matches(pw, pw2)) {
			logger.info("암호화 된 것 : "+ pw2 + "인증성공!");
			adminService.delete(dto);
			adminService.logout(session);
			mav.setViewName("admin/login");
			mav.addObject("message", "secession");
			return mav;
		} else {
			logger.info("인증 실패!");
			out.println("<script>alert('비밀번호가 맞지 않습니다.');</script>");
			out.flush();
			MemberDTO dto2 = adminDao.viewMember(userid);
			mav.addObject("dto", dto2);
			mav.setViewName("admin/view");
			return mav;
		}
	}
	
	@RequestMapping(value="/idcheck", method=RequestMethod.POST,
			produces="application/json") 
	@ResponseBody
	public Map<Object, Object> idCheck(@RequestBody String userid) {
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		count = adminService.idCheck(userid);
		map.put("cnt", count);
		
		return map;
	}
}















