// └─ com/get/android/member/Member.java
package com.get.android.member;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

/**
 * MEMBERS 테이블에 대응하는 VO
 */
@Data
public class Member {
    private String email;       // EMAIL
    private String nickname;    // NICKNAME
    private String password;    // PASSWORD (BCrypt)
    private String username;    // USERNAME
    private LocalDate birth;    // BIRTH
    private String phone;       // PHONE
    private String memIdx;      // MEM_IDX
    private String address1;    // ADDRESS1
    private String address2;    // ADDRESS2
    private int postnumber;     // POSTNUMBER
    private LocalDate comDate;  // COM_DATE
}
