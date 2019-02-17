package com.example.spring02.controller.member;


import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring02.model.member.dao.MemberDAO;
import com.example.spring02.model.member.dto.MemberDTO;
import com.example.spring02.service.member.MemberService;
import com.example.spring02.util.KakaoAccessToken;
import com.fasterxml.jackson.databind.JsonNode;

@Controller
public class KakaoController {
	
	@Inject
	MemberDAO memberDao;
	@Inject
	MemberService memberService;
	
	@RequestMapping(value="/kakaologin", produces="application/json", 
			method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView kakaologin (@RequestParam("code") String code, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session, ModelAndView mav) {
		
		System.out.println("code : " + code);
		KakaoAccessToken kakaoAccess = new KakaoAccessToken();
		JsonNode node = kakaoAccess.getAccessToken(code);
		System.out.println("node : " + node);
		
		String token = node.get("access_token").toString();
		
		JsonNode profile = kakaoAccess.getKakaoUserInfo(node.path("access_token").toString());
		System.out.println("프로필 : " + profile); 
		MemberDTO dto = kakaoAccess.changeData(profile);
		dto.setUserid("kakao"+dto.getUserid());
		
		String userid = dto.getUserid();
		String name = dto.getName();
		String userid2 = memberDao.kakaoJoinCheck(userid);
		
		Map<String, Object> map = new HashMap<>();
		
		if(userid.equals(userid2)) { // 가입되어있다면 로그인 체크 진행
			Boolean result = memberService.kakoLoginCheck(dto, session);
			if(result) {
				mav.setViewName("home");
			}
		} else { // 가입되어있지않다면 추가정보 기입 후 가입 진행
			map.put("userid", dto.getUserid());
			map.put("name", dto.getName());
			mav.addObject("map", map);
			mav.setViewName("member/kakaojoin");
		}
		return mav;
	}
	
	@RequestMapping("kakao_insert.do")
	public String kakaoInsert(MemberDTO dto, HttpSession session) {
		memberDao.kakaoInsert(dto);
		session.setAttribute("userid", dto.getUserid());
		session.setAttribute("name", dto.getName());
		
		return "home";
	}
	
}
