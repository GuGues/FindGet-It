package com.get.android;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.get.chat.Chat;
import com.get.chat.ChatMapper;
import com.get.chat.ChatRoom;
import com.get.chat.ChatService;
import com.get.found.FoundMapper;
import com.get.found.foundCustomVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.get.lost.LostMapper;
import com.get.lost.lostCustomVo;
import com.get.lost.lostVo;
import com.get.paging.pagingHelper;

@RestController
public class androidController {

    @Autowired
    private LostMapper lostMapper;
    @Autowired
    private FoundMapper foundMapper;
    @Autowired
    private ChatMapper chatMapper;
    @Autowired
    private ChatService chatService;

    @GetMapping("/app/lostList")
    public ResponseEntity<Map<String,Object>> appLostList(@RequestParam(value = "page", defaultValue = "1") int page){
    	int recordsPerPage = 5;  // 페이지당 보여줄 게시글 수
        int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산
        
		//분실물 전체 리스트
		List<lostCustomVo> lostList = lostMapper.getLostList(arg0, recordsPerPage);
		int lostTotal = lostMapper.getTotalLostCount();
		int pageCnt = lostTotal/recordsPerPage;
		if(lostTotal%recordsPerPage!=0) { pageCnt += 1; }
		
		Map<String, Object> result = new HashMap<>();
		result.put("lostList", lostList);
		result.put("pageCnt", pageCnt);
		return ResponseEntity.ok(result);
    }
    @GetMapping("/app/getLostSearch")
	public ResponseEntity<Map<String,Object>> getLostSearch(@RequestParam Map<String, String> map, @RequestParam(value = "page", defaultValue = "1") int page){
		System.out.println("searchLost map : "+map);
		
		int recordsPerPage = 5;  // 페이지당 보여줄 게시글 수
        int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산
		map.put("arg0", String.valueOf(arg0));
		map.put("arg1", String.valueOf(recordsPerPage));
		
		//{lost_title=sdsd, item_code=201205, location_code=100699, start_date=2024-12-10, end_date=2024-12-18, color_code=6}
		List<lostCustomVo> searchLost = lostMapper.getSearchLost(map);
		int lostTotal = lostMapper.getTotalSearchLostCount(map);
		int pageCnt = lostTotal/recordsPerPage;
		if(lostTotal%recordsPerPage!=0) { pageCnt += 1; }

		Map<String, Object> result = new HashMap<>();
		result.put("searchLost", searchLost);
		result.put("pageCnt", pageCnt);
		return ResponseEntity.ok(result);
	}
    @GetMapping("/app/foundList")
    public ResponseEntity<Map<String,Object>> appFoundList(@RequestParam(value = "page", defaultValue = "1") int page){
    	int recordsPerPage = 5;  // 페이지당 보여줄 게시글 수
        int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산
        
		//분실물 전체 리스트
		List<foundCustomVo> foundList = foundMapper.getFoundList(arg0, recordsPerPage);
		int foundTotal = foundMapper.getTotalFoundCount();
		int pageCnt = foundTotal/recordsPerPage;
		if(foundTotal%recordsPerPage!=0) { pageCnt += 1; }
		
		Map<String, Object> result = new HashMap<>();
		result.put("foundList", foundList);
		result.put("pageCnt", pageCnt);
		return ResponseEntity.ok(result);
    }
    @GetMapping("/app/getFoundSearch")
	public ResponseEntity<Map<String,Object>> getFoundSearch(@RequestParam Map<String, String> map, @RequestParam(value = "page", defaultValue = "1") int page){
		System.out.println("searchLost map : "+map);
		
		int recordsPerPage = 5;  // 페이지당 보여줄 게시글 수
        int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산
		map.put("arg0", String.valueOf(arg0));
		map.put("arg1", String.valueOf(recordsPerPage));
		
		//{lost_title=sdsd, item_code=201205, location_code=100699, start_date=2024-12-10, end_date=2024-12-18, color_code=6}
		List<foundCustomVo> searchFound = foundMapper.getSearchFound(map);
		int foundTotal = foundMapper.getTotalSearchFoundCount(map);
		int pageCnt = foundTotal/recordsPerPage;
		if(foundTotal%recordsPerPage!=0) { pageCnt += 1; }

		Map<String, Object> result = new HashMap<>();
		result.put("searchFound", searchFound);
		result.put("pageCnt", pageCnt);
		return ResponseEntity.ok(result);
	}
    
    
    @GetMapping("/app/chatting-roomList/{email}")
    public ResponseEntity<Map<String, Object>> appChatList(@PathVariable("email") String email) {
        Map<String, Object> map = chatService.findRoomByEmail(email);
        return ResponseEntity.ok(map);
    }
}