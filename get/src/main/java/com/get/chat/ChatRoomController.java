package com.get.chat;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/chatting")
@Controller
public class ChatRoomController {

    @Autowired
    private ChatService chatService;

    @Autowired
    private SimpMessageSendingOperations sendingOperations;

    @GetMapping("/roomList")
    public String roomList(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        Map<String,Object> map = chatService.findRoomByEmail(email);
        model.addAttribute("map", map);
        return "chat/roomList";
    }

    @MessageMapping("/chat/roomList/{email}")
    public Map<String,Object> roomList(@DestinationVariable("email") String email, Chat chat) {
        Map<String,Object> map = chatService.findRoomByEmail(email);
        sendingOperations.convertAndSend("/queue/chat/roomList/" + email, map);
        return map;
    }


    @GetMapping("/room/{chatting_no}")
    public String room(@PathVariable("chatting_no") String chatting_no, Model model,HttpServletRequest request) {
        ChatRoom room = chatService.findRoomByIdx(chatting_no);
        List<Chat> chatList = chatService.findAllChat(chatting_no);
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        model.addAttribute("chatting_no", chatting_no);
        model.addAttribute("room", room);
        model.addAttribute("chatList", chatList);
        return "chat/room";
    }

    @PostMapping("/update-view")
    @ResponseBody
    public String updateView(@RequestBody HashMap<String, Object> params) {
        String chatting_no = String.valueOf(params.get("chatting_no"));
        String email = String.valueOf(params.get("email"));
        System.out.println("chatting_no = " + chatting_no);
        System.out.println("email = " + email);
        chatService.updateMessageViewed(chatting_no,email);
        return "OK";
    }

    /**
     * 방만들기 폼
     */

    @GetMapping("/room/open/{email}")
    public String roomOpen(@PathVariable("email") String email, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String openerEmail = (String) session.getAttribute("email");
        return chatService.createRoom(openerEmail,email);
    }



}
