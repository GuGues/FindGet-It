<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>분실물 처리 절차</title>
  <link rel="stylesheet" href="/css/common.css" />
  <link rel="icon" type="image/png" href="/img/favicon.ico" />
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
      margin-left: 30%;
      margin-right: 100px;
      background: #fff;
      border: none;
      padding: 20px;
    }
    .detail-header {
      text-align: left;
      margin-bottom: 20px;
      border-bottom: solid #FF914B;
      /* position: relative; // 필요시 사용 */
    }
    .detail-header h1 {
      font-size: 28px;
      color: #333;
      /* 뒷줄에 뒤로가기 버튼 넣을 수도 있고, float:right 등을 고려해도 됨 */
      display: flex;
      justify-content: space-between; /* 제목 왼쪽, 버튼 오른쪽 배치 */
      align-items: center;           /* 수직 가운데 정렬 */
    }
    .back-button {
      background-color: #FF914B;
      color: white;
      border: none;
      padding: 8px 16px;
      font-size: 14px;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .back-button:hover {
      background-color: #E87A2E;
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
    .image-container {
      text-align: center;
      margin: 20px 0;
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
  </style>
</head>
<body>
  <!-- (선택) 관리자/회원 사이드바 분기 -->
  <c:choose>
    <c:when test="${sessionScope.grant eq 'ADMIN'}">
      <%@ include file="/WEB-INF/include/adminSide.jsp" %>
    </c:when>
    <c:otherwise>
      <%@ include file="/WEB-INF/include/side.jsp" %>
    </c:otherwise>
  </c:choose>

  <div class="detail-container">
    <div class="top-label">
      <h5>
        <a href="/">home</a> >
        <a href="/lost">분실물</a> >
        <a href="#">분실물 처리 절차</a>
      </h5>
    </div>

    <!-- 상단 제목 + 뒤로가기 버튼 -->
    <div class="detail-header">
      <h1>
        <span>분실물 처리 절차</span>
        <!-- 오른쪽 끝에 뒤로가기 버튼 -->
        <button class="back-button" onclick="history.back()">뒤로가기</button>
      </h1>
    </div>

    <!-- 주황색 가로 구분선 -->
    <hr style="border: none; border-top: 1px solid #FF914B; margin: 20px 0;" />

    <div class="image-container">
      <img src="/img/getprocess.png" alt="분실물 처리절차" style="max-width:100%; height:auto;" />
    </div>

    <hr style="border: none; border-top: 1px solid #FF914B; margin: 20px 0;" />

    <!-- 버튼 -->
    <div class="btn-container2">
      <!-- onclick 함수명 변경 -->
      <button type="button" onclick="togglePoliceProcess()">연계사이트 처리절차</button>
    </div>

    <!-- 경찰청 처리절차 이미지(초기 숨김) -->
    <div id="policeProcessDiv" style="display:none; text-align:center; margin-top: 20px;">
      <img src="/img/policeprocess.png" alt="경찰청 처리절차" style="max-width:100%; height:auto;" />
    </div>

  </div>

  <script>
    // [1] 연계사이트 처리절차 이미지 보이기/숨기기 Toggle
    function togglePoliceProcess() {
      const policeDiv = document.getElementById('policeProcessDiv');
      // 숨겨져 있으면 보이고, 보이는 상태면 숨기기
      if (policeDiv.style.display === 'none' || policeDiv.style.display === '') {
        // 보이도록
        policeDiv.style.display = 'block';
        // 이미지가 뜨면 해당 위치로 스크롤
        policeDiv.scrollIntoView({ behavior: 'smooth' });
      } else {
        // 다시 누르면 숨김
        policeDiv.style.display = 'none';
      }
    }
  </script>
</body>
</html>