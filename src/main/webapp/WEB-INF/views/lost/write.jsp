<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>분실물 작성</title>
  <style>
    body { font-family: Arial, sans-serif; padding: 20px; }
    .form-group { margin-bottom: 15px; }
    .form-group label { display: block; font-weight: bold; margin-bottom: 5px; }
    .form-control { width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; }
    select, input[type="text"], input[type="date"], textarea {
      border: 1px solid #ccc; border-radius: 4px;
      width: 100%;
    }
    button { padding: 10px 20px; background-color: #FF914B; color: white; border: none; border-radius: 5px; cursor: pointer; }
    button:hover { background-color: #E67E22; }
  </style>
</head>
<body>
<h1>분실물 작성</h1>
<form action="/lost/write" method="POST">
  <div class="form-group">
    <label for="locationCode">분실 지역</label>
    <select id="locationCode" name="locationCode" class="form-control" required>
      <option value="">선택</option>
      <c:forEach var="loc" items="${locations}">
        <c:out value="${loc['sidoName'][0].value}" />
        <option value="${loc.value}">${loc.SIDONAME}:${loc.GUGUNNAME}</option>
      </c:forEach>
    </select>
  </div>

  <div class="form-group">
    <label for="lLocationDetail">상세 주소</label>
    <input type="text" id="lLocationDetail" name="lLocationDetail" class="form-control" required>
  </div>

  <div class="form-group">
    <label for="lostDate">분실일자</label>
    <input type="date" id="lostDate" name="lostDate" class="form-control" required>
  </div>
  <div class="form-group">
    <label for="itemCode">물품 분류</label>
    <select id="itemCode" name="itemCode" class="form-control" required>
      <option value="">선택</option>
      <c:forEach var="it" items="${items}">
        <c:out value="${it['colorName'][0].value}" />
        <option value="${it.ITEMCODE}">${it.ITEMNAME}</option>
      </c:forEach>
    </select>
  </div>

  <div class="form-group">
    <label for="lItemDetail">물품 상세 정보</label>
    <input type="text" id="lItemDetail" name="lItemDetail" class="form-control">
  </div>

  <div class="form-group">
    <label for="reward">사례금</label>
    <input type="number" id="reward" name="reward" class="form-control" min="0">
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
    <label for="lostTitle">공지 제목</label>
    <input type="text" id="lostTitle" name="lostTitle" class="form-control" required>
  </div>

  <div class="form-group">
    <label for="lostContent">내용 및 특이사항</label>
    <textarea id="lostContent" name="lostContent" rows="5" class="form-control" required></textarea>
  </div>

  <div>
    <button type="submit">등록</button>
    <button type="reset">취소</button>
  </div>
</form>
</body>
</html>