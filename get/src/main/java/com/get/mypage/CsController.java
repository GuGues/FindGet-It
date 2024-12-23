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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/Mypage/Cs")
public class CsController {

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
			List<MypageVo> csList = mypageMapper.getCsList(user);
			mv.addObject("count2", csList != null ? csList.size() : 0);
			mv.addObject("csList", csList);
		}

		mv.setViewName("mypage/cs/board");
		return mv;
	}

	@RequestMapping("/View")

	@Transactional
	@PostMapping("/Delete")
	public ResponseEntity<String> deleteCs(@RequestBody List<String> cs_idx) {

		if (cs_idx == null || cs_idx.isEmpty()) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("삭제할 문의글이 없습니다.");
		}

		try {
			mypageMapper.deleteCs(cs_idx);
			return ResponseEntity.ok("선택된 문의글이 삭제되었습니다.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("문의글 삭제 중 오류가 발생했습니다.");
		}
	}

}
