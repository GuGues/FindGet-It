package com.get.mypage;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
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
    public ModelAndView mypage() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = null;

        // 인증된 사용자만 이메일을 가져옴
        if (authentication != null && authentication.isAuthenticated() && !(authentication instanceof AnonymousAuthenticationToken)) {
            Object principal = authentication.getPrincipal();
            if (principal instanceof UserDetails) {
                email = ((UserDetails) principal).getUsername(); // 이메일 또는 사용자 ID
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
			MypageVo count = mypageMapper.getCountWrite(email);
			//MypageVo myfind = mypageMapper.getMyFind(email);

			List<MypageVo> alllocation = mypageMapper.getAllLocation();
			List<MypageVo> allitem = mypageMapper.getAllItem();

			//MypageVo userlocation = mypageMapper.getLocations(myfind.getLocation_code());
			//MypageVo useritem = mypageMapper.getItems(myfind.getItem_code());

			// 데이터 가져오기
			//List<MypageVo> history = mypageMapper.getHistoryList(user);
			//List<MypageVo> postCount = mypageMapper.getPostCount(user);
			//mv.addObject("postCount", postCount);
			//mv.addObject("history", history);
			mv.addObject("user", user);
			mv.addObject("count", count);
			mv.addObject("alllocation", alllocation);
			//mv.addObject("userlocation", userlocation);
			mv.addObject("allitem", allitem);
			//mv.addObject("useritem", useritem);

     	

		mv.setViewName("mypage/myhome");
		return mv;
	}

}