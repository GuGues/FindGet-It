package com.get.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    private ChatService chatService;

    @GetMapping("/rooms")
    public ModelAndView chatRooms(Principal principal) {
        // 비로그인 상태 처리
        if (principal == null) {
            return new ModelAndView("redirect:/login");
        }

        String userEmail = principal.getName();
        List<ChatRoomVo> rooms = chatService.getUserRooms(userEmail);

        ModelAndView mv = new ModelAndView("chat/chatRooms");
        mv.addObject("rooms", rooms);
        return mv;
    }

    @PostMapping("/create")
    public String createRoom(@RequestParam("targetEmail") String targetEmail, Principal principal) {
        // 비로그인 상태 처리
        if (principal == null) {
            return "redirect:/login";
        }

        String currentUser = principal.getName();
        Long roomId = chatService.createRoomWithUser(currentUser, targetEmail);
        return "redirect:/chat/room/" + roomId;
    }

    @GetMapping("/room/{roomId}")
    public ModelAndView chatRoom(@PathVariable("roomId") Long roomId, Principal principal) {
        // 비로그인 상태 처리
        if (principal == null) {
            return new ModelAndView("redirect:/login");
        }

        String userEmail = principal.getName();
        List<ChatMessageVo> messages = chatService.getRoomMessages(roomId, userEmail);

        ModelAndView mv = new ModelAndView("chat/chatRoom");
        mv.addObject("messages", messages);
        mv.addObject("roomId", roomId);
        return mv;
    }
}