package com.get.security.service;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Account implements UserDetails {
   private String email;
   private String nickname;
   private String password;
   private String username;
   private String birth;
   private String phone;
   private String mem_idx;
   private String address1;
   private String address2;
   private int postnumber;
   private String com_date;
   private String user_grant;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
        auth.add(new SimpleGrantedAuthority("ROLE_"+this.user_grant));
        return auth;
    }

    @Override
    public String getPassword() {
        return this.password;
    }

    @Override
    public String getUsername() {
        return this.email;
    }

    @Override
    public boolean isAccountNonExpired() { // 계정이 만료되었는지 여부를 리턴한다
        return true;
    }

    @Override
    public boolean isAccountNonLocked() { // 계정이 잠겼는지 여부를 리턴한다
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() { // 계정 보안정보가 만료되었는지를 리턴한다
        return true;
    }

    @Override
    public boolean isEnabled() { //계정의 비활성화 여부를 리턴한다
        return true;
    }
}
