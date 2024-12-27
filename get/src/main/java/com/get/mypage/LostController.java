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
@RequestMapping("/Mypage/Lost")
public class LostController {

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
		//이메일을 가져왔는지 확인
		if (email != null) {
			// 이메일로 사용자 정보 가져오기
			MypageVo user = mypageMapper.getEmail(email);

			// 데이터 가져오기
			List<MypageVo> lostList = mypageMapper.getLostList(user);
			mv.addObject("count1", lostList != null ? lostList.size() : 0);
			mv.addObject("lostList", lostList);
		}

		mv.setViewName("mypage/lost/board");
		return mv;
	}

	@Transactional
	@PostMapping("/Delete")
	public ResponseEntity<String> deleteLost(@RequestBody List<String> lost_idx) {

		if (lost_idx == null || lost_idx.isEmpty()) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("삭제할 분실물글이 없습니다.");
		}

		try {
			mypageMapper.deleteLost(lost_idx);
			return ResponseEntity.ok("선택된 분실물글이 삭제되었습니다.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("분실물글 삭제 중 오류가 발생했습니다.");
		}
	}

	@GetMapping("/View/{lost_idx}")
	public ModelAndView view(@PathVariable("lost_idx") String lost_idx) {
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
		MypageVo lost = mypageMapper.getLost(lost_idx);
		MypageVo locations = mypageMapper.getLocations(lost.getLocation_code());
		MypageVo items = mypageMapper.getItems(lost.getItem_code());

		mv.addObject("lost", lost);
		mv.addObject("items", items);
		mv.addObject("locations", locations);
		mv.setViewName("mypage/lost/view");
		return mv;
	}

}
