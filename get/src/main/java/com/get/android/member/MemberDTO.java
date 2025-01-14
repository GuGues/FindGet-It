// └─ com/get/android/member/MemberDTO.java
package com.get.android.member;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

/**
 * 가입/로그인 시 사용하는 DTO
 */
@Getter
@Setter
public class MemberDTO {
    // 로그인 시 사용
    private String email;
    private String password;

    // 가입 시 추가
    private String nickname;
    private String username;
    private LocalDate birth;
    private String phone;
    private String address1;
    private String address2;
    private int postnumber;
}