package com.get.search;

public class PoliceFoundVo {
    private String atcId;           // 게시글 넘버
    private String depPlace;        // 관할 경찰서
    private String fdFilePathImg;   // 습득물 이미지
    private String fdPrdtNm;        // 물품명
    private String fdSbjt;          // 세부내용
    private String fdYmd;           // 습득 날짜
    private String prdtClNm;        // 물품 분류
    private String clrNm;           // 물품 색상
    private String fdsn;

    public  String getFdsn() {
        return fdsn;
    }

    public void setFdsn(String fdsn) {
        this.fdsn = fdsn;
    }

    public String getAtcId() {
        return atcId;
    }

    public void setAtcId(String atcId) {
        this.atcId = atcId;
    }

    public String getDepPlace() {
        return depPlace;
    }

    public void setDepPlace(String depPlace) {
        this.depPlace = depPlace;
    }

    public String getFdFilePathImg() {
        return fdFilePathImg;
    }

    public void setFdFilePathImg(String fdFilePathImg) {
        this.fdFilePathImg = fdFilePathImg;
    }

    public String getFdPrdtNm() {
        return fdPrdtNm;
    }

    public void setFdPrdtNm(String fdPrdtNm) {
        this.fdPrdtNm = fdPrdtNm;
    }

    public String getFdSbjt() {
        return fdSbjt;
    }

    public void setFdSbjt(String fdSbjt) {
        this.fdSbjt = fdSbjt;
    }

    public String getFdYmd() {
        return fdYmd;
    }

    public void setFdYmd(String fdYmd) {
        this.fdYmd = fdYmd;
    }

    public String getPrdtClNm() {
        return prdtClNm;
    }

    public void setPrdtClNm(String prdtClNm) {
        this.prdtClNm = prdtClNm;
    }

    public String getClrNm() {
        return clrNm;
    }

    public void setClrNm(String clrNm) {
        this.clrNm = clrNm;
    }
}