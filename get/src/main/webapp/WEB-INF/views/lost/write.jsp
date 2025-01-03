<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>분실물 작성</title>
  <style>
    /* 기존 스타일 유지 */
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

    /* 이미지 업로드 섹션 스타일 (나중에 구현할 예정) */
    .image-upload-section {
      margin-bottom: 20px;
    }
    .image-preview {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      margin-top: 10px;
    }
    .image-preview img {
      width: 100px;
      height: 100px;
      object-fit: cover;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    .image-preview .image-container {
      position: relative;
    }
    .image-preview .image-container .remove-image {
      position: absolute;
      top: 2px;
      right: 2px;
      background: rgba(255, 0, 0, 0.7);
      color: white;
      border: none;
      border-radius: 50%;
      width: 20px;
      height: 20px;
      cursor: pointer;
      font-size: 14px;
      line-height: 18px;
      text-align: center;
    }
    /* 호버 효과 */
    .listItem:hover {
      background-color: #FFD5B2 !important;
      cursor: pointer;
    }
    /* 로딩 스피너 스타일 */
    .spinner {
      display: none;
      border: 4px solid rgba(0,0,0,0.1);
      width: 36px;
      height: 36px;
      border-radius: 50%;
      border-left-color: #09f;
      animation: spin 1s ease infinite;
      margin: 20px auto;
    }
    @keyframes spin {
      to { transform: rotate(360deg); }
    }
  </style>
</head>
<body>

<main>
  <div class="titleBox">
    <div class="right" style="font-size: 13px;">
      <a href="/">HOME</a>&nbsp;&gt;&nbsp;<a href="/lost">분실물</a>&nbsp;&gt;&nbsp;<a href="/lost">분실물 작성</a>
    </div>
    <h3 class="title">분실물 작성</h3>
    <span>분실하신 물건 여부를 확인하시고, 아래 기재된 보관장소연락처로 보관번호를 말씀해주시기 바랍니다.</span>
  </div>

  <form action="/lost/write" method="post">

    <div class="form-group">
      <label for="nickname">작성자 닉네임</label>
      <input type="text" id="nickname" class="form-control" value="${userNickname}" readonly />
    </div>
    <input type="hidden" name="email" value="${userEmail}" />

    <div class="form-group">
      <label for="locationCode">분실 지역</label>
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

    <div class="form-group image-upload-section">
      <label>물품 이미지 업로드 (추후 구현 예정)</label>
      <p style="color:gray;">※ 이미지 업로드 기능은 나중에 구현됩니다.</p>
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

    <div class="spinner" id="loadingSpinner"></div>

    <div>
      <button type="submit">등록</button>
      <button type="reset">취소</button>
    </div>
  </form>
</main>

</body>
</html>