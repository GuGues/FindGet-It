package com.get.lostview;

public class LostItem {
    private String email;
    private String lostTitle;
    private String lostContent;
    private String lostDate; // 'YYYY-MM-DD' 형식
    private String locationCode;
    private String lLocationDetail;
    private String itemCode;
    private String lItemDetail;
    private Integer reward;
    private String colorCode;
    private Integer lostState;

    // Getter 및 Setter 메서드
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLostTitle() {
        return lostTitle;
    }

    public void setLostTitle(String lostTitle) {
        this.lostTitle = lostTitle;
    }

    public String getLostContent() {
        return lostContent;
    }

    public void setLostContent(String lostContent) {
        this.lostContent = lostContent;
    }

    public String getLostDate() {
        return lostDate;
    }

    public void setLostDate(String lostDate) {
        this.lostDate = lostDate;
    }

    public String getLocationCode() {
        return locationCode;
    }

    public void setLocationCode(String locationCode) {
        this.locationCode = locationCode;
    }

    public String getlLocationDetail() {
        return lLocationDetail;
    }

    public void setlLocationDetail(String lLocationDetail) {
        this.lLocationDetail = lLocationDetail;
    }

    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public String getlItemDetail() {
        return lItemDetail;
    }

    public void setlItemDetail(String lItemDetail) {
        this.lItemDetail = lItemDetail;
    }

    public Integer getReward() {
        return reward;
    }

    public void setReward(Integer reward) {
        this.reward = reward;
    }

    public String getColorCode() {
        return colorCode;
    }

    public void setColorCode(String colorCode) {
        this.colorCode = colorCode;
    }

    public Integer getLostState() {
        return lostState;
    }

    public void setLostState(Integer lostState) {
        this.lostState = lostState;
    }
}