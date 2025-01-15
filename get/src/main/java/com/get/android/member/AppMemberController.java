// └─ com/get/android/member/AppMemberController.java
package com.get.android.member;

import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/Member")
@RequiredArgsConstructor
public class AppMemberController {

    private final AppMemberService service;

    /**
     * 회원가입
     * POST /Member/Join
     * Body(JSON): MemberDTO
     */
    @PostMapping("/Join")
    public ResponseEntity<Map<String, Object>>  join(@RequestBody MemberDTO dto) {
    	System.out.println("join:"+dto.getAddress1());
    	Map<String, Object> response = new HashMap<>();
    	// 이메일 중복 체크
        if (service.emailExists(dto.getEmail())) {
            response.put("success", false);
        }
        else {
        	// 가입 처리
            service.join(dto);
            response.put("success", true);
		}
        
        return ResponseEntity.ok(response);
    }

    /**
     * 로그인
     * POST /Member/Login
     * Body(JSON): { email, password }
     */
    @PostMapping("/Login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody Map<String, String> loginRequest) {
        String email = loginRequest.get("email");
        String password = loginRequest.get("password");

        boolean isAuthenticated = service.login(email, password);

        Map<String, Object> response = new HashMap<>();
        if (isAuthenticated) {
            response.put("success", true);
            response.put("message", "로그인 성공");
        } else {
            response.put("success", false);
            response.put("message", "아이디/비밀번호를 확인하세요.");
        }

        return ResponseEntity.ok(response);
    }
}