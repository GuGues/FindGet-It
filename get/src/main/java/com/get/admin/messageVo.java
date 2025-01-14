package com.get.admin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class messageVo {
	private int message_no;
	private String message_content;
	private String read_fl;
	private String send_time;
	private String sender;
	private int chatting_no;
}
