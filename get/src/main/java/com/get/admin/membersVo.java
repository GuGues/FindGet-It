package com.get.admin;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class membersVo {
	private String email;
	private String nickname;
	private String passward;
	private String username;
	private String birth;
	private String phone;
	private String mem_idx;
	private String address1;
	private String address2;
	private int postnumber;
	private String com_date;
	private String user_grant;
}
