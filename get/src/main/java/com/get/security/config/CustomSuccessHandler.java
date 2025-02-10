package com.get.security.config;

import com.get.security.service.Account;
import com.get.security.service.AccountService;
import com.get.security.service.UserMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.io.IOException;

@Component
@RequiredArgsConstructor
public class CustomSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

	private final AccountService accountService;
    private final UserMapper userMapper;
    private RequestCache requestCache = new HttpSessionRequestCache();


    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        authentication = SecurityContextHolder.getContext().getAuthentication();
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
        
        
        accountService.updateJoinCountIfNewDay(email);

        SavedRequest savedRequest = this.requestCache.getRequest(request, response);
        if (savedRequest == null) {
            super.onAuthenticationSuccess(request, response, authentication);
        } else {
            String targetUrlParameter = this.getTargetUrlParameter();
            if (!this.isAlwaysUseDefaultTargetUrl() && (targetUrlParameter == null || !StringUtils.hasText(request.getParameter(targetUrlParameter)))) {
                this.clearAuthenticationAttributes(request);
                String targetUrl = savedRequest.getRedirectUrl();
                this.getRedirectStrategy().sendRedirect(request, response, targetUrl);
            } else {
                this.requestCache.removeRequest(request, response);
                super.onAuthenticationSuccess(request, response, authentication);
            }
        }

    }
}
