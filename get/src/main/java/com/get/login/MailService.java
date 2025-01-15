package com.get.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

import java.io.UnsupportedEncodingException;
import java.util.Random;

@Service
public class MailService {
	
	@Autowired
	private JavaMailSender javaMailSender;
	@Value("${spring.mail.username}")
	private String senderEmail; // 발송할 이메일 주소

    // 생성자 주입
    public MailService(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    // 랜덤 인증 코드 생성
    public String createNumber() {
        Random random = new Random();
        StringBuilder key = new StringBuilder();

        for (int i = 0; i < 8; i++) {
            int index = random.nextInt(3);

            switch (index) {
                case 0 -> key.append((char) (random.nextInt(26) + 97)); // 소문자
                case 1 -> key.append((char) (random.nextInt(26) + 65)); // 대문자
                case 2 -> key.append(random.nextInt(10)); // 숫자
            }
        }
        return key.toString();
    }

    // 이메일 내용 및 발송 설정
    public MimeMessage createMail(String mail, String number) throws MessagingException, UnsupportedEncodingException {
        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);

        System.out.println("=====================senderEmail:"+senderEmail);
        message.setFrom(senderEmail);
        helper.setTo(mail); // 수신자 이메일
        helper.setFrom(senderEmail, "find_get_it");
        helper.setSubject("이메일 인증");
        String body = "<h3>요청하신 인증 번호입니다.</h3><h1>" + number + "</h1><h3>감사합니다.</h3>";
        message.setText(body, "UTF-8", "html"); // 이메일 본문
        return message;
    }

    // 이메일 발송
    public String sendKeyMail(String sendEmail) throws MessagingException, UnsupportedEncodingException {
        String number = createNumber(); // 랜덤 인증번호 생성

        MimeMessage message = createMail(sendEmail, number); // 메일 내용 설정
        try {
        	System.out.println("=================message:"+message);
            javaMailSender.send(message); // 메일 발송
            System.out.println("hi");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("메일 발송 실패: "+ e.getMessage());
        }

        return number; // 인증번호 반환
    }
}