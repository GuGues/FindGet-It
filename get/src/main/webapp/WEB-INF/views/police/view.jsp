<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>분실물 상세 페이지</title>
  <link rel="stylesheet" href="/css/common.css" />
  <style>

    body {
      font-family: Arial, sans-serif;
      background-color: #ffffff;
      margin-left: 25%;
      padding: 0;
    }

    .detail-container {
      max-width: 1000px;
      height: 100%;
      /*margin: 50px auto;*/
      margin-left: 100px;
      margin-right: 100px;
      background: #fff;
      border: none;
      padding: 20px;
    }

    .detail-header {
      text-align: left;
      margin-bottom: 20px;
      border-bottom: solid #FF914B;
    }

    .detail-header h1 {
      font-size: 28px;
      color: #333;
    }

    .info-section {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 20px;
    }

    .image-container {
      flex: 1;
      text-align: center;
      margin-right: 20px;
    }

    .image-container img {
      max-width: 100%;
      height: auto;
      border-radius: 8px;
      border: 1px solid #ddd;
    }

    .image-container .no-image {
      font-size: 14px;
      color: #777;
      margin-top: 10px;
    }

    .info-content {
      flex: 2;
    }

    .info-content .info {
      margin-bottom: 10px;
    }

    .info-content .label {
      font-weight: bold;
      display: inline-block;
      width: 120px;
    }

    .btn-container {
      text-align: right;
      margin: 20px 0;
    }


    .btn-container button {
      background-color: #FF914B;
      color: white;
      border: none;
      padding: 10px 20px;
      font-size: 16px;
      cursor: pointer;
      margin: 0 5px;
      transition: background-color 0.3s;
    }

    .btn-container button:hover {
      background-color: #E87A2E;
    }

    .btn-container2 {
      text-align: center;
      margin: 20px 0;
    }


    .btn-container2 button {
      background-color: #FF914B;
      color: white;
      border: none;
      padding: 10px 20px;
      font-size: 16px;
      cursor: pointer;
      margin: 0 5px;
      transition: background-color 0.3s;
    }

    .btn-container2 button:hover {
      background-color: #E87A2E;
    }


    .content {
      padding-top: 20px;
      text-align: left;
      height: 150px;
    }
    .content-container {
      text-align: center;
      border-top: solid #FF914B;
      border-bottom: solid #FF914B;
    }

    .map-section {
      margin-top: 30px;
      text-align: left;
    }

    .map-section img {
      width: 100%;
      max-width: 800px;
      border: 1px solid #ccc;
      border-radius: 8px;
    }

    .top-label {
      text-align: right;

    }
  #info-header{
    font-weight: bold;
    font-size: 30px;
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
<div class="detail-container">
  <div class="top-label">
    <h5>
      <a href="/">
        home
      </a> >
      <a href="/">
        습득물
      </a>>
      <a href="/">
        습득물 검색
      </a>>
      <a href="/">
        습득물 상세보기
      </a>
    </h5>
  </div>

  <div class="detail-header">
    <h1 class="title">습득물 상세보기</h1>
    <div class="detail-header-inside">
    </div>
  </div>

  <div class="info-section">
    <!-- 이미지 섹션 -->
    <div class="image-container">
      <img src="${item.fdFilePathImg}" alt="이미지가 없습니다">
      <div class="no-image"></div>
    </div>

    <!-- 상세 정보 섹션 -->
    <div class="info-content">
    <div class="info" id="info-header"><span class="label">물품명</span><c:out value="${item.fdPrdtNm}"/> </div>
    <div class="info"><span class="label">관리ID</span><c:out value="${item.atcId}"/> </div>
    <div class="info"><span class="label">습득일자</span><c:out value="${item.fdYmd}"/> </div>
    <div class="info"><span class="label">보관상태명</span><c:out value="${item.csteSteNm}"/> </div>
    <div class="info"><span class="label">보관장소</span><c:out value="${item.depPlace}"/> </div>
    <div class="info"><span class="label">습득시간</span><c:out value="${item.fdHor}"/> </div>
    <div class="info"><span class="label">습득장소</span><c:out value="${item.fdPlace}"/> </div>
    <div class="info"><span class="label">습득물보관기관구분명</span><c:out value="${item.fndKeepOrgnSeNm}"/> </div>
    <div class="info"><span class="label">기관아이디</span><c:out value="${item.orgId}"/> </div>
    <div class="info"><span class="label">기관명</span><c:out value="${item.orgNm}"/> </div>
    <div class="info"><span class="label">물품분류명</span><c:out value="${item.prdtClNm}"/> </div>
    <div class="info"><span class="label">전화번호</span><c:out value="${item.tel}"/> </div>


    </div>
  </div>

  <!-- 버튼 영역 -->
  <div class="btn-container">

    <button>지도에 분실위치 보기</button>
  </div>

<div class="content-container">
  <div class="content">
    <div class="info"><span class="label"></span><c:out value="${item.uniq}"/> </div>
  </div>
  <div class="btn-container2">
  <button>목록</button>
  </div>
</div>

  <!-- 지도 섹션 -->
  <div class="map-section">
    <h2>분실장소</h2>
    <img src="/img/map-placeholder.jpg" alt="지도 첨부">
  </div>
</div>
</body>
<script>
  console.log("${sessionScope.name}")
</script>
</html>