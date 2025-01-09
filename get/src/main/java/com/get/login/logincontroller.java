package com.get.login;

import com.get.security.service.Account;
import com.get.security.service.AccountService;
import com.get.security.service.UserMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
