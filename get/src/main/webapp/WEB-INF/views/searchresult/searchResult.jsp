<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>검색 결과</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      padding: 20px;
      background: #f9f9f9;
    }
    h1 {
      margin-bottom: 20px;
    }
    .search-info {
      margin-bottom: 20px;
      font-size: 18px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      background: #fff;
      margin-bottom: 30px;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 12px;
      text-align: left;
    }
    th {
      background: #FF914B;
      color: #fff;
    }
    tr:nth-child(even) {
      background: #f2f2f2;
    }
    .pagination {
      text-align: center;
      margin-top: 20px;
    }
    .pagination a {
      display: inline-block;
      margin: 0 5px;
      padding: 10px 15px;
      text-decoration: none;
      background: #FF914B;
      color: #fff;
      border-radius: 4px;
    }
    .pagination a:hover {
      background: #EFC03E;
    }
    .pagination .current {
      background: #333;
    }
    .section-title {
      font-size: 20px;
      margin-bottom: 10px;
      margin-top: 40px;
    }
  </style>
</head>
<body>

<h1>"${keyword}" 검색 결과</h1>

<c:choose>
  <c:when test="${empty lostItems and empty foundItems}">
    <div class="search-info">검색 결과가 없습니다.</div>
  </c:when>
  <c:otherwise>
    <c:if test="${not empty lostItems}">
      <div class="section-title">분실물 정보 (총 <c:out value="${lostPaging.totalRecords}"/>건)</div>
      <table>
        <thead>
        <tr>
          <th>관리ID</th>
          <th>이메일</th>
          <th>분실물명(제목)</th>
          <th>분실물내용</th>
          <th>분실일자</th>
          <th>등록일자</th>
          <th>조회수</th>
          <th>장소 상세</th>
          <th>물품 상세</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${lostItems}">
          <tr>
            <td><c:out value="${item.lostIdx}"/></td>
            <td><c:out value="${item.email}"/></td>
            <td><c:out value="${item.lostTitle}"/></td>
            <td><c:out value="${item.lostContent}"/></td>
            <td><c:out value="${item.lostDate}"/></td>
            <td><c:out value="${item.lRegDate}"/></td>
            <td><c:out value="${item.lViews}"/></td>
            <td><c:out value="${item.lLocationDetail}"/></td>
            <td><c:out value="${item.lItemDetail}"/></td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
      <div class="pagination">
        <c:if test="${lostPaging.currentPage > 1}">
          <a href="?keyword=${keyword}&lostPage=${lostPaging.currentPage - 1}">&laquo; 이전</a>
        </c:if>

        <c:forEach begin="1" end="${lostPaging.totalPages}" var="p">
          <c:choose>
            <c:when test="${p == lostPaging.currentPage}">
              <span class="current" style="background:#333;color:#fff;padding:10px 15px;border-radius:4px;">${p}</span>
            </c:when>
            <c:otherwise>
              <a href="?keyword=${keyword}&lostPage=${p}">${p}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>

        <c:if test="${lostPaging.currentPage < lostPaging.totalPages}">
          <a href="?keyword=${keyword}&lostPage=${lostPaging.currentPage + 1}">다음 &raquo;</a>
        </c:if>
      </div>
    </c:if>

    <c:if test="${not empty foundItems}">
      <div class="section-title">습득물 정보 (총 <c:out value="${foundPaging.totalRecords}"/>건)</div>
      <table>
        <thead>
        <tr>
          <th>관리ID</th>
          <th>이메일</th>
          <th>습득물명(제목)</th>
          <th>습득물내용</th>
          <th>습득일자</th>
          <th>등록일자</th>
          <th>조회수</th>
          <th>상태</th>
          <th>장소 상세</th>
          <th>물품 상세</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="fitem" items="${foundItems}">
          <tr>
            <td><c:out value="${fitem.foundIdx}"/></td>
            <td><c:out value="${fitem.email}"/></td>
            <td><c:out value="${fitem.foundTitle}"/></td>
            <td><c:out value="${fitem.foundContent}"/></td>
            <td><c:out value="${fitem.foundDate}"/></td>
            <td><c:out value="${fitem.fRegDate}"/></td>
            <td><c:out value="${fitem.fViews}"/></td>
            <td><c:out value="${fitem.itemState}"/></td>
            <td><c:out value="${fitem.fLocationDetail}"/></td>
            <td><c:out value="${fitem.fItemDetail}"/></td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
      <div class="pagination">
        <c:if test="${foundPaging.currentPage > 1}">
          <a href="?keyword=${keyword}&foundPage=${foundPaging.currentPage - 1}">&laquo; 이전</a>
        </c:if>

        <c:forEach begin="1" end="${foundPaging.totalPages}" var="fp">
          <c:choose>
            <c:when test="${fp == foundPaging.currentPage}">
              <span class="current" style="background:#333;color:#fff;padding:10px 15px;border-radius:4px;">${fp}</span>
            </c:when>
            <c:otherwise>
              <a href="?keyword=${keyword}&foundPage=${fp}">${fp}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>

        <c:if test="${foundPaging.currentPage < foundPaging.totalPages}">
          <a href="?keyword=${keyword}&foundPage=${foundPaging.currentPage + 1}">다음 &raquo;</a>
        </c:if>
      </div>
    </c:if>
  </c:otherwise>
</c:choose>

</body>
</html>