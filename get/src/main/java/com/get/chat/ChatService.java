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

    public String createRoom(String email, String openerEmail) {
        ChatRoom room = chatMapper.findOpenedRoom(openerEmail,email);
        if(room == null) {
            chatMapper.createRoom(openerEmail, email);
            return "redirect:/chatting/roomList";
        }
        else return "redirect:/chatting/room/"+room.getChatting_no();
    }

    public List<ChatRoom> findRoomByEmail(String email) {
        return chatMapper.findRoomListByEmail(email);
    }

    public List<Chat> findAllChat(String chattingNo) {
        return chatMapper.findAllChat(chattingNo);
    }
}
