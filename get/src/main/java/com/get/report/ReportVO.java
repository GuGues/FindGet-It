package com.get.report;

import java.util.Date;

public class ReportVO {
    private String reportIdx;   // REPORT_IDX
    private String reporterIdx; // 신고자
    private String resiverIdx;  // 신고 대상(게시글 번호 or 사용자 ID 등)
    private String rContent;    // 신고 상세내용
    private Date   rRegDate;    // 신고 등록일(디폴트 SYSDATE)

    public String getReportIdx() {
        return reportIdx;
    }
    public void setReportIdx(String reportIdx) {
        this.reportIdx = reportIdx;
    }

    public String getReporterIdx() {
        return reporterIdx;
    }
    public void setReporterIdx(String reporterIdx) {
        this.reporterIdx = reporterIdx;
    }

    public String getResiverIdx() {
        return resiverIdx;
    }
    public void setResiverIdx(String resiverIdx) {
        this.resiverIdx = resiverIdx;
    }

    public String getrContent() {
        return rContent;
    }
    public void setrContent(String rContent) {
        this.rContent = rContent;
    }

    public Date getrRegDate() {
        return rRegDate;
    }
    public void setrRegDate(Date rRegDate) {
        this.rRegDate = rRegDate;
    }
}