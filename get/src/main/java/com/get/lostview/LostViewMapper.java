package com.get.lostview;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface LostViewMapper {

    // 분실물 상세조회
    LostItemVO selectLostItemDetail(String lostIdx);

    // 지역 목록 조회
    List<Map<String, Object>> selectLocations();

    // 물품 목록 조회
    List<Map<String, Object>> selectItems();

    // 색상 목록 조회
    List<Map<String, Object>> selectColors();

    List<Map<String, Object>> selectMenIdx();

    // 분실물 등록
    void insertLostItem(LostItemVO vo);

    // ------------------------------
    // 아래는 예시로 추가한 회원정보 조회용 메서드
    // ------------------------------
    Map<String, Object> selectMemberByEmail(@Param("email") String email);

    void  updateLostItem(LostItemVO vo);

	String getFilePath(String lostIdx);



}