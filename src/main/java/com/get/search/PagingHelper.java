package com.get.search;

public class PagingHelper {
    private int totalRecords;    // 총 레코드 수
    private int currentPage;     // 현재 페이지
    private int recordsPerPage;  // 페이지 당 표시할 레코드 수
    private int totalPages;      // 총 페이지 수

    public PagingHelper(int totalRecords, int currentPage, int recordsPerPage) {
        this.totalRecords = totalRecords;
        this.currentPage = currentPage;
        this.recordsPerPage = recordsPerPage;

        this.totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        // 총 페이지가 0이면(레코드 없으면) currentPage를 1로 유지
        if (this.totalPages == 0) {
            this.totalPages = 1;
        }

        if (this.currentPage < 1) {
            this.currentPage = 1;
        } else if (this.currentPage > totalPages) {
            this.currentPage = totalPages;
        }
    }

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

    // 페이지네이션 UI를 위해 시작/끝 페이지 등의 메서드를 추가할 수도 있음
}