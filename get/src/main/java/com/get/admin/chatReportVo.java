package com.get.admin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class chatReportVo {
	private String chat_report_idx;
	private String reporter_email;
	private String receiver_email;
	private int report_room;
	private String chat_report_content;
	private String reg_date;
}
