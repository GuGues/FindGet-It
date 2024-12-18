<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>홈 화면</title>
  <style>
    .home-background {
      background: url('/img/homebackground.jpg') no-repeat center center;
      background-size: cover;
      height: 100vh;
      position: relative;
      overflow: hidden;
    }
    .home-background::after {
      content: "";
      position: absolute; top: 0; left: 0; width: 100%; height: 100%;
      background: rgba(0,0,0,0.3);
      pointer-events: none;
    }

    .top-container {
      position: absolute; top: 10%; left: 50%;
      transform: translateX(-50%);
      display: flex; flex-direction: column; align-items: center; gap: 20px;
      z-index: 1;
    }

    .logo-banner {
      width: 268px; height: 162px; transition: all 0.3s ease;
    }
    .logo-banner.hover { display: none; }
    .top-container:hover .logo-banner.default { display: none; }
    .top-container:hover .logo-banner.hover { display: block; }

    .search-container {
      position: relative; display: flex; align-items: center;
      background: rgba(255, 255, 255, 0.5); border-radius: 5px;
      padding: 10px; width: 1000px; height: 70px; border: 3px solid transparent;
      transition: all 0.3s ease;
    }
    .search-container:hover, .search-container:focus-within {
      background: rgba(255, 255, 255, 1); border-color: #FF914B;
    }
    .search-icon {
      width: 60px; height: 60px; margin-right: 10px;
    }
    .search-icon.hover { display: none; }
    .search-container:hover .search-icon.default,
    .search-container:focus-within .search-icon.default { display: none; }
    .search-container:hover .search-icon.hover,
    .search-container:focus-within .search-icon.hover { display: block; }

    .search-input {
      border: none; outline: none; background: transparent; flex-grow: 1; font-size: 30px;
    }

    .button-container {
      position: absolute; bottom: 30%; display: flex; justify-content: center;
      width: 100%; gap: 20px; z-index: 1;
    }

    .button {
      position: relative; width: 154px; height: 146px; display: flex; align-items: center; justify-content: center;
      background: rgba(255, 255, 255, 0.5); border-radius: 10px; border: 3px solid transparent;
      transition: all 0.3s ease; cursor: pointer;
    }
    .button:hover {
      background: rgba(255, 255, 255, 1); border-color: #FF914B;
    }

    .icon {
      width: 100px; height: 100px; transition: all 0.3s ease;
    }

    .icon.hover { display: none; }
    .button:hover .icon.default { display: none; }
    .button:hover .icon.hover { display: block; }

    .button p {
      position: absolute; bottom: -50px; width: 100%; text-align: center;
      font-size: 14px; font-weight: bold; color: black; transition: color 0.3s;
    }

    .button:hover p { color: #FF914B; }

    /* 모달 스타일 */
    .modal-background {
      position: fixed; z-index: 9999; left: 0; top:0;
      width: 100%; height: 100%; background: rgba(0,0,0,0.5);
    }

    .modal-content {
      background: #fff; margin: 100px auto; padding: 20px; width: 500px;
      border-radius: 8px; position: relative;
    }

    .close-btn {
      position: absolute; top:10px; right:10px; cursor: pointer; font-size:18px; font-weight:bold;
    }

  </style>
</head>
<body>
<div class="home-background">

  <div class="top-container">
    <img src="/logo/logoopen.png" class="logo-banner default" alt="로고 배너">
    <img src="/logo/logoclose.png" class="logo-banner hover" alt="로고 배너">

    <!-- 검색 폼 -->
    <form class="search-container" action="/search" method="get">
      <img src="/icon/dodbogi.png" class="search-icon default" alt="돋보기 아이콘">
      <img src="/icon/dodbogi_orange.png" class="search-icon hover" alt="돋보기 아이콘">
      <input type="text" name="keyword" placeholder="분실물을 검색하세요" class="search-input" required>
    </form>
  </div>

  <div class="button-container">
    <div class="button">
      <img src="/icon/lost_gray.png" class="icon default" alt="분실물 게시판">
      <img src="/icon/lost_orange.png" class="icon hover" alt="분실물 게시판">
      <p>분실물 게시판</p>
    </div>

    <div class="button">
      <img src="/icon/find_gray.png" class="icon default" alt="습득물 게시판">
      <img src="/icon/find_orange.png" class="icon hover" alt="습득물 게시판">
      <p>습득물 게시판</p>
    </div>

    <div class="button">
      <img src="/icon/faq_gray.png" class="icon default" alt="FAQ">
      <img src="/icon/faq_orange.png" class="icon hover" alt="FAQ">
      <p>FAQ</p>
    </div>

    <!-- 임시채팅버튼: 클릭 시 채팅방 목록 모달 표시 -->
    <a class="button" href="chat/rooms">
      <img src="/icon/speaker_gray.png" class="icon default" alt="공지사항">
      <img src="/icon/speaker_orange.png" class="icon hover" alt="공지사항">
      <p>채팅방 목록</p>
    </a>

    <a class="button" href="https://www.lost112.go.kr/">
      <img src="/icon/lost112_gray.png" class="icon default" alt="경찰청 신고">
      <img src="/icon/lost112_orange.png" class="icon hover" alt="경찰청 신고">
      <p>경찰청 분실물 신고</p>
    </a>
  </div>
</div>

</body>
</html>