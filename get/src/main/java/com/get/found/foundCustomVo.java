package com.get.found;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class foundCustomVo {
	private String found_idx;
	private String email;
	private String found_title;
	private String found_content;
	private String found_date;
	private String f_reg_date;
	private int f_views;
	private String item_state;
	private int location_code;
	private String f_location_detail;
	private int item_code;
	private String f_item_detail;
	private int color_code;
	private int found_state;
	private String nickname;

	private String location;
}
