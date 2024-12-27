package com.get.admin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class reportVo {
	private String report_idx;
	private String reporter_idx;
	private String resiver_idx;
	private String r_content;
	private String r_reg_date;
	
	private String title;
	private String email;
	private String p_reg_date;
	private int resiver_idx_cnt;
}
