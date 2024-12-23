package com.get.chat;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Optional;

@Mapper
public interface ChatMapper {
    ChatRoom findByRoomId(String roomId);

    void saveChat(Chat chat);

    List<ChatRoom> findAllRooms();

    void createRoom(ChatRoom room);
}
