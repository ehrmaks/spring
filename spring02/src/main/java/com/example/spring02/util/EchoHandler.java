package com.example.spring02.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.example.spring02.model.admin.dao.AdminDAO;
import com.example.spring02.model.member.dao.MemberDAO;
import com.example.spring02.model.member.dto.MemberDTO;

public class EchoHandler extends TextWebSocketHandler {
	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	// 클라이언트와 연결 이후에 실행되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		// super.afterConnectionEstablished(session);
		sessionList.add(session);
		logger.info("{} 연결됨", session.getId());
	}
	
	// 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메소드 
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		//super.handleTextMessage(session, message);
		Map<String, Object> map = session.getAttributes();
		String userid = (String) map.get("userid");
		logger.info("@@@@ userid = " + userid + "@@@@");
		String name = (String) map.get("name");
		logger.info("@@@@ name = " + name + "@@@@");
		
		
		logger.info("{}로 부터 {} 받음", name, message.getPayload());
		
		for (WebSocketSession sess : sessionList) {
			sess.sendMessage(new TextMessage(name + ":" + message.getPayload() + ":" + userid));
		}
		
		
	}
	
	// 클라이언트와 연결을 끊었을 때 실행되는 메서드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		//super.afterConnectionClosed(session, status);
		sessionList.remove(session);
		logger.info("{} 연결 끊김", session.getId());
	}
	
	
}
