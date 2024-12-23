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

  </style>
</head>
<body>
<%@include file="/WEB-INF/include/side.jsp" %>


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
    <h4>분실하신 물건여부를 확인하시고
      <br>
      본인의 물건이 맞다면 관할기관 신고나 채팅으로 연락 부탁드립니다.</h4>
    </div>
  </div>

  <div class="info-section">
    <!-- 이미지 섹션 -->
    <div class="image-container">
      <img src="/img/noimg.png" alt="이미지가 없습니다">
      <div class="no-image"></div>
    </div>

    <!-- 상세 정보 섹션 -->
    <div class="info-content">
      <div class="info">
        <span class="label">습득물명:</span> <c:out value="${item.foundTitle}"/>
      </div>
      <div class="info">
        <span class="label">관리번호:</span> <c:out value="${item.foundIdx}"/>
      </div>
      <div class="info">
        <span class="label">습득일:</span> <c:out value="${item.foundDate}"/>
      </div>
      <div class="info">
        <span class="label">물품분류:</span> <c:out value="${item.itemName}"/>
      </div>
      <div class="info">
        <span class="label">물품색상:</span> <c:out value="${item.colorName}"/>
      </div>
     <div class="info">
    <span class="label">지역:</span> <c:out value="${item.sidoName}"/> <c:out value="${item.gugunName}"/>
    </div>
    </div>
  </div>

  <!-- 버튼 영역 -->
  <div class="btn-container">
    <button>1대1 문의 보내기</button>
    <button>분실물 처리현황</button>
    <button>지도에 분실위치 보기</button>
  </div>

<div class="content-container">
  <div class="content">
    <c:out value="${item.foundContent}"/>
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
</html>