package com.get.dashboard;

/**
 * 지역(대분류 시/도)별 통계 데이터를 담는 VO 예시
 */
public class RegionStat {
    private String regionName;  // 예: "서울특별시"
    private int count;

    public RegionStat() {}

    public RegionStat(String regionName, int count) {
        this.regionName = regionName;
        this.count = count;
    }

    public String getRegionName() { return regionName; }
    public void setRegionName(String regionName) { this.regionName = regionName; }

    public int getCount() { return count; }
    public void setCount(int count) { this.count = count; }
}