package com.get.search;

import java.util.Date;

public class FoundItemVo {
    private String foundIdx;
    private String email;
    private String foundTitle;
    private String foundContent;
    private Date foundDate;
    private Date fRegDate;
    private int fViews;
    private String itemState;
    private Integer locationCode;
    private String fLocationDetail;
    private Integer itemCode;
    private String fItemDetail;
    private Integer colorCode;
    private Integer foundState;

    public String getFoundIdx() {
        return foundIdx;
    }
    public void setFoundIdx(String foundIdx) {
        this.foundIdx = foundIdx;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getFoundTitle() {
        return foundTitle;
    }
    public void setFoundTitle(String foundTitle) {
        this.foundTitle = foundTitle;
    }

    public String getFoundContent() {
        return foundContent;
    }
    public void setFoundContent(String foundContent) {
        this.foundContent = foundContent;
    }

    public Date getFoundDate() {
        return foundDate;
    }
    public void setFoundDate(Date foundDate) {
        this.foundDate = foundDate;
    }

    public Date getfRegDate() {
        return fRegDate;
    }
    public void setfRegDate(Date fRegDate) {
        this.fRegDate = fRegDate;
    }

    public int getfViews() {
        return fViews;
    }
    public void setfViews(int fViews) {
        this.fViews = fViews;
    }

    public String getItemState() {
        return itemState;
    }
    public void setItemState(String itemState) {
        this.itemState = itemState;
    }

    public Integer getLocationCode() {
        return locationCode;
    }
    public void setLocationCode(Integer locationCode) {
        this.locationCode = locationCode;
    }

    public String getfLocationDetail() {
        return fLocationDetail;
    }
    public void setfLocationDetail(String fLocationDetail) {
        this.fLocationDetail = fLocationDetail;
    }

    public Integer getItemCode() {
        return itemCode;
    }
    public void setItemCode(Integer itemCode) {
        this.itemCode = itemCode;
    }

    public String getfItemDetail() {
        return fItemDetail;
    }
    public void setfItemDetail(String fItemDetail) {
        this.fItemDetail = fItemDetail;
    }

    public Integer getColorCode() {
        return colorCode;
    }
    public void setColorCode(Integer colorCode) {
        this.colorCode = colorCode;
    }

    public Integer getFoundState() {
        return foundState;
    }
    public void setFoundState(Integer foundState) {
        this.foundState = foundState;
    }
}