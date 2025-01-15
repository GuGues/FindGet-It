package com.get.chat;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Mapper
public interface ChatMapper {
    ChatRoom findByRoomId(String roomId);

    void saveChat(Chat chat);

    List<ChatRoom> findAllRooms();

    void createRoom(ChatRoom room);

    List<ChatRoom> findRoomListByEmail(String email);

    List<Chat> findAllChat(String chattingNo);

    ChatRoom findOpenedRoom(String openerEmail, String email);

    List<ChatRoom> findRoomListByUserIdxLastest(String userid);

    Chat findChatLastest(String chattingNo);

    void updateMessageViewed(String chattingNo, String email);

    int countChatStack(String chattingNo, String email);

    void report(ChattingReportVo reportVo);

    List<Chat> findAllChatReverse(String chattingNo);

    void updateOpenerLocation(String openMember,String openMemberPermission, Double openMemberLat, Double openMemberLng,String chatting_no);

    void updateParticipantLocation(String participant,String participantPermission, Double participantLat, Double participantLng,String chatting_no);

    Map<String, String> getLocation(String email, String chattingNo);

    void createChattingLocation(ChatRoom room);
}
