package com.get.chat;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ChatRoom {
    private String chatting_no;
    private String ch_create_date;
    private String open_member;
    private String participant;

    @Builder
    ChatRoom(String chatting_no, String ch_create_date, String open_member, String participant) {
        this.chatting_no = chatting_no;
        this.ch_create_date = ch_create_date;
        this.open_member = open_member;
        this.participant = participant;
    }

    public static ChatRoom createRoom(String chatting_no,String ch_create_date, String open_member, String participant) {
        return ChatRoom.builder()
                .chatting_no(chatting_no)
                .ch_create_date(ch_create_date)
                .open_member(open_member)
                .participant(participant)
                .build();
    }
}
