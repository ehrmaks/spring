package com.example.spring02.controller.member;


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
	BCryptPasswordEncoder bcryptPasswordEncoder;


	@RequestMapping("join.do")
	public String address() {
		return "member/join";
	}
	
	
	@RequestMapping("join_check.do")
	public String join_check(MemberDTO dto) {
		String passwd = bcryptPasswordEncoder.encode(dto.getPasswd());
		dto.setPasswd(passwd);
		memberService.insert(dto);
		return "member/login";
	}
	
	@RequestMapping("login.do") //세부적인 url 매핑
	public String login(HttpSession session) {
		String userid = (String) session.getAttribute("userid");
		
		if(userid != null) {
			
			return "home";
		} else {
			
			return "member/login"; // login.jsp로 이동
		}
		
	}
	
	@RequestMapping("login_check.do")
	public ModelAndView login_check(MemberDTO dto, HttpSession session, ModelAndView mav) {

		String pw = dto.getPasswd();
		logger.info("암호화 되지 않은 암호 : " + pw);
		String pw2 = memberDao.pwCheck(dto.getUserid());
		logger.info("암호화 된 암호 : " + pw2);
		
		
		if(bcryptPasswordEncoder.matches(pw, pw2)) {
			logger.info("비밀번호 일치");
			dto.setPasswd(pw2);
			Boolean result = memberService.loginCheck(dto, session);
			if(result) { //로그인 성공
//				mav.setViewName("member/member");
				mav.setViewName("home");
			}
		} else {
			logger.info("비밀번호 불일치");
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
		String passwd = bcryptPasswordEncoder.encode(dto.getPasswd());
		dto.setPasswd(passwd);
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
	
	@RequestMapping(value="/secession.do")
	public ModelAndView secession(@ModelAttribute MemberDTO dto, HttpSession session
			, HttpServletResponse response, ModelAndView mav) throws Exception {
		String pw = dto.getPasswd_check();
		logger.info("암호화 되지않은 암호 : " + pw);
		String userid = (String) session.getAttribute("userid");
		String pw2 = memberDao.pwCheck(userid);
		logger.info("암호화 된 암호 : " + pw2);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		
		if (bcryptPasswordEncoder.matches(pw, pw2)) {
			logger.info("암호화 된 pw2 : " + pw2 + "인증성공!");
			memberService.delete(dto);
			memberService.logout(session);
			mav.setViewName("member/login");
			mav.addObject("message", "secession");
			return mav;
		} else {
			logger.info("인증 실패!ㅠㅠ");
			out.println("<script>alert('비밀번호가 맞지 않습니다.');</script>");
			out.flush();
			MemberDTO dto2 = memberDao.viewMember(userid);
			mav.addObject("dto", dto2);
			mav.setViewName("member/view");
			return mav;
		}
	}
	
	@RequestMapping(value="/idcheck", method=RequestMethod.POST,
			produces = "application/json")
	@ResponseBody
	public Map<Object, Object> idCheck(@RequestBody String userid) {
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		count = memberService.idCheck(userid);
		map.put("cnt", count);
		
		return map;
	}
	
	@RequestMapping("mypage.do")
	public ModelAndView myPage(ModelAndView mav, HttpSession session) {
		
		String userid = (String) session.getAttribute("userid");
		String name = (String) session.getAttribute("name");
		System.out.println("######## name : " + name);
		int total_amount = memberDao.total_amount(userid); // 총 주문액수
		int point = memberDao.point(userid); // 총 적립금 (주문액수 1000원당 50point 적립)
		int use_point = 0; // 사용 적립금
		int available = point-use_point; // 가용 적립금
		int coupon = 1; // 쿠폰 수
		String rating = memberDao.rating(userid);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("rating", rating);
		map.put("total_amount", total_amount);
		map.put("point", point);
		map.put("available", available);
		map.put("use_point", use_point);
		map.put("coupon", coupon);
		map.put("name", name);
		mav.addObject("map", map);
		mav.setViewName("member/mypage");
		
		return mav;
	}
	
}









