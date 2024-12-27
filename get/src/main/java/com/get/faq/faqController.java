package com.get.faq;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.get.vo.faqVo;

@Controller
@RequestMapping("/faq")
public class faqController {
    
	@Autowired
	private FaqMapper faqMapper;
	
	@GetMapping("")
	public ModelAndView faqBoard() {
		
		List<faqVo> faqList = faqMapper.getFaqList();
		
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
	
}
