package com.get.dashboard;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DashboardMapper {

    // 1) 습득물 통계
    int selectFoundTotalCount();
    int selectFoundFinishedCount();
    int selectFoundOngoingCount();

    // 2) 분실물 통계
    int selectLostTotalCount();
    int selectLostFinishedCount();
    int selectLostOngoingCount();

    // 3) 지역 통계 (대분류 시/도 기준)
    //    - 예: SELECT SIDO_NAME, COUNT(*) ...
    List<RegionStat> selectFoundRegionStats();
    List<RegionStat> selectLostRegionStats();
}