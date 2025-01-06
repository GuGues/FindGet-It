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
    .form-group { margin-bottom: 15px; width: 100%; text-align: left; }
    .form-group label { display: block; font-weight: bold; margin-bottom: 5px; width: 100%; }
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
    /* big-div 비율 유지하면서 크기 줄이기 */
    .big-div {
      margin-top: 60px; /* 상단 여백 */
      background-color: #ffe3cc; /* 배경색 */
      padding: 5%; /* 내부 여백 */
      border-radius: 10px; /* 모서리 반지름 */
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
      text-align: center; /* 텍스트 중앙 정렬 */
      width: 70%; /* 너비 설정 */
      z-index: 1; /* 배경보다 위에 오도록 설정 */
      margin: 0 auto; /* 화면에서 수평 중앙 정렬 */
      /*display: flex;*/ /* Flexbox로 자식 요소 배치 */
      justify-content: center; /* 자식 요소를 수평 중앙 정렬 */
      position: relative; /* 자식의 절대 위치를 기준으로 함 */
      height: auto; /* 고정 높이를 제거하여 콘텐츠에 맞게 확장 */
      overflow: hidden; /* 넘치는 콘텐츠 숨김 */
      /*transform: scale(0.8); !* 비율 유지하면서 크기 줄이기 *!*/
      /*transform-origin: top center; !* 크기 축소 중심 설정 *!*/
    }
    .titleBox {
      text-align: left;
      margin-left: 10%;
      margin-bottom: 1%;

    }
    main{
      margin-left: 20%;
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
          <c:out value="${loc['sidoName'][0].value}" />
          <option value="${loc.LOCATIONCODE}">
              ${loc.SIDONAME}:${loc.GUGUNNAME}
          </option>
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
          <c:out value="${it['colorName'][0].value}" />
          <option value="${it.ITEMCODE}">${it.ITEMNAME}</option>
        </c:forEach>
      </select>
    </div>




    <div class="form-group">
      <label for="itemState">물품 상태 정보</label>
      <input type="text" id="itemState" name="itemState" class="form-control">
    </div>

    <!-- 이미지 업로드 섹션 -->
    <div class="form-group image-upload-section">
      <label>물품 이미지 업로드</label>
      <p style="color:gray;"><input type="file" class="fileInput" name="uploadFile"></p>
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
      <label for="foundTitle">공지 제목</label>
      <input type="text" id="foundTitle" name="foundTitle" class="form-control" required>
    </div>

    <div class="form-group">
      <label for="foundContent">내용 및 특이사항</label>
      <textarea id="foundContent" name="foundContent" rows="5" class="form-control" required></textarea>
    </div>

    <div class="spinner" id="loadingSpinner"></div>

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