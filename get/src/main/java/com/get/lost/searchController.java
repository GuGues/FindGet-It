package com.get.lost;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.get.found.FoundMapper;
import com.get.found.foundCustomVo;
import com.get.paging.pagingHelper;
import com.get.vo.colorVo;
import com.get.vo.itemVo;
import com.get.vo.locationVo;

@RestController
public class searchController {
	
	@Autowired
	private LostMapper lostMapper;
	@Autowired
	private FoundMapper foundMapper;
	
	@GetMapping("/getBigCate")
	public ResponseEntity<List<itemVo>> getBigCate(){
		List<itemVo> bigItems = lostMapper.getBigItems();
		return ResponseEntity.ok(bigItems);
	}
	
	@GetMapping("/getCate")
	public ResponseEntity<List<itemVo>> getCate(@RequestParam(name = "item_code") int item_code){
		int code = item_code/100;
		List<itemVo> items = lostMapper.getItems(code);
		return ResponseEntity.ok(items);
	}
	
	@GetMapping("/getColor")
	public ResponseEntity<List<colorVo>> getColor(){
		List<colorVo> colors = lostMapper.getColors();
		return ResponseEntity.ok(colors);
	}
	
	@GetMapping("/getLocationBig")
	public ResponseEntity<List<locationVo>> getLocationBig(){
		List<locationVo> location = lostMapper.getLocationBig();
		return ResponseEntity.ok(location);
	}
	
	@GetMapping("/getLocationMiddle")
	public ResponseEntity<List<locationVo>> getLocatioinMiddle(@RequestParam(name = "location_code") int location_code){
		List<locationVo> location = lostMapper.getLocationMiddle(location_code);
		return ResponseEntity.ok(location);
	}
	
	@GetMapping("/getLostSearch")
	public ModelAndView getLostSearch(@RequestParam Map<String, String> map, @RequestParam(value = "page", defaultValue = "1") int page){
		System.out.println("searchLost map : "+map);
		
		int recordsPerPage = 15;  // 페이지당 보여줄 게시글 수
        int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산
        int totalRecords = lostMapper.getTotalSearchLostCount(map);  // 전체 게시글 수
        pagingHelper pagingHelper = new pagingHelper(totalRecords, page, recordsPerPage);
		map.put("arg0", String.valueOf(arg0));
		map.put("arg1", String.valueOf(recordsPerPage));
		//System.out.println(map);
		//{lost_title=sdsd, item_code=201205, location_code=100699, start_date=2024-12-10, end_date=2024-12-18, color_code=6}
		List<lostCustomVo> searchLost = lostMapper.getSearchLost(map);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("lostList",searchLost);
		mv.addObject("pagingHelper",pagingHelper);
		mv.addObject("search",map);
		mv.setViewName("lost/board");
		
		return mv;
	}
	
	@GetMapping("/getFoundSearch")
	public ModelAndView getFoundSearch(@RequestParam Map<String, String> map, @RequestParam(value = "page", defaultValue = "1") int page){
		System.out.println("searchFound map : "+map);
		
		int recordsPerPage = 15;  // 페이지당 보여줄 게시글 수
		int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산
		int totalRecords = foundMapper.getTotalSearchFoundCount(map);  // 전체 게시글 수
		pagingHelper pagingHelper = new pagingHelper(totalRecords, page, recordsPerPage);
		map.put("arg0", String.valueOf(arg0));
		map.put("arg1", String.valueOf(recordsPerPage));
		List<foundCustomVo> searchFound = foundMapper.getSearchFound(map);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("foundList",searchFound);
		mv.addObject("pagingHelper",pagingHelper);
		mv.addObject("search",map);
		mv.setViewName("found/board");
		
		return mv;
	}
}
