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
    private int locationCode;
    private String fLocationDetail;
    private int itemCode;
    private String fItemDetail;
    private int colorCode;
    private int foundState;

    // 조인 결과
    private String itemName;
    private String colorName;
    private String sidoName;
    private String gugunName;

    // Getters and Setters
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

    public int getLocationCode() { return locationCode; }
    public void setLocationCode(int locationCode) { this.locationCode = locationCode; }

    public String getfLocationDetail() { return fLocationDetail; }
    public void setfLocationDetail(String fLocationDetail) { this.fLocationDetail = fLocationDetail; }

    public int getItemCode() { return itemCode; }
    public void setItemCode(int itemCode) { this.itemCode = itemCode; }

    public String getfItemDetail() { return fItemDetail; }
    public void setfItemDetail(String fItemDetail) { this.fItemDetail = fItemDetail; }

    public int getColorCode() { return colorCode; }
    public void setColorCode(int colorCode) { this.colorCode = colorCode; }

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