package com.get.foundview;

public class FoundItemVO {
    private String foundIdx;
    private String email;
    private String foundTitle;
    private String foundContent;
    private String foundDate;  // String 타입으로 변경
    private String fRegDate;  // String 타입으로 변경
    private int fViews;
    private String itemState;
    private String locationCode;
    private String fLocationDetail;
    private String itemCode;
    private String fItemDetail;
    private String colorCode;
    private int foundState;


    // 조인 결과
    private String itemName;
    private String colorName;
    private String sidoName;
    private String gugunName;
    private String nickname;
    // Getters and Setters

    public String getNickname() { return nickname; }

    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getFoundIdx() { return foundIdx; }
    public void setFoundIdx(String foundIdx) { this.foundIdx = foundIdx; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getFoundTitle() { return foundTitle; }
    public void setFoundTitle(String foundTitle) { this.foundTitle = foundTitle; }

    public String getFoundContent() { return foundContent; }
    public void setFoundContent(String foundContent) { this.foundContent = foundContent; }

    public String getFoundDate() { return foundDate; }
    public void setFoundDate(String foundDate) { this.foundDate = foundDate; }

    public String getfRegDate() { return fRegDate; }
    public void setfRegDate(String fRegDate) { this.fRegDate = fRegDate; }

    public int getfViews() { return fViews; }
    public void setfViews(int fViews) { this.fViews = fViews; }

    public String getItemState() { return itemState; }
    public void setItemState(String itemState) { this.itemState = itemState; }

    public String getLocationCode() { return locationCode; }
    public void setLocationCode(String locationCode) { this.locationCode = locationCode; }

    public String getfLocationDetail() { return fLocationDetail; }
    public void setfLocationDetail(String fLocationDetail) { this.fLocationDetail = fLocationDetail; }

    public String getItemCode() { return itemCode; }
    public void setItemCode(String itemCode) { this.itemCode = itemCode; }

    public String getfItemDetail() { return fItemDetail; }
    public void setfItemDetail(String fItemDetail) { this.fItemDetail = fItemDetail; }

    public String getColorCode() { return colorCode; }
    public void setColorCode(String colorCode) { this.colorCode = colorCode; }

    public int getFoundState() { return foundState; }
    public void setFoundState(int foundState) { this.foundState = foundState; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public String getColorName() { return colorName; }
    public void setColorName(String colorName) { this.colorName = colorName; }

    public String getSidoName() { return sidoName; }
    public void setSidoName(String sidoName) { this.sidoName = sidoName; }

    public String getGugunName() { return gugunName; }
    public void setGugunName(String gugunName) { this.gugunName = gugunName; }
}