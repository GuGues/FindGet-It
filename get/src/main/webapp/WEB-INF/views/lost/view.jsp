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

    .detail-header-inside h4 {
      margin-top: 10px;
      color: #555;
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

    .content-container {
      text-align: center;
      border-top: solid #FF914B;
      border-bottom: solid #FF914B;
      margin-bottom: 20px;
    }

    .content {
      padding-top: 20px;
      text-align: left;
      min-height: 150px;
      /* 높이 상황에 따라 조정 */
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

    .top-label h5 a {
      text-decoration: none;
      color: #666;
    }

    .top-label h5 a:hover {
      text-decoration: underline;
    }

    h1 {
      font-family: yangjin;
    }

    .modal-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.6);
      display: none; /* 초기 상태는 숨김 */
      justify-content: center;
      align-items: center;
      z-index: 1000;
    }

    .modal-content {
      background: white;
      padding: 20px;
      border-radius: 8px;
      max-width: 500px;
      width: 90%;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
      text-align: left;
    }
  <c:if test="${ sessionScope.grant eq 'ADMIN'}">
    .detail-header {
      border-bottom: solid #8C6C55;
    }
    .btn-container button {
      background-color: #8C6C55;
    }
    .content-container {
      border-top: solid #8C6C55;
      border-bottom: solid #8C6C55;
    }
    .btn-container2 button {
      background-color: #8C6C55;
    }
    .content-container {
      border-top: solid #8C6C55;
      border-bottom: solid #8C6C55;
    }
    .btn-container button:hover {
      background-color: #D3C4B1;
    }
    .btn-container2 button:hover {
      background-color: #D3C4B1;
    }
  </c:if>


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
      <a href="/">home</a> >
      <a href="/">분실물</a> >
      <a href="/">분실물 검색</a> >
      <a href="/">분실물 상세보기</a>
    </h5>
  </div>

  <div class="detail-header">
    <h1>분실물 상세보기</h1>
    <div class="detail-header-inside">
      <h4>소중한 물품을 분실하셨습니다.
        <br>아래와 같은 물품을 습득하셨다면 관할기관 신고나 채팅으로 연락 부탁드립니다.</h4>
    </div>
  </div>

  <div class="info-section">
    <div class="image-container">
      <img src="/img/noimg.png" alt="이미지가 없습니다">
      <div class="no-image"></div>
    </div>

    <div class="info-content">
      <!-- 작성자 닉네임 표시 -->
      <div class="info">
        <span class="label">작성자 닉네임:</span>
        <c:out value="${item.nickname}" />
      </div>
      <div class="info">
        <span class="label">분실물명:</span>
        <c:out value="${item.lostTitle}"/>
      </div>
      <div class="info">
        <span class="label">분실일:</span>
        <c:out value="${item.lostDate}"/>
      </div>
      <div class="info">
        <span class="label">물품분류:</span>
        <c:out value="${item.itemName}"/>
      </div>
      <div class="info">
        <span class="label">물품색상:</span>
        <c:out value="${item.colorName}"/>
      </div>
      <div class="info">
    <span class="label">지역:</span>
    <c:out value="${item.sidoName}"/>
    <c:out value="${item.gugunName}"/>
    </div>
      <div class="info">
        <span class="label">사례금:</span>
        <c:out value="${item.reward}"/>
      </div>
    </div>
  </div>

  <!-- 상단 버튼 (예: 1:1문의, 처리현황, 지도보기) -->
  <div class="btn-container">
    <button>1대1 문의 보내기</button>
    <button>분실물 처리현황</button>
    <button>지도에 분실위치 보기</button>
  </div>

  <!-- 본문 컨텐츠 -->
  <div class="content-container">
    <div class="content">
      <c:out value="${item.lostContent}"/>
    </div>
    <div class="btn-container2">
      <button onclick="location.href='/lost'">목록</button>

      <!-- 작성자인지 비교 (loginEmail eq item.email) -->
      <c:choose>
        <c:when test="${loginEmail eq item.email}">
          <!-- 작성자인 경우 수정 버튼 -->
          <button onclick="location.href='/lost/update?lostIdx=${item.lostIdx}'">수정</button>
        </c:when>
        <c:otherwise>
          <!-- 작성자가 아니면 신고하기 버튼 -->
          <button type="button" onclick="openReportModal()">신고하기</button>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- 지도 섹션 -->
  <div class="map-section">
    <h2>분실장소</h2>
    <img src="/img/map-placeholder.jpg" alt="지도 첨부">
  </div>
</div>

<!-- 신고 모달 영역 -->
<div id="reportModalOverlay" class="modal-overlay">
  <div class="modal-content">
    <h3>신고 작성</h3>
    <form id="reportForm">
      <input type="hidden" name="reporterIdx" value="${loginMemIdx}" />
      <input type="hidden" name="resiverIdx" value="${item.lostIdx}" />

      <label for="rContent">신고 상세내용</label>
      <textarea id="rContent" name="rContent" required></textarea>

      <div class="modal-buttons">
        <button type="button" onclick="closeReportModal()">취소</button>
        <button type="submit">제출</button>
      </div>
    </form>
  </div>
</div>

<script>
  // 모달 열기
  function openReportModal() {
    document.getElementById("reportModalOverlay").style.display = "flex";
  }
  // 모달 닫기
  function closeReportModal() {
    document.getElementById("reportModalOverlay").style.display = "none";
  }

  // 신고 폼 submit
  const reportForm = document.getElementById("reportForm");
  reportForm.addEventListener("submit", function(e) {
    e.preventDefault();

    // 폼 데이터 직렬화
    const formData = new FormData(reportForm);

    // fetch POST
    fetch("/report/submit", {
      method: "POST",
      body: formData
    })
            .then(response => {
              if (!response.ok) {
                throw new Error("신고 접수 중 오류가 발생했습니다.");
              }
              return response.text(); // 단순 응답
            })
            .then(data => {
              alert("신고가 접수되었습니다.");
              closeReportModal();
              // 신고 후 필요하다면 페이지 새로고침/이동
              location.reload();
            })
            .catch(err => {
              alert(err.message);
            });
  });
</script>







</body>
</html>