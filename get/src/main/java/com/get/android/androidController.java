package com.get.android;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.get.chat.Chat;
import com.get.chat.ChatMapper;
import com.get.chat.ChatRoom;
import com.get.chat.ChatService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.get.lost.LostMapper;
import com.get.lost.lostCustomVo;
import com.get.lost.lostVo;

@RestController
public class androidController {

    @Autowired
    private LostMapper lostMapper;
    @Autowired
    private ChatMapper chatMapper;
    @Autowired
    private ChatService chatService;

    @GetMapping("/app/lostList")
    public ResponseEntity<List<lostCustomVo>> appLostList(@RequestParam(value = "page", defaultValue = "1") int page){
    	int recordsPerPage = 5;  // 페이지당 보여줄 게시글 수
        int arg0 = (page - 1) * recordsPerPage;  // 오프셋 계산
        
		//분실물 전체 리스트
		List<lostCustomVo> lostList = lostMapper.getLostList(arg0, recordsPerPage);
		
        return ResponseEntity.ok(lostList);
    }
    @GetMapping("/app/chatting-roomList/{email}")
    public ResponseEntity<Map<String,Object>> appChatList(@PathVariable("email") String email){
        Map<String,Object> map = chatService.findRoomByEmail(email);
        System.out.println("map = " + map);
        return ResponseEntity.ok(map);
    }

    @GetMapping("/app/chatting/{chatting_no}")
        public ResponseEntity<Map<String,Object>> room(@PathVariable("chatting_no") String chatting_no) {
            Map<String,Object> map = new HashMap<>();
            ChatRoom room = chatService.findRoomByIdx(chatting_no);
            List<Chat> chatList = chatService.findAllChat(chatting_no);
            map.put("chatting_no", chatting_no);
            map.put("room", room);
            map.put("chatList", chatList);
            return  ResponseEntity.ok(map);
        }
}