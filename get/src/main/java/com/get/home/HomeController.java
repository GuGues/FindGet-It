package com.get.home;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

    @RequestMapping("/")
    public ModelAndView home() {

        ModelAndView mv = new ModelAndView();
        mv.setViewName("home");
        return mv;
    }

}
