
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pagination">
    <c:if test="${pagingHelper.hasPreviousPageGroup()}">
        <a href="?page=1&lost_title=${search.lost_title}&item_code=${search.item_code}&location_code=${search.location_code}&start_date=${search.start_date}&end_date=${search.end_date}&color_code=${search.color_code}" class="page-arrow arrow-first">⇤</a>&nbsp;
        <a href="?page=${pagingHelper.previousPageGroupStart}&lost_title=${search.lost_title}&item_code=${search.item_code}&location_code=${search.location_code}&start_date=${search.start_date}&end_date=${search.end_date}&color_code=${search.color_code}" class="page-arrow arrow-prev">←</a>
    </c:if>

    <c:forEach var="i" begin="${pagingHelper.startPage}" end="${pagingHelper.endPage}">
        <c:choose>
            <c:when test="${i == pagingHelper.nowPage}">
                <span class="now">${i}</span>
            </c:when>
            <c:otherwise>
                <a href="?page=${i}&lost_title=${search.lost_title}&item_code=${search.item_code}&location_code=${search.location_code}&start_date=${search.start_date}&end_date=${search.end_date}&color_code=${search.color_code}" class="page-link">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${pagingHelper.hasNextPageGroup()}">
        <a href="?page=${pagingHelper.nextPageGroupStart}&lost_title=${search.lost_title}&item_code=${search.item_code}&location_code=${search.location_code}&start_date=${search.start_date}&end_date=${search.end_date}&color_code=${search.color_code}" class="page-arrow arrow-next">→</a>&nbsp;
        <!-- lost_title=sdsd, item_code=201205, location_code=100699, start_date=2024-12-10, end_date=2024-12-18, color_code=6 -->
        <a href="?page=${pagingHelper.totalPages}&lost_title=${search.lost_title}&item_code=${search.item_code}&location_code=${search.location_code}&start_date=${search.start_date}&end_date=${search.end_date}&color_code=${search.color_code}" class="page-arrow arrow-last">⇥</a>
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

.page-link:hover { color: black;}

/* 링크에 마우스 오버 시 배경색 변경 */
/* .page-link:hover, .page-arrow:hover {
    background-color: #000;
} */

/* 현재 페이지 표시 스타일 */
.now {
/*     background-color: #333; */
    color: white;
}
.page-arrow { background-color: #DFDFDF; }
 

/* 좌우 화살표에 여백 추가 */
.arrow-prev {
    margin-right: 10px;
}

.arrow-next {
    margin-left: 10px;
}

<c:if test="${ sessionScope.grant eq 'ADMIN' }">
   .now { background-color: #8C6C55; }
  .page-link { background-color: #B39977; }
  .page-link:hover { background-color: #D3C4B1;}
  .page-arrow:hover { background-color: #D3C4B1; }
</c:if>
<c:if test="${ sessionScope.grant ne 'ADMIN' }">
   .now { background-color: #FE8015; }
  .page-link { background-color: #FFAE6B; }
  .page-link:hover { background-color: #FFD5B2;}
  .page-arrow:hover { background-color: #FFD5B2; }
</c:if>
</style>