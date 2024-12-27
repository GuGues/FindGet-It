<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Floating Action Button</title>
    <style>
        /* 전체 페이지 스타일 */
        body {
            margin: 0; /* 페이지의 여백을 0으로 설정 */
            padding: 0; /* 페이지의 패딩을 0으로 설정 */
            font-family: Arial, sans-serif; /* 글꼴 설정 */
        }

        /* FAB (Floating Action Button) 스타일 */
        .fab-container {
            position: fixed; /* 페이지의 고정 위치 */
            bottom: 20px; /* 화면 아래쪽에서 20px 위치 */
            right: 20px; /* 화면 오른쪽에서 20px 위치 */
        }

        .fab {
            width: 60px; /* 버튼의 너비 */
            height: 60px; /* 버튼의 높이 */
            background-color: #373737; /* 버튼의 배경색 (어두운 회색) */
            color: white; /* 버튼 텍스트 색 (흰색) */
            font-size: 30px; /* 텍스트 크기 */
            text-align: center; /* 텍스트 수평 정렬 */
            line-height: 60px; /* 텍스트 수직 정렬 (버튼 가운데 배치) */
            border-radius: 50%; /* 원 모양 버튼 만들기 */
            cursor: pointer; /* 마우스를 올리면 클릭 가능한 커서로 변경 */
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.3); /* 그림자 효과 */
            transition: transform 0.3s; /* 0.3초 동안 변환 효과 적용 */
        }

        /* FAB 버튼에 마우스를 올렸을 때 */
        .fab:hover {
            background-color: #FE8015; /* 배경색을 주황색으로 변경 */
            transform: scale(1.2); /* 버튼 크기를 1.2배 확대 */
        }

        /* FAB 옵션 버튼들을 담는 컨테이너 */
        .fab-options {
            display: none; /* 처음에는 옵션 메뉴 숨김 */
            position: absolute; /* 메뉴 위치를 절대값으로 설정 */
            bottom: 70px; /* FAB 버튼 위에 배치 (70px 아래쪽) */
            right: 0; /* FAB 버튼과 같은 오른쪽 정렬 */
        }

        /* 각 옵션 버튼 스타일 */
        .fab-option {
            width: 50px; /* 옵션 버튼 너비 */
            height: 50px; /* 옵션 버튼 높이 */
            background-color: #373737; /* 주황색 배경 */
            color: white; /* 텍스트 색은 검정 */
            text-align: center; /* 텍스트 수평 정렬 */
            line-height: 50px; /* 텍스트 수직 정렬 */
            border-radius: 50%; /* 원 모양 옵션 버튼 */
            margin-bottom: 10px; /* 버튼 간 간격 설정 */
            cursor: pointer; /* 클릭 가능한 커서 */
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.3); /* 그림자 효과 */
            transition: transform 0.2s; /* 변환 효과 시간 설정 */
        }

        /* 옵션 버튼에 마우스를 올렸을 때 */
        .fab-option:hover {
            background-color: #FE8015; /* 배경색을 주황색으로 변경 */
            transform: scale(1.1); /* 마우스를 올리면 1.1배 확대 */
        }

        /* 링크 기본 스타일 없애기 */
        a {
            text-decoration: none; /* 링크의 밑줄 제거 */
        }

        /* 모달 스타일 */
        .modal {
            display: none; /* 기본적으로 숨김 */
            position: fixed; /* 화면에 고정 */
            z-index: 1000; /* 다른 요소보다 위에 표시 */
            left: 0;
            top: 0;
            width: 100%; /* 전체 너비 */
            height: 100%; /* 전체 높이 */
            overflow: auto; /* 필요 시 스크롤 */
            background-color: rgba(0, 0, 0, 0.5); /* 배경 반투명 검정색 */
        }

        .modal-content {
            background-color: #fefefe; /* 모달 내용 배경색 */
            margin: 5% auto; /* 상하 5% 여백을 두고 가운데 정렬 */
            padding: 20px; /* 내부 여백 */
            border: 1px solid #888; /* 테두리 */
            width: 500px; /* 너비 설정 */
            max-width: 90%; /* 최대 너비 제한 */
            position: relative; /* 닫기 버튼 위치를 위해 필요 */
            border-radius: 10px; /* 모서리 반지름 추가로 둥근 모서리 적용 */
            box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
        }

        .close-button {
            color: #aaa; /* 글자 색상 */
            float: right; /* 우측 정렬 */
            font-size: 28px; /* 글자 크기 */
            font-weight: bold; /* 글자 두께 */
            cursor: pointer; /* 커서 모양 변경 */
        }

        .close-button:hover,
        .close-button:focus {
            color: black; /* 호버 및 포커스 시 글자 색상 */
            text-decoration: none; /* 밑줄 제거 */
            cursor: pointer; /* 커서 모양 변경 */
        }

        /* 모달 내 iframe 스타일 */
        #modal-iframe {
            width: 100%; /* 전체 너비 */
            height: 650px; /* 높이 설정 */
            border: none; /* 테두리 제거 */
            border-radius: 10px; /* 모서리 반지름 추가로 둥근 모서리 적용 */
        }
    </style>
</head>
<body>

<div class="fab-container">
    <div class="fab" id="main-fab">&middot;&middot;&middot;</div>
    <div class="fab-options" id="fab-options">
<sec:authorize access="isAnonymous()">
  <a class="fab-option" href="/login">
    <img src="/icon/login.png" alt="Login" style="width:30px; height:30px;">
  </a>
</sec:authorize>

<sec:authorize access="isAuthenticated()">
  <a class="fab-option" href="/logout">
    <img src="/icon/logout.png" alt="Logout" style="width:30px; height:30px;">
  </a>
</sec:authorize>

        <a class="fab-option" href="/mypage">
            <img src="/icon/info.png" alt="Mypage" style="width:30px; height:30px;">
        </a>

        <a class="fab-option" href="#" onclick="openIdCheckModal()">
            <img src="/icon/get_talk_black.png" alt="Chat" style="width:30px; height:30px;">
        </a>

        <a class="fab-option" href="#">
            TOP
        </a>
    </div>
</div>
<div id="modal" class="modal">
    <div class="modal-content">
        <span class="close-button" onclick="closeModal()">&times;</span>
        <iframe id="modal-iframe" src="" frameborder="0"></iframe>
    </div>
</div>
<script>
    // FAB 버튼을 클릭하면 확장/축소 메뉴를 토글하는 기능
    const mainFab = document.getElementById("main-fab"); // 메인 FAB 버튼
    const fabOptions = document.getElementById("fab-options"); // 옵션 메뉴

    // FAB 버튼에 마우스를 올리면 메뉴를 보이도록 설정
    mainFab.addEventListener("mouseover", () => {
        if (fabOptions.style.display === "flex") {  // 메뉴가 이미 열려있다면
            fabOptions.style.display = "none";     // 메뉴를 숨김
        } else {
            fabOptions.style.display = "flex";     // 메뉴를 보여줌
            fabOptions.style.flexDirection = "column"; // 메뉴 옵션을 세로로 배치
        }
    });

    function openIdCheckModal() {
        // 모달 표시
        var modal = document.getElementById('modal');
        var iframe = document.getElementById('modal-iframe');
        iframe.src = '/chatting/roomList';
        modal.style.display = 'block';
    }

    function closeModal() {
        var modal = document.getElementById('modal');
        var iframe = document.getElementById('modal-iframe');
        iframe.src = ''; // iframe 내용 제거
        modal.style.display = 'none';
    }
</script>

</body>
</html>
