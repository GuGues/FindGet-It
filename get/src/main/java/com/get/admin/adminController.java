package com.get.admin;

import java.util.HashMap;
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

import com.get.foundview.FoundItemVO;
import com.get.foundview.FoundViewMapper;
import com.get.lostview.LostItemVO;
import com.get.lostview.LostViewMapper;
import com.get.paging.pagingHelper;

@Controller
@RequestMapping("/admin")
public class adminController {

	@Autowired
	private AdminMapper adminMapper;
	@Autowired
    private FoundViewMapper foundViewMapper;
	@Autowired
    private LostViewMapper lostViewMapper;
	
	@RequestMapping("")
	public ModelAndView userList(@RequestParam(value = "page", defaultValue = "1") int page) {
		
		int recordsPerPage = 15;  // 페이지당 보여줄 게시글 수
        int offset = (page - 1) * recordsPerPage;  // 오프셋 계산
        int totalRecords = adminMapper.getTotalMembersCount();  // 전체 게시글 수
        pagingHelper pagingHelper = new pagingHelper(totalRecords, page, recordsPerPage);
		
		List<membersVo> members = adminMapper.getMembers(offset, recordsPerPage);
		ModelAndView mv = new ModelAndView();
		mv.addObject("members", members);
		mv.addObject("pagingHelper", pagingHelper);
		mv.setViewName("admin/user/board");
		return mv;
	}
	
	@GetMapping("/getMember")
	public ResponseEntity<membersVo> getUser(@RequestParam(name="mem_idx") String mem_idx){
		membersVo vo = adminMapper.getUser(mem_idx);
		return ResponseEntity.ok(vo);
	}
	
	@PostMapping("/user/ban")
	public String userBan(@RequestParam(name="mem_idx") String mem_idx){
		adminMapper.userBan(mem_idx);
		return "redirect:/admin";
	}
	
	@RequestMapping("/ban")
	public ModelAndView adminBanUser(@RequestParam(value = "page", defaultValue = "1") int page) {
		
		int recordsPerPage = 15;  // 페이지당 보여줄 게시글 수
		int offset = (page - 1) * recordsPerPage;  // 오프셋 계산
		int totalRecords = adminMapper.getTotalBanMemberCount();  // 전체 게시글 수
		pagingHelper pagingHelper = new pagingHelper(totalRecords, page, recordsPerPage);
		
		List<membersVo> banMembers = adminMapper.getBanMembers(offset, recordsPerPage);
		ModelAndView mv = new ModelAndView();
		mv.addObject("members", banMembers);
		mv.addObject("pagingHelper", pagingHelper);
		mv.setViewName("admin/user/banBoard");
		return mv;
	}
	
	@PostMapping("/user/banClear")
	public String userBanClear(@RequestParam(name="mem_idx") String mem_idx){
		adminMapper.userBanClear(mem_idx);
		return "redirect:/admin/ban";
	}
	
	@GetMapping("/post")
	public ModelAndView adminPostList(@RequestParam(value = "page", defaultValue = "1") int page) {
		int recordsPerPage = 15;  // 페이지당 보여줄 게시글 수
		int offset = (page - 1) * recordsPerPage;  // 오프셋 계산
		int totalRecords = adminMapper.getTotaladminPostCount();  // 전체 게시글 수
		pagingHelper pagingHelper = new pagingHelper(totalRecords, page, recordsPerPage);
		
		List<reportVo> reportList = adminMapper.adminPostList(offset, recordsPerPage);
		ModelAndView mv = new ModelAndView();
		mv.addObject("reportList", reportList);
		mv.addObject("pagingHelper", pagingHelper);
		mv.setViewName("admin/report/board");
		return mv;
	}
	
	@PostMapping("/post")
	public ResponseEntity<Map<String, Object>> adminPost(@RequestParam(name="resiver_idx") String resiver_idx){
		Map<String, Object> map = new HashMap<>();
		List<reportVo> reports = adminMapper.getReport(resiver_idx);
		if(resiver_idx.contains("LO")) {
			LostItemVO lost = lostViewMapper.selectLostItemDetail(resiver_idx);
			map.put("lost", lost);
		}
		else if(resiver_idx.contains("FD")) {
			FoundItemVO found = foundViewMapper.selectFoundItemDetail(resiver_idx);
			map.put("found", found);
		}
		map.put("reports", reports);
		return ResponseEntity.ok(map);
	}
	
	@PostMapping("/post/ban")
	public String adminBanPost(@RequestParam(name="resiver_idx") String resiver_idx) {
		System.out.println("resiver_idx : "+resiver_idx);
		adminMapper.postBan(resiver_idx);
		return "redirect:/admin/post";
	}
	
	@GetMapping("/post/ban")
	public ModelAndView adminBanPostList(@RequestParam(value = "page", defaultValue = "1") int page) {
		int recordsPerPage = 15;  // 페이지당 보여줄 게시글 수
		int offset = (page - 1) * recordsPerPage;  // 오프셋 계산
		int totalRecords = adminMapper.getTotaladminPostCount();  // 전체 게시글 수
		pagingHelper pagingHelper = new pagingHelper(totalRecords, page, recordsPerPage);
		
		List<reportVo> reportList = adminMapper.adminBanPostList(offset, recordsPerPage);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("pagingHelper", pagingHelper);
		mv.addObject("reportList", reportList);
		mv.setViewName("admin/report/banBoard");
		return mv;
	}
	
	@PostMapping("/post/ban/clear")
	public String adminBanClearPost(@RequestParam(name="resiver_idx") String resiver_idx) {
		adminMapper.postBanClear(resiver_idx);
		return "redirect:/admin/post/ban";
	}
	
}
