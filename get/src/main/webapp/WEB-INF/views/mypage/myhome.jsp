<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소중한 내 정보 잇힝❤️</title>
</head>
<style>
    /* 전체 페이지 스타일 */
    body {
      font-family: Arial, sans-serif;
      background-color: #1e1e2f; /* 어두운 배경 */
      color: #fff;
      margin: 0;
      padding: 20px;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    /* 뱃지 섹션 스타일 */
    .badge-container {
      background-color: #2a2a3b; /* 섹션 배경 */
      border-radius: 10px; /* 모서리를 둥글게 */
      padding: 20px;
      max-width: 600px;
      text-align: center;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
    }

    /* 제목 스타일 */
    .badge-container h2 {
      margin-bottom: 20px;
      font-size: 24px;
      color: #ffdd57; /* 눈에 띄는 노란색 */
    }

    /* 뱃지 리스트 스타일 */
    .badge-list {
      display: flex;
      flex-wrap: wrap; /* 여러 줄로 자동 정렬 */
      justify-content: center;
      gap: 20px; /* 뱃지 간격 */
    }

    /* 뱃지 아이템 스타일 */
    .badge-item {
      width: 100px;
      height: 100px;
      background-color: #444; /* 뱃지 배경 */
      border-radius: 8px;
      display: flex;
      justify-content: center;
      align-items: center;
      overflow: hidden; /* 이미지가 영역을 벗어나지 않도록 */
      border: 2px solid #555; /* 뱃지 테두리 */
      transition: transform 0.3s, border-color 0.3s; /* 호버 효과 애니메이션 */
    }

    /* 뱃지 이미지 스타일 */
    .badge-item img {
      width: 90%; /* 이미지를 뱃지 안에 맞게 크기 조정 */
      height: auto;
    }

    /* 뱃지 호버 효과 */
    .badge-item:hover {
      transform: scale(1.1); /* 뱃지를 확대 */
      border-color: #ffdd57; /* 테두리 색상 변경 */
    }
  </style>
</head>
<body>
<main>
  <!-- 뱃지 섹션 -->
  <div class="badge-container">
    <h2>My Badge Collection</h2>
    <!-- 뱃지 리스트 -->
    <div class="badge-list">
      <!-- 뱃지 아이템 -->
      <div class="badge-item">
        <img src="badge1.png" alt="Badge 1">
      </div>
      <div class="badge-item">
        <img src="badge2.png" alt="Badge 2">
      </div>
      <div class="badge-item">
        <img src="badge3.png" alt="Badge 3">
      </div>
      <div class="badge-item">
        <img src="badge4.png" alt="Badge 4">
      </div>
      <div class="badge-item">
        <img src="badge5.png" alt="Badge 5">
      </div>
      <div class="badge-item">
        <img src="badge6.png" alt="Badge 6">
      </div>
    </div>
  </div>  
</main>
<script>

</script>
</body>
</html>