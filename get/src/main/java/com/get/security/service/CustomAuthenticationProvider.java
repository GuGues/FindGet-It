package com.get.security.service;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class CustomAuthenticationProvider implements AuthenticationProvider {
   
   private final UserDetailsService userDetailsService;
    private final PasswordEncoder passwordEncoder;
   
   @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        //로그인을 시도한 정보를 받아온다
        String memberId = authentication.getName();
        String password = (String)authentication.getCredentials();
        System.out.println("memberId = "+memberId+"\n password="+password);

       //DB에서 로그인 정보와 일치하는 사용자 정보를 찾아 DTO에 담아 비교
        UserDetails userDetails = userDetailsService.loadUserByUsername(memberId);
        if(userDetails==null){
            System.out.println("사용자가 없음");
            throw new BadCredentialsException("사용자 정보가 일치하지 않습니다");
        }
        //시큐리티에서 지원하는 암호화 객체를 통해 입력한 비밀번호와 DB의 비밀번호가 일치하는지 판단
        if (!passwordEncoder.matches(password, userDetails.getPassword())){
        	//일치하지 않는 경우 예외처리한다
            System.out.println("비밀번호가 일치하지 않음");
            throw new BadCredentialsException("사용자 정보가 일치하지 않습니다");
        }
        //일치하는 사용자가 있을 경우 인증 토큰을 발급한다
        return new UsernamePasswordAuthenticationToken(userDetails,password,userDetails.getAuthorities());
    }

    @Override
    public boolean supports(Class<?> authentication) {
        //provider의 동작 여부를 결정한다. false가 리턴되면 authenticate 메서드는 호출되지 않는다
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }

}