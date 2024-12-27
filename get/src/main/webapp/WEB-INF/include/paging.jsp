
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pagination">
    <c:if test="${pagingHelper.hasPreviousPageGroup()}">
        <a href="?page=1" class="page-arrow arrow-first">⇤</a>
        <a href="?page=${pagingHelper.previousPageGroupStart}" class="page-arrow arrow-prev">←</a>
    </c:if>

    <c:forEach var="i" begin="${pagingHelper.startPage}" end="${pagingHelper.endPage}">
        <c:choose>
            <c:when test="${i == pagingHelper.nowPage}">
                <span class="now">${i}</span>
            </c:when>
            <c:otherwise>
                <a href="?page=${i}" class="page-link">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${pagingHelper.hasNextPageGroup()}">
        <a href="?page=${pagingHelper.nextPageGroupStart}" class="page-arrow arrow-next">→</a>
        <a href="?page=${pagingHelper.totalPages}" class="page-arrow arrow-last">⇥</a>
    </c:if>
</div>

<style>
/* 페이지네이션 스타일 설정 */
.pagination {
    text-align: center;
    margin-top: 20px;
}

/* 각 페이지 링크 스타일 */
.page-link, .page-arrow, .now {
    display: inline-block;
    width: 40px; /* 버튼의 고정 너비 */
    height: 40px; /* 버튼의 고정 높이 */
    padding: 0;
    line-height: 40px;
/*     background-color: #555; */
    color: white;
    text-decoration: none;
    border-radius: 4px;
    transition: background-color 0.3s ease;
    text-align: center;
    font-weight: bold;
}

.page-link { background-color: #FFAE6B; }
.page-link:hover { background-color: #FFD5B2;  color: black;}
.page-arrow:hover { background-color: #EFC03E; }

/* 링크에 마우스 오버 시 배경색 변경 */
/* .page-link:hover, .page-arrow:hover {
    background-color: #000;
} */

/* 현재 페이지 표시 스타일 */
.now {
/*     background-color: #333; */
    color: white;
}
.now { background-color: #FE8015; }
.page-arrow { background-color: #9B7714; }
 

/* 좌우 화살표에 여백 추가 */
.arrow-prev {
    margin-right: 10px;
}

.arrow-next {
    margin-left: 10px;
}
</style>