package com.get.search;

public class PagingHelper {
    private int totalRecords;    // 총 레코드 수
    private int currentPage;     // 현재 페이지
    private int recordsPerPage;  // 페이지 당 표시할 레코드 수
    private int totalPages;      // 총 페이지 수

    private int displayPageCount = 5; // 한 번에 표시할 페이지 링크 수
    private int beginPage;       // 네비게이션 시작 페이지
    private int endPage;         // 네비게이션 끝 페이지

    public PagingHelper(int totalRecords, int currentPage, int recordsPerPage) {
        this.totalRecords = totalRecords;
        this.currentPage = currentPage;
        this.recordsPerPage = recordsPerPage;

        // 총 페이지 수 계산
        this.totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        // 총 페이지가 0이면(레코드 없으면) currentPage를 1로 유지
        if (this.totalPages == 0) {
            this.totalPages = 1;
        }

        // 현재 페이지가 범위를 벗어나지 않도록 조정
        if (this.currentPage < 1) {
            this.currentPage = 1;
        } else if (this.currentPage > totalPages) {
            this.currentPage = totalPages;
        }

        // 네비게이션 시작 페이지와 끝 페이지 계산
        this.beginPage = ((this.currentPage - 1) / displayPageCount) * displayPageCount + 1;
        this.endPage = this.beginPage + displayPageCount - 1;

        if (this.endPage > this.totalPages) {
            this.endPage = this.totalPages;
        }
    }

    // Getter 메서드
    public int getTotalRecords() {
        return totalRecords;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public int getRecordsPerPage() {
        return recordsPerPage;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public int getStartRecord() {
        return (currentPage - 1) * recordsPerPage;
    }

    public int getEndRecord() {
        return currentPage * recordsPerPage;
    }

    public int getBeginPage() {
        return beginPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public int getDisplayPageCount() {
        return displayPageCount;
    }
}