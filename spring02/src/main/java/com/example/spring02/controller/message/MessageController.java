package com.example.spring02.controller.message;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring02.model.message.dto.MessageDTO;
import com.example.spring02.service.message.MessageService;

@RestController
@RequestMapping("messages/*")
public class MessageController {
	@Inject
	MessageService messageService;
	
	@RequestMapping(value="/write.do", 
			method=RequestMethod.GET)
	public ModelAndView write() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/messages/write");
		return mav;
	}
	
	@RequestMapping(value="send.do", method=RequestMethod.POST)
	public ResponseEntity<String> addMessage(
			@RequestBody MessageDTO dto) {
				
		ResponseEntity<String> entity = null;
		System.out.println("=================");
		System.out.println(dto.getTargetid());
		System.out.println(dto.getSender());
		System.out.println(dto.getMessage());
		System.out.println("=================");
		try {
			messageService.addMessage(dto);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(),
					HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
