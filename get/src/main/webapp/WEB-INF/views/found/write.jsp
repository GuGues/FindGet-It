<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>분실물 작성</title>
  <link rel="icon" type="image/png" href="/img/favicon.ico" />
  <style>
    body {
      font-family: 'Arial', sans-serif;
      padding: 20px;
      background-color: #FFFDF9;
    }

    .form-group {
      margin-bottom: 15px;
      width: 100%;
      text-align: left;
    }

    .form-group label {
      font-weight: bold;
      margin-bottom: 5px;
    }

    .form-control {
      width: 100%;
      padding: 10px;
      font-size: 14px;
      border: 1px solid #FE8015;
      border-radius: 5px;
      outline: none;
      background-color: #FFFDF9;
      box-sizing: border-box;
    }

    .form-control:focus {
      border-color: #FF5722;
      box-shadow: 0 0 5px rgba(255, 87, 34, 0.5);
    }

    .big-div {
      margin-top: 60px;
      background-color: #FFF;
      border: 1px solid #FE8015;
      padding: 5%;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
      text-align: center;
      width: 70%;
      margin: 0 auto;
    }

    .titleBox {
      text-align: left;
      margin-left: 10%;
      margin-bottom: 1%;
    }

    main {
      margin-left: 20%;
    }

    a {
      color: black;
    }

    button {
      padding: 10px 20px;
      background-color: #FE8015;
      color: white;
      font-weight: bold;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    button:hover {
      background-color: #FF5722;
    }
  </style>
</head>
<body>
  <c:choose>
    <c:when test="${ sessionScope.grant eq 'ADMIN' }">
      <%@include file="/WEB-INF/include/adminSide.jsp" %>
    </c:when>
    <c:when test="${ sessionScope.grant ne 'ADMIN' }">
      <%@include file="/WEB-INF/include/side.jsp" %>
    </c:when>
  </c:choose>
<main>
  <div class="mega-div">
    <div class="titleBox">
      <div class="right" style="font-size: 13px;">
        <a href="/">HOME</a>&nbsp;&gt;&nbsp;<a href="/lost">습득물</a>&nbsp;&gt;&nbsp;<a href="/lost">습득물 작성</a>
      </div>
      <h3 class="title">습득물 작성</h3>
      <span>분실하신 물건 여부를 확인하시고, 아래 기재된 보관장소연락처로 보관번호를 말씀해주시기 바랍니다.</span>
    </div>
    <div class="big-div">
      <form action="http://192.168.0.214:9090/found/insert" method="POST" enctype="multipart/form-data">
        <div class="form-group">
          <label for="nickname">작성자 닉네임</label>
          <input type="text" id="nickname" class="form-control" value="${userNickname}" readonly />
        </div>
        <input type="hidden" name="email" value="${userEmail}" />

        <div class="form-group">
          <label for="locationCode">습득 지역</label>
          <select id="locationCode" name="locationCode" class="form-control" required>
            <option value="">선택</option>
            <c:forEach var="loc" items="${locations}">
              <option value="${loc.LOCATIONCODE}">${loc.SIDONAME}:${loc.GUGUNNAME}</option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label for="fLocationDetail">상세 주소</label>
          <input type="text" id="fLocationDetail" name="fLocationDetail" class="form-control" required>
        </div>

        <div class="form-group">
          <label for="foundDate">습득일자</label>
          <input type="date" id="foundDate" name="foundDate" class="form-control" required>
        </div>

        <div class="form-group">
          <label for="itemCode">물품 분류</label>
          <select id="itemCode" name="itemCode" class="form-control" required>
            <option value="">선택</option>
            <c:forEach var="it" items="${items}">
              <option value="${it.ITEMCODE}">${it.ITEMNAME}</option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label for="colorCode">색상</label>
          <select id="colorCode" name="colorCode" class="form-control">
            <option value="">선택</option>
            <c:forEach var="color" items="${colors}">
              <option value="${color.COLORCODE}">${color.COLORNAME}</option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group">
          <label for="foundTitle">공지 제목</label>
          <input type="text" id="foundTitle" name="foundTitle" class="form-control" required>
        </div>

        <div class="form-group">
          <label for="foundContent">내용 및 특이사항</label>
          <textarea id="foundContent" name="foundContent" rows="5" class="form-control" required></textarea>
        </div>

        <!-- 이미지 업로드 -->
        <div class="form-group">
          <label for="uploadFile">물품 이미지 업로드</label>
          <input type="file" id="uploadFile" name="uploadFile" class="form-control">
        </div>

        <div>
          <button type="submit">등록</button>
          <button type="reset">취소</button>
        </div>
      </form>
    </div>
  </div>
</main>
</body>
</html>