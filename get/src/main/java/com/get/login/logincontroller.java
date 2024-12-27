package com.get.login;

import com.get.security.service.Account;
import com.get.security.service.AccountService;
import com.get.security.service.UserMapper;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
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
}
