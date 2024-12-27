package com.get.security.service;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {

    Account findUser(Account account);

    void save(Account newUser);

    Account findUserByEmail(String email);
}
