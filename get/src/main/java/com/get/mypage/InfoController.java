package com.get.mypage;


import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.get.security.service.Account;

@RestController
@RequestMapping("/Mypage/InfoUpdate")
public class InfoController {

    private final InfoService infoService;

    @GetMapping("/PwCheck")
    public boolean pwCheck(@AuthenticationPrincipal Account user, @RequestParam String checkPw) {
        String member_id = user.getUsername();
        return infoService.checkPw(member_id, checkPw);
    }
}

