package com.get.chat;

import com.get.security.service.Account;
import com.get.security.service.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Service
public class ChatService {

    @Autowired
    private ChatMapper chatMapper;
    @Autowired
    private UserMapper userMapper;

    public  Chat createChat(String chatting_no,Chat chat){
        ChatRoom room = chatMapper.findByRoomId(chatting_no);
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

    public Map<String,Object> findRoomByEmail(String email) {
       List<ChatRoom> roomList = chatMapper.findRoomListByEmail(email);
       List<ChatRoom> tempRoomList = new ArrayList<>();
         tempRoomList.addAll(roomList);
        List<Chat> chatList = new ArrayList<>();
        List<ChatRoom> emptyRoomList = new ArrayList<>();

        int count = 0;

       for(ChatRoom room : tempRoomList){
           Chat chat = chatMapper.findChatLastest(room.getChatting_no());
           if(chat != null){
           chatList.add(chat);
           }
           else{
               emptyRoomList.add(room);
               roomList.remove(count);
               continue;
           }
           System.out.println(count);
           count++;
       }


        Collections.sort(chatList, new Comparator<Chat>() {
            @Override
            public int compare(Chat o1, Chat o2) {
                return o2.getSend_time().compareTo(o1.getSend_time());
            }
        });
        List<ChatRoom> sortedRoomList = new ArrayList<>();
        List<Integer> viewList = new ArrayList<>();
        for(Chat chat : chatList){
            for(ChatRoom room : roomList){
                if(room.getChatting_no().equals(chat.getChatting_no())){
                    sortedRoomList.add(room);
                }
            }

            LocalDate send_time = LocalDateTime.parse(chat.getSend_time(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).toLocalDate();
            LocalDate today = LocalDate.now();

            if(ChronoUnit.DAYS.between(send_time,today)>1){
                chat.setSend_time(send_time.format(DateTimeFormatter.ofPattern("MM월 dd일")));
            }
            else if(ChronoUnit.DAYS.between(send_time,today)==1){
                chat.setSend_time("어제");
            }
            else{
                chat.setSend_time(LocalDateTime.parse(chat.getSend_time(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).format(DateTimeFormatter.ofPattern("HH:mm")));
            }

            int chatCount = chatMapper.countChatStack(chat.getChatting_no(),email);
            viewList.add(chatCount);
        }


        sortedRoomList.addAll(emptyRoomList);
        Map<String,Object> map = new HashMap<>();
        List<Account> memberList = new ArrayList<>();
        for(ChatRoom room : sortedRoomList){
            if(room.getOpen_member().equals(email)){
                memberList.add(userMapper.findUserByEmail(room.getParticipant()));
            }
            else{
                memberList.add(userMapper.findUserByEmail(room.getOpen_member()));
            }
        }

        map.put("roomList",sortedRoomList);
        map.put("chatList",chatList);
        map.put("memberList",memberList);
        map.put("viewList",viewList);
        return map;

    }

    public List<Chat> findAllChat(String chattingNo) {
        List<Chat> chatList = chatMapper.findAllChat(chattingNo);
        for(Chat chat : chatList){
            chat.setSend_time(LocalDateTime.parse(chat.getSend_time(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).format(DateTimeFormatter.ofPattern("HH:mm")));
        }
        return chatList;
    }

    public ChatRoom findRoomByIdx(String chatting_no) {
        return chatMapper.findByRoomId(chatting_no);
    }

    public void updateMessageViewed(String chattingNo, String email) {
        chatMapper.updateMessageViewed(chattingNo,email);
    }

    public void report(ChattingReportVo reportVo) {
        System.out.println("reportVo = " + reportVo);
        chatMapper.report(reportVo);

    }

    public List<Chat> findAllChatReverse(String chattingNo) {
        List<Chat> chatList = chatMapper.findAllChatReverse(chattingNo);
               for(Chat chat : chatList){
                   chat.setSend_time(LocalDateTime.parse(chat.getSend_time(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).format(DateTimeFormatter.ofPattern("HH:mm")));
               }
               return chatList;
    }
}
