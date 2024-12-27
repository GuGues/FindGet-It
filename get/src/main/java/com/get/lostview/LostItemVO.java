package com.get.lostview;

public class LostItemVO {
    private String lostIdx;
    private String email;
    private String lostTitle;
    private String lostContent;
    private String lostDate;
    private String lRegDate;
    private int lViews;
    private int locationCode;
    private String lLocationDetail;
    private int itemCode;
    private String lItemDetail;
    private Long reward;
    private int colorCode;
    private int lostState;

    // 조인한 아이템명, 컬러명
    private String itemName;
    private String colorName;
    private String sidoName;
    private String gugunName;

    public String getSidoName() {
        return sidoName;
    }

    public void setSidoName(String sidoName) {
        this.sidoName = sidoName;
    }

    public String getLostIdx() {
        return lostIdx;
    }

    public void setLostIdx(String lostIdx) {
        this.lostIdx = lostIdx;
    }

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

    public String getlRegDate() {
        return lRegDate;
    }

    public void setlRegDate(String lRegDate) {
        this.lRegDate = lRegDate;
    }

    public int getlViews() {
        return lViews;
    }

    public void setlViews(int lViews) {
        this.lViews = lViews;
    }

    public int getLocationCode() {
        return locationCode;
    }

    public void setLocationCode(int locationCode) {
        this.locationCode = locationCode;
    }

    public String getlLocationDetail() {
        return lLocationDetail;
    }

    public void setlLocationDetail(String lLocationDetail) {
        this.lLocationDetail = lLocationDetail;
    }

    public int getItemCode() {
        return itemCode;
    }

    public void setItemCode(int itemCode) {
        this.itemCode = itemCode;
    }

    public String getlItemDetail() {
        return lItemDetail;
    }

    public void setlItemDetail(String lItemDetail) {
        this.lItemDetail = lItemDetail;
    }

    public Long getReward() {
        return reward;
    }

    public void setReward(Long reward) {
        this.reward = reward;
    }

    public int getColorCode() {
        return colorCode;
    }

    public void setColorCode(int colorCode) {
        this.colorCode = colorCode;
    }

    public int getLostState() {
        return lostState;
    }

    public void setLostState(int lostState) {
        this.lostState = lostState;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getColorName() {
        return colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public String getGugunName() {
        return gugunName;
    }

    public void setGugunName(String gugunName) {
        this.gugunName = gugunName;
    }
}