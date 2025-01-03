// └─ com/get/android/member/AppMemberService.java
package com.get.android.member;

import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
@RequiredArgsConstructor
public class AppMemberService {

    private final MemberMapper memberMapper;
    private final BCryptPasswordEncoder passwordEncoder;

    // 이메일 존재 여부
    public boolean emailExists(String email) {
        return (memberMapper.findByEmail(email) != null);
    }
    public boolean login(String email, String rawPassword) {
        Member member = memberMapper.findByEmail(email);
        if (member == null) {
            return false;
        }
        return passwordEncoder.matches(rawPassword, member.getPassword());
    }

    // 회원가입
    public void join(MemberDTO dto) {
        Member mem = new Member();
        mem.setEmail(dto.getEmail());
        mem.setNickname(dto.getNickname());
        mem.setUsername(dto.getUsername());
        mem.setBirth(dto.getBirth());
        mem.setPhone(dto.getPhone());
        mem.setAddress1(dto.getAddress1());
        mem.setAddress2(dto.getAddress2());
        mem.setPostnumber(dto.getPostnumber());
        // 비밀번호 BCrypt 해시
        mem.setPassword(passwordEncoder.encode(dto.getPassword()));
        // 가입일(comDate)은 DB에서 SYSDATE로 자동
        // mem_idx는 insertMember() 쿼리에서 생성
        memberMapper.insertMember(mem);
    }
}