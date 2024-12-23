package com.get.paging;

public class pagingHelper {
	private int nowPage;
    private int totalPages;
    private int startPage;
    private int endPage;
    private int pageGroupSize = 10; // 페이지 그룹 크기

    public pagingHelper(int totalRecords, int currentPage, int recordsPerPage) {
        this.nowPage = currentPage;
        this.totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        // 시작 페이지와 끝 페이지 계산
        this.startPage = ((nowPage - 1) / pageGroupSize) * pageGroupSize + 1;
        this.endPage = Math.min(startPage + pageGroupSize - 1, totalPages);
    }

    public boolean hasPreviousPageGroup() {
        return startPage > 1;
    }

    public boolean hasNextPageGroup() {
        return endPage < totalPages;
    }

    public int getPreviousPageGroupStart() {
        return startPage - pageGroupSize;
    }

    public int getNextPageGroupStart() {
        return endPage + 1;
    }

    // Getters for JSP page
    public int getStartPage() { return startPage; }
    public int getEndPage() { return endPage; }
    public int getNowPage() { return nowPage; }
    public int getTotalPages() { return totalPages; }
}