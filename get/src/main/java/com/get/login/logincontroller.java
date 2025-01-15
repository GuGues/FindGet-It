package com.get.login;

import com.get.security.service.Account;
import com.get.security.service.AccountService;
import com.get.security.service.UserMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class logincontroller {
	
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private AccountService accountService;

    @RequestMapping("/login")
    public String login(){
        return "login/loginpage";
    }
    @RequestMapping("/sighup")
    public String sighup(){
        return "login/sighup";
    }
    @RequestMapping("/sighup/reg")
    public String reg(Account account){
        if(accountService.join(account,account.getEmail(),account.getPassword()))
            return "redirect:/";
        else return "login/loginpage";
    }
    @RequestMapping("/loginSuccess")
    public String loginSuccess(HttpServletRequest request){
        System.out.println("================================석세스 페이지 작동!======================================");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = null;

        if (authentication != null && authentication.isAuthenticated()) {
            Object principal = authentication.getPrincipal();
            if (principal instanceof UserDetails) {
                email = ((UserDetails) principal).getUsername(); // 이메일 또는 사용자 ID
            } else if (principal instanceof String) {
                email = (String) principal;
            }
        }

        if(email != null){
        HttpSession session = request.getSession();
        Account account = userMapper.findUserByEmail(email);
        session.setAttribute("email", account.getEmail());
        session.setAttribute("idx", account.getMem_idx());
        session.setAttribute("grant", account.getUser_grant());
        session.setAttribute("nickname", account.getNickname());

        }
        return "redirect:/";
    }
    @GetMapping("/join/email-check")
    @ResponseBody
    public ResponseEntity<String> emailCheck(@RequestParam("email") String email){
        Account account = userMapper.findUserByEmail(email);
        //아이디가 있다면 result 에 false를 담아줌
        if(account != null){
            return ResponseEntity.ok("false");
        }
        else{
            return ResponseEntity.ok("true");
        }
    }
    
    @GetMapping("/findId")
    public String findId(){
        return "login/findId";
    }
    @PostMapping("/findId/check")
    public ResponseEntity<Map<String, Object>> findIdCheck(@RequestBody Map<String,Object> map){
    	System.out.println(map);
        String username = String.valueOf(map.get("username"));
        String phone = String.valueOf(map.get("phone"));
        Map<String,Object> result = new HashMap<>();

        Account member = userMapper.findUserByUserNamePhone(username,phone);
        System.out.println("member: "+member);
        if(member!=null){
            result.put("status",HttpStatus.OK);
            result.put("result",member.getEmail());
        }
        else{
            result.put("status",HttpStatus.BAD_REQUEST);
            result.put("result","일치하는 정보가 없습니다.");
        }
        return ResponseEntity.ok().body(result);
    }
    
    @GetMapping("/findPw")
    public String findPw(){
        return "login/findPw";
    }
    @PostMapping("/findPw/check")
    public ResponseEntity<Map<String, Object>> findPwCheck(@RequestBody Map<String,Object> map){
    	System.out.println(map);
        String username = String.valueOf(map.get("username"));
        String phone = String.valueOf(map.get("phone"));
        String email = String.valueOf(map.get("email"));
        
        Map<String,Object> result = new HashMap<>();

        Account member = userMapper.findUserByUserNamePhoneEmail(username,phone,email);
        System.out.println("member: "+member);
        if(member!=null){
            result.put("status",HttpStatus.OK);
            result.put("result",member.getEmail());
        }
        else{
            result.put("status",HttpStatus.BAD_REQUEST);
            result.put("result","일치하는 정보가 없습니다.");
        }
        return ResponseEntity.ok().body(result);
    }
    
    @PostMapping("/changePw")
    public String changePw(Account account) {
    	System.out.println("==============account: "+account);
    	if(accountService.changePw(account,account.getEmail(),account.getPassword())) {
    		return "login/loginpage";
    	}
    	else return "redirect:/error-page/403";
    }
}

