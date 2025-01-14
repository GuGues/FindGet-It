package com.get.security.service;

import java.sql.Date;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.userdetails.UserDetails;

@Mapper
public interface UserMapper {

    Account findUser(Account account);

    void save(Account newUser);

    Account findUserByEmail(String email);
    
    void upJoinCount(String email);

	Account findUserByUserNamePhone(String username, String phone);

	Date getLastLoginDate(String email);

	void updateLoginDateAndCount(String email);

	void updateLoginDate(String email);

	UserDetails loadUserByUsername(String email);
	
}