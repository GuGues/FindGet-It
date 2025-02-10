<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>습득물 수정</title>
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
<%@include file="/WEB-INF/include/side.jsp" %>
<main>
<div class="mega-div">
  <div class="titleBox">
    <div class="right" style="font-size: 13px;">
      <a href="/">HOME</a>&nbsp;&gt;&nbsp;<a href="/found">습득물</a>&nbsp;&gt;&nbsp;<a href="/found">분실물 수정</a>
    </div>
    <h3 class="title">분실물 게시글 수정</h3>
  </div>

  <div class="big-div">
<form action="/lost/update" method="post">
  <div class="form-group">
    <label for="lostIdx">관리번호</label>
    <input type="text" id="lostIdx" name="lostIdx" class="form-control readonly"
           value="${item.lostIdx}" readonly />
  </div>

  <div class="form-group">
    <label for="nickname">작성자 닉네임</label>
    <input type="text" id="nickname" name="nickname" class="form-control readonly"
           value="${item.nickname}" readonly />
  </div>

  <div class="form-group">
    <label for="lostTitle">제목</label>
    <input type="text" id="lostTitle" name="lostTitle" class="form-control"
           value="${item.lostTitle}" />
  </div>

  <div class="form-group">
    <label for="lostDate">습득일자</label>
    <input type="date" id="lostDate" name="lostDate" class="form-control"
           value="${item.lostDate}"  required/>
  </div>

  <div class="form-group">
    <label for="itemCode">물품 분류</label>
    <select id="itemCode" name="itemCode" class="form-control">
      <option value="">선택</option>
      <c:forEach var="it" items="${items}">
        <option value="${it.ITEMCODE}"
                <c:if test="${it.ITEMCODE == item.itemCode}">selected</c:if>>
            ${it.ITEMNAME}
        </option>
      </c:forEach>
    </select>
  </div>

  <div class="form-group">
    <label for="lItemDetail">물품 상세 정보</label>
    <input type="text" id="lItemDetail" name="lItemDetail" class="form-control"
           value="${item.lItemDetail}" />
  </div>

  <div class="form-group">
    <label for="colorCode">색상</label>
    <select id="colorCode" name="colorCode" class="form-control">
      <option value="">선택</option>
      <c:forEach var="color" items="${colors}">
        <c:out value="${color['colorName'][0].value}" />
        <option value="${color.COLORCODE}">${color.COLORNAME}</option>
      </c:forEach>
    </select>
  </div>

  <div class="form-group">
    <label for="locationCode">습득 지역</label>
    <select id="locationCode" name="locationCode" class="form-control" required>
      <option value="">선택</option>
      <c:forEach var="loc" items="${locations}">
        <c:out value="${loc['sidoName'][0].value}" />
        <option value="${loc.LOCATIONCODE}">
            ${loc.SIDONAME}:${loc.GUGUNNAME}
        </option>
      </c:forEach>
    </select>
  </div>

  <div class="form-group">
    <label for="lLocationDetail">상세 주소</label>
    <input type="text" id="lLocationDetail" name="lLocationDetail" class="form-control"
           value="${item.lLocationDetail}" />
  </div>


  <div class="form-group">
    <label for="lostContent">내용 및 특이사항</label>
    <textarea id="lostContent" name="lostContent" rows="5" class="form-control">${item.lostContent}</textarea>
  </div>

  <input type="hidden" name="email" value="${item.email}" />

  <button type="submit">수정하기</button>
</form>
</div>
</div>
</main>
</body>
</html>