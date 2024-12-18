package com.get.chat;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ChatMapper {

    void createChatRoom();

    void addUserToRoom(@Param("roomId") Long roomId, @Param("userEmail") String userEmail);

    List<ChatRoomVo> getUserChatRooms(@Param("userEmail") String userEmail);

    List<ChatMessageVo> getMessagesInRoom(@Param("roomId") Long roomId);

    void insertMessage(ChatMessageVo message);

    void insertMessageRead(@Param("messageId") Long messageId, @Param("userEmail") String userEmail);

    void updateMessageRead(@Param("messageId") Long messageId, @Param("userEmail") String userEmail);

    int countUnreadMessages(@Param("roomId") Long roomId, @Param("userEmail") String userEmail);

    Long getLastRoomId();

    // 방에 참여한 다른 유저 이메일 가져오기 (1:1 채팅 가정)
    List<String> getRoomUsers(@Param("roomId") Long roomId);

    // 읽지 않은 메시지 모두 읽음 처리
    void markAllAsRead(@Param("roomId") Long roomId, @Param("userEmail") String userEmail);
}