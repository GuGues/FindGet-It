package com.get.mypage;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/")
public class MypageController {

    @Autowired
    private MypageMapper mypageMapper;

 // 뱃지 정보를 반환하는 컨트롤러
    @GetMapping("Mypage")
    public ModelAndView badges() {
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

		ModelAndView mv = new ModelAndView();
		if(email != null) {
			MypageVo user = mypageMapper.getEmail(email);

			// 데이터 가져오기
			List<MypageVo> history = mypageMapper.getHistoryList(user);
			List<MypageVo> postCount = mypageMapper.getPostCount(user);
			mv.addObject("postCount", postCount);
			mv.addObject("history", history);
		}
		mv.setViewName("mypage/myhome");
		return mv;
	}
   

}