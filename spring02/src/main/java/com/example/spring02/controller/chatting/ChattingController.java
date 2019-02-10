package com.example.spring02.controller.chatting;


import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
//@RequestMapping("chatting/*")
public class ChattingController {
	
	
	@RequestMapping(value = "/chatting.do", method = RequestMethod.GET)
	private ModelAndView write(ModelAndView mav, HttpSession session) {
		mav.setViewName("chat/chattingview");
		
		// 사용자 정보 출력 세션
		//User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String userid = (String) session.getAttribute("userid");
		String username = (String) session.getAttribute("name");
		mav.addObject("userid", userid);
		mav.addObject("username", username);
		
		return mav;
	}
	
	
}
