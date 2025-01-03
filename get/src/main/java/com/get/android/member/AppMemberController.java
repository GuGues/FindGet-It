// └─ com/get/android/member/AppMemberController.java
package com.get.android.member;

import lombok.RequiredArgsConstructor;
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
    public String join(@RequestBody MemberDTO dto) {
        // 이메일 중복
        if(service.emailExists(dto.getEmail())) {
            return "이미 존재하는 이메일입니다.";
        }
        // 가입
        service.join(dto);
        return "가입 성공";
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