package com.get.mypage;


import com.get.security.service.AccountService;
import java.security.Principal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController

@RequestMapping("/Mypage/InfoUpdate")
public class InfoController {

    @Autowired
    private AccountService accountService;

    @GetMapping("/PwCheck")
    public ResponseEntity<Boolean> checkPassword(@RequestParam("checkPw") String checkPw, Principal principal) {
        if (principal == null) {
            return ResponseEntity.badRequest().body(false);  // 인증되지 않은 사용자의 경우
        }

        String email = principal.getName(); // 로그인된 사용자의 이메일 정보 가져오기
        System.out.println("checkPw 파라미터: " + checkPw); // 디버깅용 로그
        System.out.println("로그인 사용자: " + email);

        // 비밀번호 검증 로직
        boolean isPasswordCorrect = accountService.verifyPassword(email, checkPw);

        return ResponseEntity.ok(isPasswordCorrect);
    }

}
