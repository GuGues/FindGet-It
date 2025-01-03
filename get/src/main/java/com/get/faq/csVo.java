package com.get.faq;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class csVo {
	private String cs_idx;
	private String email;
	private String cs_title;
	private String cs_content;
	private String cs_reply;
	private String cs_reg_date;
	private int cs_state; //게시물 상태 번호( 1:답변완료, 2:답변대기중,3:블라인드)
}
