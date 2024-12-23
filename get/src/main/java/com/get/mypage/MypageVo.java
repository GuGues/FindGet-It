package com.get.mypage;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MypageVo {
	//LOST TABLE
	private String lost_idx;       
	private String email;
	private String lost_title;
	private String lost_content;
	private String lost_date;
	private String l_reg_date;
	private int    l_views;
	private int    location_code;
	private String l_location_detail;
	private int    item_code;
	private String l_item_detail;
	private int    reward;
	private int    color_code;
	private int    lost_state;
 
	//MEMBERS TABLE
	private String nickname;
	private String passward;
	private String username;
	private String birth;
	private String phone;
	private String mem_idx;
	private String address1;
	private String address2;
	private int    postnumber;
	private String com_date;
	private String user_grant;
	
	//LOCATIONS TABLE
	private String sido_name;
	private String gugun_name;
	//ITEM TABLE
	private String item;
	
	//STORAGE TABLE
	private String storage_idx;
	private String file_path;
	private String file_name;
	private String using_table;
	private String using_table_idx;
	private String store_date;
	private int    storage_state;
	
	//FOUND TABLE
	private String found_idx;
	private String found_title;
	private String found_content;
	private String found_date;
	private String f_reg_date;
	private int    f_views;
	private String item_state;
	private String f_location_detail;
	private String f_item_detail;
	private int    found_state;
	
	//CS TABLE
	private String cs_idx;
	private String cs_title;
	private String cs_content;
	private String cs_reg_date;
	private int    cs_state;
	
	
}
