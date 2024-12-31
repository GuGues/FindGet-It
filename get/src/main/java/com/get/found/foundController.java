package com.get.found;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.get.paging.pagingHelper;

@Controller
@RequestMapping("/found")
public class foundController {
	
	
	@Autowired
	private FoundMapper foundMapper;
	
	
	@GetMapping("")
	public ModelAndView foundBoard(@RequestParam(value = "page", defaultValue = "1") int page) {
		
		int recordsPerPage = 15;  // 페이지당 보여줄 게시글 수
        int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산
        int totalRecords = foundMapper.getTotalFoundCount();  // 전체 게시글 수
        pagingHelper pagingHelper = new pagingHelper(totalRecords, page, recordsPerPage);
		
		//분실물 전체 리스트
		List<foundCustomVo> foundList = foundMapper.getFoundList(arg0, recordsPerPage);
		ModelAndView mv = new ModelAndView();
		mv.addObject("foundList",foundList);
		mv.addObject("pagingHelper",pagingHelper);
		mv.setViewName("found/board");
		return mv;
	}
}
