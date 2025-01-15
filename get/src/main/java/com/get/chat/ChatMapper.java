package com.get.chat;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Optional;

@Mapper
public interface ChatMapper {
    ChatRoom findByRoomId(String roomId);

    void saveChat(Chat chat);

    List<ChatRoom> findAllRooms();

    void createRoom(String email, String openerEmail);

    List<ChatRoom> findRoomListByEmail(String email);

    List<Chat> findAllChat(String chattingNo);

    ChatRoom findOpenedRoom(String openerEmail, String email);

    List<ChatRoom> findRoomListByUserIdxLastest(String userid);

    Chat findChatLastest(String chattingNo);

    void updateMessageViewed(String chattingNo, String email);

    int countChatStack(String chattingNo, String email);

    void report(ChattingReportVo reportVo);

    List<Chat> findAllChatReverse(String chattingNo);
}
