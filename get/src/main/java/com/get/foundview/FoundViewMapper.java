package com.get.foundview;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


@Mapper
public interface FoundViewMapper {
    FoundItemVO selectFoundItemDetail(@Param("foundIdx") String foundIdx);
}