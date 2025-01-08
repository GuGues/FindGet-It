package com.get.faq;

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
@RequestMapping("/faq")
public class faqController {
    
	@Autowired
	private FaqMapper faqMapper;
	
	@GetMapping("")
	public ModelAndView faqBoard() {
		
		List<faqVo> faqList = faqMapper.getFaqList();
		
		for(int i = 0; i < faqList.size(); i++) {
			faqVo faq_answer = faqList.get(i);
			faq_answer.setFaq_answer(faqList.get(i).getFaq_answer().replace("\n", "<br>"));
			faqList.set(i, faq_answer);
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("faqList", faqList);
		mv.setViewName("faq/board");
		return mv;
	}
	
	@PostMapping("/update")
	public ModelAndView faqUpdate(@RequestParam Map<String, String> map) {
		System.out.println(map);
		//{faq_idx=FA00000001, faq_question=sdfsf, faq_answer=ssss}
		faqMapper.updateFaq(map);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/faq");
		return mv;
	}
	
	@GetMapping("/del")
	public ModelAndView faqDel(@RequestParam(name = "id") String faq_idx) {
		System.out.println(faq_idx);
		//FA00000001
		faqMapper.delFaq(faq_idx);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/faq");
		return mv;
	}
	
	@GetMapping("/insert")
	public ModelAndView faqInsertForm() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("faq/insert");
		return mv;
	}
	
	@PostMapping("/insert")
	public ModelAndView faqInsert(@RequestParam Map<String, String> map) {
		
		faqMapper.insertFaq(map);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/faq");
		return mv;
	}
	
	@GetMapping("/cs")
	public ModelAndView csBoard(@RequestParam(value = "page", defaultValue = "1") int page) {
		int recordsPerPage = 15;  // 페이지당 보여줄 게시글 수
        int offset = (page - 1) * recordsPerPage;  // 오프셋 계산
        int totalRecords = faqMapper.getTotalCsCount();  // 전체 게시글 수
        pagingHelper pagingHelper = new pagingHelper(totalRecords, page, recordsPerPage);
        
		List<csVo> csList = faqMapper.getCsList(offset, recordsPerPage);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("csList", csList);
		mv.addObject("pagingHelper", pagingHelper);
		mv.setViewName("faq/cs_board");
		return mv;
	}
	
	@GetMapping("/cs/insert")
	public String csInsertForm() {
		return "faq/cs_insert";
	}
	
	@PostMapping("/cs/insert")
	public ModelAndView csInsert(@RequestParam Map<String, Object> map) {
		//email=user1@example.com, cs_title=asdf, cs_content=safsd
		faqMapper.insertCs(map);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/faq");
		return mv;
	}
	
	@GetMapping("/cs/question")
	public ResponseEntity<csVo> csQuestion(@RequestParam(name="cs_idx") String cs_idx){
		System.out.println(cs_idx);
		csVo vo = faqMapper.getCsQuestion(cs_idx);
		return ResponseEntity.ok(vo);
	}
	
	@PostMapping("/cs/update")
	public ModelAndView csUpdate(@RequestParam Map<String, String> map) {
		System.out.println("map: "+map);
		//{cs_idx=CS00000091, cs_answer=hihihi}
		faqMapper.updateCs(map);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/faq/cs");
		return mv;
	}
	
}
