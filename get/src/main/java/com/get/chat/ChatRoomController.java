package com.get.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class ChatRoomController {

    @Autowired
    private ChatService chatService;

    @GetMapping("/roomList")
    public String roomList(Model model) {
        List<ChatRoom> roomList = chatService.findAllRoom();
        model.addAttribute("roomList", roomList);
        return "chat/roomList";
    }

    @GetMapping("/room/{chatting_no}")
    public String room(@PathVariable("chatting_no") String chatting_no, Model model) {
        model.addAttribute("chatting_no", chatting_no);
        return "chat/room";
    }

    /**
     * 방만들기 폼
     */
    @GetMapping("/roomForm")
    public String roomForm() {
        return "chat/roomForm";
    }

    @PostMapping("/roomOpen")
    public String roomOpen(ChatRoom room) {
        chatService.createRoom(room);

        return "chat/roomForm";
    }



}
