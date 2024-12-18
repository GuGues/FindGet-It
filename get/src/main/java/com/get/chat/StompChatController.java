package com.get.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

import java.security.Principal;

@Controller
public class StompChatController {

    @Autowired
    private ChatService chatService;

    @MessageMapping("/sendMessage")
    @SendTo("/topic/room")
    public ChatMessagePayload sendMessage(ChatMessagePayload payload, Principal principal) {
        // principal.getName()으로 현재 사용자 이메일 획득
        String senderEmail = principal.getName();
        Long roomId = payload.getRoomId();
        String message = payload.getMessageContent();

        // 메시지 DB에 저장
        chatService.sendMessage(roomId, senderEmail, message);

        // 다른 유저에게 브로드캐스트 하기 위해 메시지 반환
        // 실제로는 /topic/room/{roomId} 로 구분하여 방 별로 메시지 전송 필요
        payload.setSenderEmail(senderEmail);
        return payload;
    }
}