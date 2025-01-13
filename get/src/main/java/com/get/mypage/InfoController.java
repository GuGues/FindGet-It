package com.get.mypage;

import com.get.security.service.AccountService;


import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/Mypage/InfoUpdate")
public class InfoController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private MypageMapper mypageMapper;
    

    @GetMapping("/Password")
    public ModelAndView passwordCheck() {
    	 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();        
         String email = null;//인증된 사용자 이메일을 가져옴
         
         if (authentication != null && authentication.isAuthenticated() && !(authentication instanceof AnonymousAuthenticationToken)) {
             Object principal = authentication.getPrincipal();
             if (principal instanceof UserDetails) {
                 email = ((UserDetails) principal).getUsername(); // 이메일 
             } else if (principal instanceof String) {
                 email = (String) principal;
             }
         }

         ModelAndView mv = new ModelAndView();
         if (email == null) {
             mv.setViewName("redirect:/login");  // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
             return mv;
         }

    	
    	mv.setViewName("mypage/infoupdate/pwcheck");
    	return mv;
    }
    
    
    @PostMapping("/PwCheck")
    public ResponseEntity<Boolean> checkPassword(
            @RequestParam(value = "checkPw") String checkPw, 
            Principal principal) {

        System.out.println("[요청 시작] Principal: " + principal + ", checkPw: " + checkPw);

        if (principal == null || checkPw == null || checkPw.trim().isEmpty()) {
            System.out.println("요청 실패: 사용자 인증 정보 또는 비밀번호 누락");
            return ResponseEntity.badRequest().body(false);
        }

        String email = principal.getName();
        System.out.println("[요청 확인] 이메일: " + email + ", 입력 비밀번호: " + checkPw);

        boolean isPasswordCorrect = accountService.verifyPassword(email, checkPw);
        System.out.println("[비밀번호 검증] 결과: " + isPasswordCorrect);

        return ResponseEntity.ok(isPasswordCorrect);
    }
    
    @GetMapping("/Update")
    public ModelAndView userUpdate() {
    	 Authentication authentication = SecurityContextHolder.getContext().getAuthentication();        
         String email = null;//인증된 사용자 이메일을 가져옴
         
         if (authentication != null && authentication.isAuthenticated() && !(authentication instanceof AnonymousAuthenticationToken)) {
             Object principal = authentication.getPrincipal();
             if (principal instanceof UserDetails) {
                 email = ((UserDetails) principal).getUsername(); // 이메일 
             } else if (principal instanceof String) {
                 email = (String) principal;
             }
         }

         ModelAndView mv = new ModelAndView();
         if (email == null) {
             mv.setViewName("redirect:/login");  // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
             return mv;
         }

    	 
    	MypageVo user = mypageMapper.getEmail(email);
    	
    	mv.addObject("user", user);
    	mv.setViewName("mypage/infoupdate/update");
    	return mv;
    }
    
    @PostMapping("/UpdateUser")
    public ResponseEntity<Map<String, String>> updateMyFind(@RequestBody Map<String, Object> requestData) {
        try {
            int result = mypageMapper.updateUser(requestData);
            if (result > 0) {
                Map<String, String> response = new HashMap<>();
                response.put("status", "success");
                return ResponseEntity.ok(response);
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("status", "error"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("status", "error"));
        }
    }
}
