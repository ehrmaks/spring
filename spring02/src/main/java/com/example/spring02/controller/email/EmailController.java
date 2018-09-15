package com.example.spring02.controller.email;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.spring02.model.email.dto.EmailDTO;
import com.example.spring02.service.email.EmailService;

@Controller
@RequestMapping("email/*")
public class EmailController {
	
	@Inject
	EmailService emailService;
	
	@RequestMapping("write.do")
	private String write() {
		return "/email/write";
	}
	
	@RequestMapping("send.do")
	private String send(@ModelAttribute EmailDTO dto, Model model) {
		try {
			emailService.sendMail(dto);
			model.addAttribute("message", "이메일이 발송되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "이메일 발송 실패...");
		}
		return "/email/write";
	}
}
