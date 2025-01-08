package com.get.notice;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class noticeVo {
	
	private String notice_idx;
	private String notice_title;
	private String notice_content;
	private int n_views;
	private String n_reg_date;
	
}
