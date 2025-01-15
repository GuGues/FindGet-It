package com.get.login;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.jsp.jstl.sql.Result;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/email")
public class mailController {
	
	private final MailService mailService;
	
	// 생성자 주입
    public mailController(MailService mailService) {
        this.mailService = mailService;
    }

    @PostMapping("/check")
    public ResponseEntity<Map<String, Object>> emailCheck(@RequestBody @Validated MailDTO mailDTO) throws Exception {
        // 이메일을 받으면 메일 서비스에서 메일 발송
        String email = mailDTO.getEmail();
        //System.out.println("================email:"+email); //email:user1@example.com
        //String key = mailService.createNumber();
        //MimeMessage message = mailService.createMail(email, key);
        Map<String, Object> result = new HashMap<>();
        
        try {
            String key = mailService.sendKeyMail(email); // 메일 발송
            result.put("status", HttpStatus.OK);
            result.put("key", key); // 인증번호를 반환
        }
        catch (Exception e) {
            result.put("status", HttpStatus.BAD_REQUEST); // 오류가 발생하면 BAD_REQUEST 상태 코드
            result.put("result", "메일 발송 실패: " + e.getMessage()); // 오류 메시지
        }
        
        return ResponseEntity.ok().body(result); // 이메일로 인증번호를 발송
    }
}
