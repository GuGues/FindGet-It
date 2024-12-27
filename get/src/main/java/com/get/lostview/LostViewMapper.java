package com.get.lostview;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface LostViewMapper {
    LostItemVO selectLostItemDetail(@Param("lostIdx") String lostIdx);

    List<Map<String, Object>> selectLocations();
    List<Map<String, Object>> selectItems();
    List<Map<String, Object>> selectColors();


    int insertLostItem(LostItemVO vo);
}