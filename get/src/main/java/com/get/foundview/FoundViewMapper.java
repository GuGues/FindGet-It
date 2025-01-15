package com.get.foundview;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface FoundViewMapper {

    // 습득물 상세
    FoundItemVO selectFoundItemDetail(@Param("foundIdx") String foundIdx);

    // 지역 목록 조회
    List<Map<String, Object>> selectLocations();

    // 물품 목록 조회
    List<Map<String, Object>> selectItems();

    // 색상 목록 조회
    List<Map<String, Object>> selectColors();

    // 습득물 등록
    void insertFoundItem(FoundItemVO vo);

    // 회원정보 조회
    Map<String, Object> selectMemberByEmail(@Param("email") String email);

    // ======= (새로 추가) 습득물 수정 =======
    void updateFoundItem(FoundItemVO vo);

    // 이미지 경로 조회
    String getFilePath(String foundIdx);

    // 습득물 이미지 경로 조회
    String getFoundFilePath(@Param("foundIdx") String foundIdx);

    // ========= (추가) 조회수 증가 =========
    void updateFoundViews(@Param("foundIdx") String foundIdx);

    // 습득물 상태 업데이트
    void updateFoundState(@Param("foundIdx") String foundIdx, @Param("foundState") int foundState);
}