package com.get.notice;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.get.paging.pagingHelper;
import com.get.vo.faqVo;

@Controller
@RequestMapping("/notice")
public class noticeController {
    
	@Autowired
	private NoticeMapper noticeMapper;
	
	@GetMapping("")
	public ModelAndView noticeBoard(@RequestParam(value = "page", defaultValue = "1") int page) {
		int recordsPerPage = 15;  // 페이지당 보여줄 게시글 수
        int offset = (page - 1) * recordsPerPage;  // 오프셋 계산
        int totalRecords = noticeMapper.getTotalNoticeCount();  // 전체 게시글 수
        pagingHelper pagingHelper = new pagingHelper(totalRecords, page, recordsPerPage);
        
		List<noticeVo> noticeList = noticeMapper.getNoticeList(offset, recordsPerPage);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("pagingHelper",pagingHelper);
		mv.addObject("noticeList", noticeList);
		mv.setViewName("notice/board");
		return mv;
	}
	
	@GetMapping("/view")
	public ModelAndView noticeView(@RequestParam(name="notice_idx") String notice_idx) {
		noticeMapper.upNoticeView(notice_idx);
		noticeVo notice = noticeMapper.getNotice(notice_idx);
		notice.setNotice_content(notice.getNotice_content().replace("\n","<br>"));
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("notice", notice);
		mv.setViewName("notice/view");
		return mv;
	}
	
	@GetMapping("/update")
	public ModelAndView noticUpdateForm(@RequestParam(name="notice_idx") String notice_idx) {
		noticeVo notice = noticeMapper.getNotice(notice_idx);
		notice.setNotice_content(notice.getNotice_content().replace("\n","<br>"));
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("notice", notice);
		mv.setViewName("notice/update");
		return mv;
	}
	
	@PostMapping("/update")
	public ModelAndView noticUpdate(@RequestParam Map<String, String> map) {
		System.out.println(map);
		noticeMapper.updateNotice(map);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/notice/view?notice_idx="+map.get("notice_idx"));
		return mv;
	}
	
	@GetMapping("/insert")
	public ModelAndView noticeInsert() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("notice/insert");
		return mv;
	}
	
	@PostMapping("/insert")
	public ModelAndView notice(@RequestParam Map<String, String> map) {
		noticeMapper.insertNotice(map);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/notice");
		return mv;
	}
	
	@GetMapping("/delete")
	public ModelAndView noticDelete(@RequestParam(name="notice_idx") String notice_idx) {
		noticeMapper.deleteNotice(notice_idx);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/notice");
		return mv;
	}
	
}
