package com.get.search;

public class LostItemVo {
    private String lostIdx;
    private String email;
    private String lostTitle;
    private String lostContent;
    private String lostDate;
    private String lRegDate;
    private int lViews;
    private Integer locationCode;
    private String lLocationDetail;
    private Integer itemCode;
    private String lItemDetail;
    private Long reward;
    private Integer colorCode;
    private Integer lostState;

    public String getLostIdx() { return lostIdx; }
    public void setLostIdx(String lostIdx) { this.lostIdx = lostIdx; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getLostTitle() { return lostTitle; }
    public void setLostTitle(String lostTitle) { this.lostTitle = lostTitle; }

    public String getLostContent() { return lostContent; }
    public void setLostContent(String lostContent) { this.lostContent = lostContent; }

    public String getLostDate() { return lostDate; }
    public void setLostDate(String lostDate) { this.lostDate = lostDate; }

    public String getlRegDate() { return lRegDate; }
    public void setlRegDate(String lRegDate) { this.lRegDate = lRegDate; }

    public int getlViews() { return lViews; }
    public void setlViews(int lViews) { this.lViews = lViews; }

    public Integer getLocationCode() { return locationCode; }
    public void setLocationCode(Integer locationCode) { this.locationCode = locationCode; }

    public String getlLocationDetail() { return lLocationDetail; }
    public void setlLocationDetail(String lLocationDetail) { this.lLocationDetail = lLocationDetail; }

    public Integer getItemCode() { return itemCode; }
    public void setItemCode(Integer itemCode) { this.itemCode = itemCode; }

    public String getlItemDetail() { return lItemDetail; }
    public void setlItemDetail(String lItemDetail) { this.lItemDetail = lItemDetail; }

    public Long getReward() { return reward; }
    public void setReward(Long reward) { this.reward = reward; }

    public Integer getColorCode() { return colorCode; }
    public void setColorCode(Integer colorCode) { this.colorCode = colorCode; }

    public Integer getLostState() { return lostState; }
    public void setLostState(Integer lostState) { this.lostState = lostState; }
}