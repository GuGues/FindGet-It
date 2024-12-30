package com.get.mypage;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
public class InfoService {

    private final MemberRepository memberRepository;
    private final BCryptPasswordEncoder encoder;

    public boolean checkPw(String id, String checkPw) {
        Member member = memberRepository.findById(id).orElseThrow(() ->
                new IllegalArgumentException("해당 회원이 존재하지 않습니다."));
        String realPassword = member.getPassword();
        return encoder.matches(checkPw, realPassword);
    }

}