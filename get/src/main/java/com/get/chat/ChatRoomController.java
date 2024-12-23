package com.get.chat;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping("/chatting")
@Controller
public class ChatRoomController {

    @Autowired
    private ChatService chatService;

    @GetMapping("/roomList")
    public String roomList(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        List<ChatRoom> roomList = chatService.findRoomByEmail(email);
        model.addAttribute("roomList", roomList);
        return "chat/roomList";
    }

    @GetMapping("/room/{chatting_no}")
    public String room(@PathVariable("chatting_no") String chatting_no, Model model) {
        model.addAttribute("chatting_no", chatting_no);
        List<Chat> chatList = chatService.findAllChat(chatting_no);
        model.addAttribute("chatList", chatList);
        return "chat/room";
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
