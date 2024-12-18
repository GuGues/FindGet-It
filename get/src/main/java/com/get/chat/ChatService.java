package com.get.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChatService {

    @Autowired
    private ChatMapper chatMapper;

    public Long createRoomWithUser(String currentUserEmail, String targetUserEmail) {
        chatMapper.createChatRoom();
        Long roomId = chatMapper.getLastRoomId();
        chatMapper.addUserToRoom(roomId, currentUserEmail);
        chatMapper.addUserToRoom(roomId, targetUserEmail);
        return roomId;
    }

    public List<ChatRoomVo> getUserRooms(String userEmail) {
        return chatMapper.getUserChatRooms(userEmail);
    }

    public List<ChatMessageVo> getRoomMessages(Long roomId, String userEmail) {
        // 여기서 읽지 않은 메시지 모두 읽음 처리 로직 수행
        List<ChatMessageVo> messages = chatMapper.getMessagesInRoom(roomId);
        for (ChatMessageVo msg : messages) {
            // 메시지 읽음 상태 확인
            // CHAT_MESSAGE_READ 테이블에 메시지 ID, userEmail 없으면 insert
            int unreadCount = chatMapper.countUnreadMessages(roomId, userEmail);
            // 모든 메시지가 이미 DB에 있는지 확인은 생략, 필요하면 별도 Mapper 필요
            // 여기서는 간단히 getMessagesInRoom 호출 후 아래와 같이 처리
            // 실제로는 MESSAGE_ID별로 CHAT_MESSAGE_READ 존재 확인 필요
            // 편의상 모든 메시지를 읽었다고 가정
            chatMapper.insertMessageRead(msg.getMessageId(), userEmail);
        }
        return messages;
    }

    public void sendMessage(Long roomId, String senderEmail, String content) {
        ChatMessageVo msg = new ChatMessageVo();
        msg.setRoomId(roomId);
        msg.setSenderEmail(senderEmail);
        msg.setMessageContent(content);
        chatMapper.insertMessage(msg);
    }

    public List<String> getRoomUsers(Long roomId) {
        return chatMapper.getRoomUsers(roomId);
    }
}