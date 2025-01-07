package com.get.mypage;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("/")
public class MypageController {

    @Autowired
    private MypageMapper mypageMapper;


    @GetMapping("Mypage")
    public ModelAndView mypage() {
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
			MypageVo count = mypageMapper.getCountWrite(email);
			MypageVo myfind = mypageMapper.getMyFind(user);
			List<MypageVo> notFind = mypageMapper.getNotFind(email);

			List<MypageVo> alllocation = mypageMapper.getAllLocation();
			List<MypageVo> allitem = mypageMapper.getAllItem();

			MypageVo userlocation = mypageMapper.getLocations(myfind.getLocation_code());
			MypageVo useritem = mypageMapper.getItems(myfind.getItem_code());

			//List<MypageVo> history = mypageMapper.getHistoryList(user);
			//List<MypageVo> postCount = mypageMapper.getPostCount(user);
			//mv.addObject("postCount", postCount);
			//mv.addObject("history", history);
			mv.addObject("user", user);
			mv.addObject("count", count);
			mv.addObject("alllocation", alllocation);
			mv.addObject("userlocation", userlocation);
			mv.addObject("allitem", allitem);
			mv.addObject("useritem", useritem);
			mv.addObject("myfind", myfind);
			mv.addObject("notFind", notFind);

     	

		mv.setViewName("mypage/myhome");
		return mv;
	}

    @PostMapping("UpdateMyFind")
    @ResponseBody
    public String updateMyFind(@RequestParam("location_code") int location_code,
                               @RequestParam("item_code") int item_code,
                               @RequestParam("mem_idx") String mem_idx) {
        
    	
    	
    	try {
            // update 실행 (서비스 없이 직접 Mapper 호출)
            MypageVo result = mypageMapper.updateMyFind(location_code, item_code, mem_idx);

            if (result != null) {
                return "success";
            } else {
                return "error"; // 업데이트가 실패한 경우
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
}