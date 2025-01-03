<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GUGUIN : 개인회원가입</title>
    <link rel="icon" type="image/png" href="/image/favicon.ico" />
    <link rel="stylesheet" href="/css/common.css" />
    <!-- Daum 우편번호 API 스크립트 추가 -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style>
        /* 기본 설정 */
        body {
            margin: 0; /* 기본 마진 제거 */
            padding: 0; /* 기본 패딩 제거 */
            font-family: 'Arial', sans-serif; /* 기본 폰트 설정 */
            margin-top: 50px;
        }
        /* big-div 비율 유지하면서 크기 줄이기 */
        .big-div {
            margin-top: 60px; /* 상단 여백 */
            background-color: #ffe3cc; /* 배경색 */
            padding: 40px; /* 내부 여백 */
            border-radius: 10px; /* 모서리 반지름 */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
            text-align: center; /* 텍스트 중앙 정렬 */
            width: 600px; /* 너비 설정 */
            z-index: 1; /* 배경보다 위에 오도록 설정 */
            margin: 0 auto; /* 화면에서 수평 중앙 정렬 */
            display: flex; /* Flexbox로 자식 요소 배치 */
            justify-content: center; /* 자식 요소를 수평 중앙 정렬 */
            position: relative; /* 자식의 절대 위치를 기준으로 함 */
            height: auto; /* 고정 높이를 제거하여 콘텐츠에 맞게 확장 */
            overflow: hidden; /* 넘치는 콘텐츠 숨김 */
            transform: scale(0.8); /* 비율 유지하면서 크기 줄이기 */
            transform-origin: top center; /* 크기 축소 중심 설정 */
        }

        /* form-box 그대로 비율 유지 */
        .form-box {
            margin-top: 20px; /* 상단 여백 추가로 아래로 이동 */
            width: 100%; /* 부모 요소에 맞게 너비 조정 */
            max-width: 500px; /* 최대 너비 설정 */
            height: auto; /* 높이를 콘텐츠에 맞게 설정 */
        }

        /* 입력 필드 컨테이너 */
        .form-floating {
            position: relative; /* 위치를 상대적으로 설정 */
            margin-bottom: 20px; /* 아래 여백 */
        }

        /* 입력 필드 스타일 */
        .form-floating input {
            width: 100%; /* 부모 요소에 맞게 너비 조정 */
            padding: 15px 10px 10px 10px; /* 내부 여백 */
            font-size: 16px; /* 글자 크기 */
            border: 1px solid #ccc; /* 테두리 색상 및 두께 */
            border-radius: 5px; /* 모서리 반지름 */
            box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
        }

        /* 라벨 스타일 */
        .form-floating label {
            position: absolute; /* 위치를 절대적으로 설정 */
            top: 15px; /* 상단 위치 */
            left: 10px; /* 좌측 위치 */
            font-size: 16px; /* 글자 크기 */
            color: #aaa; /* 글자 색상 */
            transition: all 0.2s ease; /* 모든 속성에 전환 효과 적용 */
            pointer-events: none; /* 포인터 이벤트 제거 */
        }

        /* 입력 상태 시 라벨 스타일 */
        .form-floating input:focus ~ label,
        .form-floating input:not(:placeholder-shown) ~ label {
            top: 5px; /* 상단 위치 이동 */
            font-size: 12px; /* 글자 크기 축소 */
            color: #333; /* 글자 색상 변경 */
        }

        /* 아이디 입력칸과 버튼을 나란히 배치하고 높이를 맞춤 */
        .input-group {
            display: flex; /* 플렉스 박스로 설정하여 가로 배치 */
            align-items: center; /* 수직 중앙 정렬 */
        }

        .input-group input {
            flex: 1; /* 남은 공간을 모두 차지 */
            height: 50px; /* 높이 설정 */
            border-radius: 5px; /* 모서리 반지름 */
            padding: 0 10px; /* 좌우 내부 여백 */
            font-size: 16px; /* 글자 크기 */
            box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
        }

        /* 생일 입력칸 스타일 */
        .input-group input[type="date"] {
            padding: 10px; /* 내부 여백 */
            font-size: 16px; /* 글자 크기 */
            border-radius: 5px; /* 모서리 반지름 */
            border: 1px solid #ccc; /* 테두리 */
            margin-bottom: 15px; /* 아래 여백 */
            color: #333; /* 글자 색상 */
            box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
        }

        /* 플레이스홀더 스타일 */
        .input-group input[type="date"]::placeholder {
            color: #aaa; /* 플레이스홀더 색상 */
        }

        /* 중복 확인 버튼 스타일 */
        .input-group button {
            height: 40px; /* 높이 설정 */
            padding: 0 15px; /* 좌우 내부 여백 */
            border: none; /* 테두리 제거 */
            background-color: #FFAE6B ; /* 배경색 */
            color: black; /* 글자 색상 */
            cursor: pointer; /* 커서 모양 변경 */
            border-radius: 5px; /* 모서리 반지름 */
            margin-left: 10px; /* 좌측 여백 */
            font-size: 16px; /* 글자 크기 */
            transition: background-color 0.3s ease; /* 배경색 전환 효과 */
            margin-top: -17px; /* 상단 마진으로 위치 조정 */
            box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
        }

        .input-group button:hover {
            background-color: #FE8015 ; /* 호버 시 배경색 */
            color: white; /* 호버 시 글자색 */
        }

        /* 제출 및 취소 버튼 스타일 */
        .submit-btn,
        .back {
            height: 40px; /* 높이 설정 */
            padding: 0 15px; /* 좌우 내부 여백 */
            border: none; /* 테두리 제거 */
            background-color: #FFAE6B; /* 배경색 */
            color: black; /* 글자 색상 */
            cursor: pointer; /* 커서 모양 변경 */
            border-radius: 5px; /* 모서리 반지름 */
            font-size: 16px; /* 글자 크기 */
            transition: background-color 0.3s ease, transform 0.2s ease; /* 배경색 및 크기 전환 효과 */
            margin: 5px; /* 외부 여백 */
            box-sizing: border-box; /* 박스 크기를 포함하도록 설정 */
        }

        .submit-btn:hover,
        .back:hover {
            background-color: #FE8015 ; /* 호버 시 배경색 */
            color: white; /* 호버 시 글자색 */
            transform: scale(1.02); /* 크기 증가 효과 */
        }

        /* 성별 선택 스타일 */
        .sex {
            text-align: left; /* 좌측 정렬 */
            margin-bottom: 5px; /* 아래 여백 */
        }

        /* 유효성 검사 메시지 색상 */
        .red {
            color: red; /* 빨간색 */
        }

        .green {
            color: green; /* 초록색 */
        }

        /* 제출 버튼과 취소 버튼 컨테이너 */
        .submitdiv {
            display: flex; /* 플렉스 박스로 설정 */
            justify-content: center; /* 수평 중앙 정렬 */
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
            height: 400px; /* 높이 설정 */
            border: none; /* 테두리 제거 */
            border-radius: 10px; /* 모서리 반지름 추가로 둥근 모서리 적용 */
        }
    </style>
</head>
<body>
<div class="big-div">
    <div class="form-box">
        <img src="/img/banner.png" alt="Logo" style="width: 200px; margin-bottom: 20px;">
        <form action="/sighup/reg" method="post" onsubmit="return handleSubmit();">
            <!-- 아이디 입력란과 중복 확인 버튼을 함께 배치 -->
            <div class="input-group">
                <div class="form-floating" style="flex: 1;">
                    <input type="text" id="userid" name="email" required placeholder=" ">
                    <label for="userid">이메일</label>
                </div>
                <button type="button" onclick="openIdCheckModal()">중복 확인</button>
            </div>

            <!-- 비밀번호 입력 -->
            <div class="form-floating">
                <input type="password" id="password" name="password" onchange="checkPw()" required placeholder=" ">
                <label for="password">비밀번호</label>
                <div></div>
            </div>

            <!-- 비밀번호 확인 -->
            <div class="form-floating">
                <input type="password" id="confirmPassword" required placeholder=" ">
                <label for="confirmPassword">비밀번호 확인</label>
            </div>

            <!-- 성명 입력 -->
            <div class="form-floating">
                <input type="text" id="username" name="username" required placeholder=" ">
                <label for="username">성명</label>
            </div>
            <div class="form-floating">
                <input type="text" id="nickname" name="nickname" required placeholder=" ">
                <label for="nickname">닉네임</label>
            </div>
            <!-- 성별 -->
            <div class="sex">
                <label for="gender1">
                    <input type="radio" id="gender1" name="gender" value="여">
                    여성
                </label>
                <label for="gender2">
                    <input type="radio" id="gender2" name="gender" value="남">
                    남성
                </label>
            </div>

            <!-- 생일 입력 -->
            <div class="input-group">
                <input type="date" id="birth" name="birth" required>
            </div>

            <!-- 휴대전화 입력 -->
            <div class="form-floating">
                <input type="text" id="uphone" name="phone" required placeholder=" ">
                <label for="uphone">휴대전화</label>
            </div>

            <!-- 우편번호 입력 -->
            <div class="form-floating">
                <input type="text" id="post_code" name="postnumber" required placeholder=" " onclick="execDaumPostcode()" readonly>
                <label for="post_code">우편번호</label>
            </div>

            <!-- 주소 입력 -->
            <div class="form-floating">
                <input type="text" id="uaddr" name="address1" required placeholder=" " onclick="execDaumPostcode()" readonly>
                <label for="uaddr">주소</label>
            </div>

            <!-- 상세주소 입력 -->
            <div class="form-floating">
                <input type="text" id="uaddr2" name="address2" required placeholder=" ">
                <label for="uaddr2">상세주소</label>
            </div>
            <!-- 제출 및 취소 버튼 -->
            <div class="submitdiv">
                <button type="submit" class="submit-btn">가입하기</button>
                <button type="button" class="back" onclick="location.href='${pageContext.request.contextPath}/Login/'">취소</button>
            </div>
        </form>
    </div>
</div>

<!-- 모달 구조 -->
<div id="modal" class="modal">
    <div class="modal-content">
        <span class="close-button" onclick="closeModal()">&times;</span>
        <iframe id="modal-iframe" src="" frameborder="0"></iframe>
    </div>
</div>

<script>
    // Daum 우편번호 서비스를 실행하는 함수
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 선택된 주소 정보를 활용
                var addr = ''; // 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 도로명 주소
                    addr = data.roadAddress;
                } else { // 지번 주소
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('post_code').value = data.zonecode;
                document.getElementById('uaddr').value = addr;

                // 상세주소 입력 필드로 커서를 이동한다.
                document.getElementById('uaddr2').focus();
            },
            theme: {
                // 원하는 테마 설정 가능
                searchBgColor: "#DEDB0A", // 검색창 배경색
                queryTextColor: "#030202" // 검색창 글자색
            },
            autoClose: true // 주소 선택 후 팝업 자동 닫힘 설정
        }).open();
    }

    // 모달을 여는 함수
    function openIdCheckModal() {
        var userid = document.getElementById('userid').value;
        if (!userid) {
            alert('아이디를 입력하세요.');
            return;
        }
        // 모달 표시
        var modal = document.getElementById('modal');
        var iframe = document.getElementById('modal-iframe');
        iframe.src = '/Join/checkUserId?userid=' + encodeURIComponent(userid);
        modal.style.display = 'block';
    }

    // 모달을 닫는 함수
    function closeModal() {
        var modal = document.getElementById('modal');
        var iframe = document.getElementById('modal-iframe');
        iframe.src = ''; // iframe 내용 제거
        modal.style.display = 'none';
    }

    // 모달 외부를 클릭하면 닫기
    window.onclick = function(event) {
        var modal = document.getElementById('modal');
        if (event.target == modal) {
            closeModal();
        }
    }

    // 비밀번호 정규식 확인
    function checkPw() {
        let passwd = document.querySelector('#password');
        const pattern = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W_]).{5,}$/;
        console.log(passwd.value);
        if (!pattern.test(passwd.value)) {
            let html = '<div class="red"> * 비밀번호는 영문・숫자・특수문자를 포함한 5자리 이상이어야 합니다.</div>';
            passwd.nextElementSibling.innerHTML = html;
        } else {
            let html = '<div class="green"> * 사용 가능한 비밀번호입니다.</div>';
            passwd.nextElementSibling.innerHTML = html;
        }
    }

    // 비밀번호 재확인 함수
    function validatePassword() {
        var password = document.getElementById('password').value;
        var confirmPassword = document.getElementById('confirmPassword').value;
        if (password !== confirmPassword) {
            alert('비밀번호가 일치하지 않습니다.');
            return false;
        }
        return true;
    }

    // 폼 제출 시 호출되는 함수
    function handleSubmit() {
        // 비밀번호 확인
        if (!validatePassword()) {
            return false; // 비밀번호가 일치하지 않으면 제출 중단
        }

        // 비밀번호가 일치하면 알림 표시 후 제출 진행
        alert("회원가입이 완료되었습니다.");
        return true; // 폼 제출 진행
    }
</script>

</body>
</html>