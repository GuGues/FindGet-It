package com.get.chat;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Chat {
  private String message_no;
  private String message_content;
  private String read_fl;
  private String send_time;
  private String sender;
  private String chatting_no;

  @Builder
    public Chat(String message_no, String message_content, String read_fl, String send_time, String sender,String chatting_no) {
      this.message_no = message_no;
      this.message_content = message_content;
      this.read_fl = read_fl;
      this.send_time = send_time;
      this.sender = sender;
      this.chatting_no = chatting_no;
  }

  public static Chat createChat(String message_no, String message_content, String read_fl, String send_time, String sender,String chatting_no) {
      return Chat.builder()
              .message_no(message_no)
              .message_content(message_content)
              .read_fl(read_fl)
              .send_time(send_time)
              .sender(sender)
              .chatting_no(chatting_no).build();
  }
}
