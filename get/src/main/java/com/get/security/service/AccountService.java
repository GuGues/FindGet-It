package com.get.security.service;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AccountService implements UserDetailsService {

    private final UserMapper userMapper;
    private final BCryptPasswordEncoder encoder;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Account account = new Account();
        account.setEmail(email);
        account = userMapper.findUser(account);
        if(account != null){
            List<GrantedAuthority> authorities = new ArrayList();
            authorities.add(new SimpleGrantedAuthority( "ROLE_"+account.getUser_grant()));
            return new User(account.getEmail(), account.getPassword(), authorities);
        }
        return null;
    }

    @Transactional
    public boolean join(Account reg,String email, String passwd) {
        Account checkUser = new Account();
        checkUser.setEmail(email);

        if (userMapper.findUser(checkUser) != null){
            return false;
        }
        reg.setPassword(encoder.encode(passwd));
        userMapper.save(reg);
        return true;
    }
    @Transactional
    public boolean verifyPassword(String email, String inputPassword) {

        Account account = new Account();
        account.setEmail(email);
        account = userMapper.findUser(account);

        if (account == null) {
            System.out.println("User not found with email: " + email);
            return false;
        }
        // 입력된 비밀번호와 저장된 비밀번호 비교
        boolean match = encoder.matches(inputPassword, account.getPassword());
        System.out.println("Password match result: " + match);

        return encoder.matches(inputPassword, account.getPassword());
    }



    @Transactional
    public void updateJoinCountIfNewDay(String email) {
        Date lastLoginDate = userMapper.getLastLoginDate(email);
        LocalDate today = LocalDate.now();

        if (lastLoginDate == null || 
            lastLoginDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate().isBefore(today)) {
            userMapper.updateLoginDateAndCount(email);
        } else {
            userMapper.updateLoginDate(email); // 날짜만 업데이트
        }
    }
}