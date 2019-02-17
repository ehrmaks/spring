package com.example.spring02.controller.member;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring02.model.member.dao.MemberDAO;
import com.example.spring02.model.member.dto.MemberDTO;
import com.example.spring02.service.member.MemberService;
import com.example.spring02.util.JsonStringParse;
import com.example.spring02.util.NaverLoginBO;
import com.github.scribejava.core.model.OAuth2AccessToken;


@Controller
public class NaverController {

	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	@Inject
	MemberDAO memberDao;
	
	@Inject
	MemberService memberService;

	@RequestMapping(value = "/naverlogin", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {

		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		//	https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=pjZHYEmlxwEBKjlUEjCh&redirect_uri=https%3A%2F%2Ftest.kjsfk.com%2Fcallback.do&state=41aee9b4-faff-4b65-9e93-ec9c5c93097d
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("네이버:" + naverAuthUrl);

		// 네이버
		model.addAttribute("url", naverAuthUrl);

		/* 생성한 인증 URL을 View로 전달 */
		return "member/naverlogin";
	}

	// 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException {
		System.out.println("여기는 callback");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		System.out.println(naverLoginBO.getUserProfile(oauthToken).toString());
		model.addAttribute("result", apiResult);
		System.out.println("result" + apiResult);
		/* 네이버 로그인 성공 페이지 View 호출 */
		JsonStringParse jsonparse = new JsonStringParse();
		JSONObject jsonobj = jsonparse.stringToJson(apiResult, "response");
		String id = jsonparse.JsonToString(jsonobj, "id");
		String name = jsonparse.JsonToString(jsonobj, "name");
		String email = jsonparse.JsonToString(jsonobj, "email");
		System.out.println("memberDTO : { id : " + id + " name : " + name + " email = " + email + " }");

		MemberDTO dto = new MemberDTO();
		dto.setUserid("naver" + id);
		dto.setName(name);
		dto.setEmail(email);
		
		String userid = dto.getUserid();
		String userid2 = memberDao.kakaoJoinCheck(userid);
		
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		
		if(userid.equals(userid2)) { // 가입되어있다면 로그인 체크 진행
			Boolean result = memberService.kakoLoginCheck(dto, session);
			if(result) {
				mav.setViewName("home");
			}
		} else { // 가입되어있지않다면 추가정보 기입 후 가입 진행
			map.put("userid", dto.getUserid());
			map.put("name", dto.getName());
			map.put("email", dto.getEmail());
			mav.addObject("map", map);
			mav.setViewName("member/naverjoin");
		}
		
		return mav;
	}
	
/*	@RequestMapping(value="/insert_naver")
	public ModelAndView insert(MemberDTO dto, HttpSession session, ModelAndView mav) {
		String email = dto.getEmail();
		String userid = dto.getUserid();
		String name = dto.getName();
		System.out.println("memberDTO : { id : " + userid + " name : " + name + " email = " + email + " }");
		
		String userid2 = memberDao.kakaoJoinCheck(userid);
		
		if(userid.equals(userid2)) { // 가입되어있다면,
			session.setAttribute("userid", userid);
			session.setAttribute("name", name);
			mav.setViewName("home");
		} else { // 가입되어있지않다면
			
		}
		
		return mav;
	}*/

}
