<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>검색 결과</title>
    <link rel="stylesheet" href="/css/common.css" />
  <style>
    body {
      font-family: Arial, sans-serif;
      padding: 20px;
      background: #f9f9f9;
    }
    h1 {
      margin-left: 60px;
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
      border: solid #FF914B;
        border-radius: 10px;


    }
    th, td {
      padding: 12px;
      text-align: left;

    }
    th {
      background: #FF914B;
      color: #fff;
    }
    td {
      border-left: #FE8015 solid 1px
    }
    tr:nth-child(even) {

        background: #f2f2f2;
    }

    .listItem {
      cursor: pointer;
      transition: background-color 0.3s ease;
        border: solid #FF914B;

    }
    .listItem:hover {
      background-color: #FFD5B2;
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
    a {
      text-decoration: none;
      color: black;
    }
    body {
      font-family: Arial, sans-serif;
      background-color: #ffffff;
      margin-left: 20%;
      padding: 0;
    }

    .lostbox {
      max-width: 1300px;
      height: 100%;
      /*margin: 50px auto;*/
      margin-left: 100px;
      margin-right: 100px;
      background: #fff;
      border: none;
      padding: 20px;
    }

  h1{
      font-family: yangjin;
  }

  </style>
</head>
<body>
<c:choose>
    <c:when test="${ sessionScope.grant eq 'ADMIN' }">
      <%@include file="/WEB-INF/include/adminSide.jsp" %>
    </c:when>
    <c:when test="${ sessionScope.grant ne 'ADMIN' || !sessionScope.grant }">
      <%@include file="/WEB-INF/include/side.jsp" %>
    </c:when>
</c:choose>

<div class="bigbox">

<h1>"${keyword}" 검색 결과</h1>


<c:choose>
  <c:when test="${empty lostItems and empty foundItems}">
    <div class="search-info">검색 결과가 없습니다.</div>
  </c:when>
  <c:otherwise>
    <c:if test="${not empty lostItems}">
      <div class="lostbox">
      <div class="section-title">분실물 정보 (총 <c:out value="${lostPaging.totalRecords}"/>건)</div>
      <table>
        <thead>
        <tr>
          <th>분실물</th>
          <th>이메일</th>
          <th>분실일자</th>
          <th>물품 상세</th>
          <th>조회수</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${lostItems}">
          <tr class="listItem" onclick="location.href='/lost/view?lostIdx=${item.lostIdx}'">
            <td><c:out value="${item.lostTitle}"/></td>
            <td><c:out value="${item.email}"/></td>
            <td><c:out value="${item.lostDate}"/></td>
            <td><c:out value="${item.lItemDetail}"/></td>
            <td><c:out value="${item.lViews}"/></td>
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
      </div>

    <c:if test="${not empty foundItems}">
<div class="lostbox">
      <div class="section-title">습득물 정보 (총 <c:out value="${foundPaging.totalRecords}"/>건)</div>
      <table>
        <thead>
        <tr>
          <th>습득물</th>
          <th>이메일</th>
          <th>습득일자</th>
          <th>상태</th>
          <th>물품 상세</th>
          <th>조회수</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="fitem" items="${foundItems}">
          <tr class="listItem" onclick="location.href='/found/view?foundIdx=${fitem.foundIdx}'">
            <td><c:out value="${fitem.foundTitle}"/></td>
            <td><c:out value="${fitem.email}"/></td>
            <td><c:out value="${fitem.foundDate}"/></td>
            <td><c:out value="${fitem.itemState}"/></td>
            <td><c:out value="${fitem.fItemDetail}"/></td>
            <td><c:out value="${fitem.fViews}"/></td>
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
</div>
</div>
</body>
</html>