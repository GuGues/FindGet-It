package com.get.security.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Slf4j
@Controller
public class ErrorPageController {

    @RequestMapping("/error-page/403")
    public String errorPage404(HttpServletRequest request, HttpServletResponse response) {
        log.info("errorPage 403");
        return "error-page/403";
    }
}