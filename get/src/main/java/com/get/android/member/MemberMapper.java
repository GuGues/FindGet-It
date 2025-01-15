// └─ com/get/android/member/MemberMapper.java
package com.get.android.member;

import org.apache.ibatis.annotations.*;

@Mapper
public interface MemberMapper {

    @Select("SELECT * FROM MEMBERS WHERE EMAIL = #{email}")
    Member findByEmail(String email);

    @Insert({
            "INSERT INTO MEMBERS (",
            "    EMAIL, NICKNAME, PASSWORD, USERNAME, BIRTH, PHONE, ADDRESS1, ADDRESS2, POSTNUMBER, USER_GRANT",
            ") VALUES (",
            "    #{email}, #{nickname}, #{password}, #{username}, #{birth}, #{phone}, ",
            "    #{address1}, #{address2}, #{postnumber}, 'USER'",
            ")"
    })
    void insertMember(Member mem);
}