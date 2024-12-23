package com.get.mypage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("Mypage/Found")
public class FoundController {

	@Autowired
	private MypageMapper mypageMapper;

	@RequestMapping("/Board")
	public ModelAndView board() {
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
		if (email != null) {
			// 이메일로 사용자 정보 가져오기
			MypageVo user = mypageMapper.getEmail(email);

			// 데이터 가져오기
			List<MypageVo> foundList = mypageMapper.getFoundList(user);
			mv.addObject("count3", foundList != null ? foundList.size() : 0);
			mv.addObject("foundList", foundList);
		}
		mv.setViewName("mypage/found/board");
		return mv;
	}

	@Transactional
	@PostMapping("/Delete")
	public ResponseEntity<String> deleteFound(@RequestBody List<String> found_idx) {

		if (found_idx == null || found_idx.isEmpty()) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("삭제할 습득물글이 없습니다.");
		}

		try {
			mypageMapper.deleteFound(found_idx);
			return ResponseEntity.ok("선택된 습득물글이 삭제되었습니다.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("습득물글 삭제 중 오류가 발생했습니다.");
		}
	}

	@GetMapping("/View/{found_idx}")
	public ModelAndView view(@PathVariable("found_idx") String found_idx) {
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
		MypageVo found = mypageMapper.getFound(found_idx);
		MypageVo locations = mypageMapper.getLocations(found.getLocation_code());
		MypageVo items = mypageMapper.getItems(found.getItem_code());
		

		mv.addObject("found", found);
		mv.addObject("items", items);
		mv.addObject("locations", locations);
		mv.setViewName("mypage/found/view");
		return mv;
	}

}
