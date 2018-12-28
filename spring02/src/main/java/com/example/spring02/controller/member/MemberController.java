package com.example.spring02.controller.member;


import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
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

import com.example.spring02.model.member.dao.MemberDAO;
import com.example.spring02.model.member.dto.MemberDTO;
import com.example.spring02.service.member.MemberService;

@Controller //컨트롤러 빈으로 등록
@RequestMapping("member/*") //공통적인 url 매핑
public class MemberController {

	//로깅을 위한 변수
	private static final Logger logger=
			LoggerFactory.getLogger(MemberController.class);
	@Inject
	MemberService memberService;
	@Inject
	MemberDAO memberDao;
	@Inject
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping("join.do")
	public String address() {
		return "member/join";
	}
	
	@RequestMapping("join_check.do")
	public String join_check(MemberDTO dto) {
		String passwd = passwordEncoder.encode(dto.getPasswd());
		dto.setPasswd(passwd);
		memberService.insert(dto);
		return "member/login";
	}
	
	@RequestMapping("login.do") //세부적인 url 매핑
	public String login() {
		return "member/login"; // login.jsp로 이동
	}
	
	@RequestMapping("login_check.do")
	public ModelAndView login_check(
			MemberDTO dto, HttpSession session, ModelAndView mav) {
		//로그인 성공 true, 실패 false
		String result = memberService.loginCheck(dto);
		if(result != null) { //로그인 성공
			
			session.setAttribute("userid", dto.getUserid());
			session.setAttribute("name", result);
			
			//mav.addObject("timeout", timeout);
			mav.setViewName("member/member");
		}else { //로그인 실패
			mav.setViewName("member/login");
			//뷰에 전달할 값
			mav.addObject("message", "error");
		}
		return mav;
	}
	
	@RequestMapping("logout.do")
	public ModelAndView logout(
			HttpSession session,ModelAndView mav) {
		//세션 초기화
		memberService.logout(session);
		// login.jsp로 이동
		mav.setViewName("member/login");
		mav.addObject("message","logout");
		return mav;
	}
	
	@RequestMapping("{userid}/form")
	public ModelAndView updateForm(@PathVariable String userid, ModelAndView mav) {
		if(userid == null) {
			throw new IllegalArgumentException("사용자 아이디는 null 입니다.");
		}
		MemberDTO dto = memberDao.viewMember(userid);
		mav.addObject("dto", dto);
		mav.setViewName("member/view");
		
		return mav;
	}
	
	@RequestMapping("member.do")
	public String view(@ModelAttribute MemberDTO dto) {
		memberService.update(dto);
		
		return "member/member";
	}
	
	@RequestMapping("delete.do")
	public ModelAndView delete(String userid, ModelAndView mav) {
		MemberDTO dto = memberDao.viewMember(userid);
		mav.addObject("dto", dto);
		mav.setViewName("member/delete");
		return mav;
	}
	
	@RequestMapping("secession.do")
	public String secession(@ModelAttribute MemberDTO dto, HttpSession session) {
		
		memberService.delete(dto);
		memberService.logout(session);
		return "member/login";
	}
	
	@RequestMapping(value="/idcheck", method=RequestMethod.POST,
			produces = "application/json")
	@ResponseBody
	public Map<Object, Object> idCheck(@RequestBody String userid) {
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		count = memberService.idCheck(userid);
		System.out.println("count : " + count);
		map.put("cnt", count);
		
		return map;
	}
	
}









