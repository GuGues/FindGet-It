package com.get.lost;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class lostCustomVo {
	
	private String lost_idx;
	private String email;
	private String lost_title;
	private String lost_content;
	private String lost_date;
	private String l_reg_date;
	private int l_views;
	private int location_code;
	private String l_location_detail;
	private int item_code;
	private String l_item_detail;
	private int reward;
	private int color_code;
	private int lost_state;
	
	private String location;
	
}
