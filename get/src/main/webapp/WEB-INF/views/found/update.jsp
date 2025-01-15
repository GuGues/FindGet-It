<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>습득물 수정</title>
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
<h1>습득물 수정</h1>

<!-- 닉네임과 관리번호는 read-only -->
<form action="/found/update" method="post">
  <!-- 관리번호 (foundIdx)는 숨겨진 input or 읽기 전용 -->
  <div class="form-group">
    <label for="foundIdx">관리번호</label>
    <!-- 읽기 전용, 하지만 값은 서버에 전송해야 하므로 hidden도 같이 쓰거나 disabled 대신 readonly -->
    <input type="text" id="foundIdx" name="foundIdx" class="form-control readonly"
           value="${item.foundIdx}" readonly />
  </div>

  <div class="form-group">
    <label for="nickname">작성자 닉네임</label>
    <input type="text" id="nickname" name="nickname" class="form-control readonly"
           value="${item.nickname}" readonly />
  </div>

  <!-- 이하 필드들은 수정 가능 -->
  <div class="form-group">
    <label for="foundTitle">제목</label>
    <input type="text" id="foundTitle" name="foundTitle" class="form-control"
           value="${item.foundTitle}" />
  </div>

  <div class="form-group">
    <label for="foundDate">습득일자</label>
    <input type="date" id="foundDate" name="foundDate" class="form-control"
           value="${item.foundDate}"  required/>
  </div>

  <div class="form-group">
    <label for="itemCode">물품 분류</label>
    <select id="itemCode" name="itemCode" class="form-control">
      <!-- 기존 아이템 목록 -->
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
    <label for="fItemDetail">물품 상세 정보</label>
    <input type="text" id="fItemDetail" name="fItemDetail" class="form-control"
           value="${item.fItemDetail}" />
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
    <label for="fLocationDetail">상세 주소</label>
    <input type="text" id="fLocationDetail" name="fLocationDetail" class="form-control"
           value="${item.fLocationDetail}" />
  </div>

  <div class="form-group">
    <label for="itemState">물품 상태</label>
    <input type="text" id="itemState" name="itemState" class="form-control"
           value="${item.itemState}" />
  </div>

  <div class="form-group">
    <label for="foundContent">내용 및 특이사항</label>
    <textarea id="foundContent" name="foundContent" rows="5" class="form-control">${item.foundContent}</textarea>
  </div>

  <!-- hidden으로 email도 넘길 수 있음 -->
  <input type="hidden" name="email" value="${item.email}" />

  <button type="submit">수정하기</button>
</form>

</body>
</html>