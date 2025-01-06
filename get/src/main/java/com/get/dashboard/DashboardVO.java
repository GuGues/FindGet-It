package com.get.dashboard;

import java.util.List;

public class DashboardVO {

    // [1] 기존 습득물, 분실물 카운트
    private int foundTotalCount;       // 습득물 전체
    private int foundFinishedCount;    // 찾아준(완료) 습득물
    private int foundOngoingCount;     // 진행중 습득물

    private int lostTotalCount;        // 분실물 전체
    private int lostFinishedCount;     // 찾은(완료) 분실물
    private int lostOngoingCount;      // 진행중 분실물

    // [2] 지역 통계 (습득물/분실물) - 예: 대분류(시/도)별 카운트
    //    - 예시로 List<RegionStat> 만들어서 담아둠
    private List<RegionStat> foundRegionStats;   // 습득물 지역별 통계
    private List<RegionStat> lostRegionStats;    // 분실물 지역별 통계

    // == getters / setters ==
    public int getFoundTotalCount() { return foundTotalCount; }
    public void setFoundTotalCount(int foundTotalCount) { this.foundTotalCount = foundTotalCount; }

    public int getFoundFinishedCount() { return foundFinishedCount; }
    public void setFoundFinishedCount(int foundFinishedCount) { this.foundFinishedCount = foundFinishedCount; }

    public int getFoundOngoingCount() { return foundOngoingCount; }
    public void setFoundOngoingCount(int foundOngoingCount) { this.foundOngoingCount = foundOngoingCount; }

    public int getLostTotalCount() { return lostTotalCount; }
    public void setLostTotalCount(int lostTotalCount) { this.lostTotalCount = lostTotalCount; }

    public int getLostFinishedCount() { return lostFinishedCount; }
    public void setLostFinishedCount(int lostFinishedCount) { this.lostFinishedCount = lostFinishedCount; }

    public int getLostOngoingCount() { return lostOngoingCount; }
    public void setLostOngoingCount(int lostOngoingCount) { this.lostOngoingCount = lostOngoingCount; }

    public List<RegionStat> getFoundRegionStats() { return foundRegionStats; }
    public void setFoundRegionStats(List<RegionStat> foundRegionStats) { this.foundRegionStats = foundRegionStats; }

    public List<RegionStat> getLostRegionStats() { return lostRegionStats; }
    public void setLostRegionStats(List<RegionStat> lostRegionStats) { this.lostRegionStats = lostRegionStats; }
}