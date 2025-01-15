package com.get.security.service;

<<<<<<< HEAD
import java.sql.Date;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.userdetails.UserDetails;
=======
//import java.sql.Date;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Date;
>>>>>>> d4032ee16fce93ac50b05fcc4db0c5b9fe7ac6bd

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

<<<<<<< HEAD
	Account findUserByUserNamePhoneEmail(String username, String phone, String email);

	void changePw(Account reg);
	
=======


>>>>>>> d4032ee16fce93ac50b05fcc4db0c5b9fe7ac6bd
}