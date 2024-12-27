package com.get.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

@Controller
public class ChatController {

    @Autowired
    private ChatService chatService;

    @Autowired
    private SimpMessageSendingOperations sendingOperations;

    @MessageMapping("/chat/{roomId}")
    public Chat chat(@DestinationVariable("roomId") String roomId, Chat chat) {
        Chat newChat = chatService.createChat(roomId,chat);
        sendingOperations.convertAndSend("/queue/chat/room/" + roomId, newChat);
        return newChat;
    }
}
