package com.get.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ChatService {

    @Autowired
    private ChatMapper chatMapper;

    public  Chat createChat(String roomId,Chat chat){
        ChatRoom room = chatMapper.findByRoomId(roomId);
        if(room == null){
            return null;
        }
        chatMapper.saveChat(chat);
        return chat;
    }

    public List<ChatRoom> findAllRoom() {
        return chatMapper.findAllRooms();
    }
    public void createRoom(ChatRoom room){
         chatMapper.createRoom(room);
    }
}
