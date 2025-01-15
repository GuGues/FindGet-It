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

<<<<<<< HEAD
import java.sql.Date;
=======
//import java.sql.Date;
>>>>>>> d4032ee16fce93ac50b05fcc4db0c5b9fe7ac6bd
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
            return new User(account.getEmail(), account.getPassword(),authorities);
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
<<<<<<< HEAD
        
=======

>>>>>>> d4032ee16fce93ac50b05fcc4db0c5b9fe7ac6bd
        Account account = new Account();
        account.setEmail(email);
        account = userMapper.findUser(account);

        if (account == null) {
            throw new IllegalArgumentException("해당 사용자를 찾을 수 없습니다.");
        }

<<<<<<< HEAD
        
=======

>>>>>>> d4032ee16fce93ac50b05fcc4db0c5b9fe7ac6bd
        return encoder.matches(inputPassword, account.getPassword());
    }

    @Transactional
    public void updateJoinCountIfNewDay(String email) {
        Date lastLoginDate = userMapper.getLastLoginDate(email);
        LocalDate today = LocalDate.now();

<<<<<<< HEAD
        if (lastLoginDate == null || 
=======
        if (lastLoginDate == null ||
>>>>>>> d4032ee16fce93ac50b05fcc4db0c5b9fe7ac6bd
            lastLoginDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate().isBefore(today)) {
            userMapper.updateLoginDateAndCount(email);
        } else {
            userMapper.updateLoginDate(email); // 날짜만 업데이트
        }
    }
<<<<<<< HEAD
    
=======

>>>>>>> d4032ee16fce93ac50b05fcc4db0c5b9fe7ac6bd
    @Transactional
    public void upJoinCount(String email) {
        userMapper.upJoinCount(email);
    }
<<<<<<< HEAD
    
    @Transactional
    public boolean changePw(Account reg,String email, String passwd) {
        Account checkUser = new Account();
        checkUser.setEmail(email);

        if (userMapper.findUser(checkUser) == null){
            return false;
        }
        reg.setPassword(encoder.encode(passwd));
        userMapper.changePw(reg);
        return true;
    }
    
=======

>>>>>>> d4032ee16fce93ac50b05fcc4db0c5b9fe7ac6bd
}