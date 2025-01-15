// └─ com/get/android/member/MemberMapper.java
package com.get.android.member;

import org.apache.ibatis.annotations.*;

@Mapper
public interface MemberMapper {

    @Select("SELECT * FROM MEMBERS WHERE EMAIL = #{email}")
    Member findByEmail(String email);

    @Insert({
            "INSERT INTO MEMBERS (",
            "    EMAIL, NICKNAME, PASSWORD, USERNAME, BIRTH, PHONE, MEM_IDX, ADDRESS1, ADDRESS2, POSTNUMBER, COM_DATE",
            ") VALUES (",
            "    #{email}, #{nickname}, #{password}, #{username}, #{birth}, #{phone}, ",
            "    (SELECT 'MB' || LPAD(NVL(MAX(SUBSTR(mem_idx, 3)), '0')+1, 7, '0') FROM MEMBERS),",
            "    #{address1}, #{address2}, #{postnumber}, SYSDATE",
            ")"
    })
    void insertMember(Member mem);
}