package com.example.spring02.service.email;

import com.example.spring02.model.email.dto.EmailDTO;

public interface EmailService {
	public void sendMail(EmailDTO dto);
}
