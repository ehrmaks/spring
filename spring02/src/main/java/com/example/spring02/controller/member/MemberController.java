package com.example.spring02.controller.member;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
	
	@RequestMapping("join.do")
	public String address() {
		return "member/join";
	}
	
	@RequestMapping("join_check.do")
	public String join_check(MemberDTO dto) {
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
		System.out.println("컨트롤러에서 login체크중.");
		String result = memberService.loginCheck(dto);
//		ModelAndView mav = new ModelAndView();
		if(result != null) { //로그인 성공
//			System.out.println("home");
//			mav.setViewName("home"); //뷰의 이름
			session.setAttribute("userid", dto.getUserid());
			session.setAttribute("name", result);
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
	
}









