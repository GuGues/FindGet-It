<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내 정보관리</title>
<style>
main {
    margin-top: 330px;
    margin-left: 35%;
    margin-right: auto;
    width: 50%;
    padding: 20px;
    background-color: #FFF5EB;
    border: 1px solid #FE8015;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    font-family: 'Arial', sans-serif;
}

.top {
    margin-bottom: 20px;
    font-size: 14px;
    color: #555555;
}

h2 {
    color: #333333;
    text-align: center;
    margin-bottom: 20px;
    font-weight: bold;
}

hr {
    border: 0;
    height: 1px;
    background-color: #FE8015;
    margin-bottom: 20px;
}

.form-label {
    font-size: 14px;
    font-weight: bold;
    color: #555555;
}

input[type="password"] {
    width: calc(100% - 20px);
    padding: 10px;
    margin-top: 10px;
    margin-bottom: 20px;
    border: 1px solid #FE8015;
    border-radius: 4px;
    font-size: 14px;
    box-sizing: border-box;
}

input[type="password"]:focus {
    outline: none;
    border-color: #FF5722;
    box-shadow: 0 0 5px rgba(255, 87, 34, 0.5);
}

button {
    display: inline-block;
    background-color: #FE8015;
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 14px;
    font-weight: bold;
    border-radius: 4px;
    transition: background-color 0.3s;
    text-align: center;
}

button:hover {
    background-color: #FF5722;
}

button:active {
    background-color: #E64A19;
}

button:disabled {
    background-color: #BDBDBD;
    cursor: not-allowed;
}

a {
    text-decoration: none;
    color: #FF5722;
    font-weight: bold;
}

a:hover {
    text-decoration: underline;
}

.alert {
    margin-top: 10px;
    padding: 10px;
    background-color: #FFCCBC;
    border: 1px solid #FF5722;
    color: #333333;
    border-radius: 4px;
    text-align: center;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/include/side.jsp"%>
	<main>
		<div>
			
			<h2>나의 정보수정</h2>
			<hr>
			<div>
				<input type="hidden" name="_csrf" value="${_csrf.token}" />
				<div>
					<label class="form-label" for="password">비밀번호 확인</label> 
					<input type="password" id="password" name="checkPw" class="form-control">
				</div>
				<div style="text-align: center; marigin-top: 20px;">
					<button type="button" id="checkPw">비밀번호 확인</button>
				</div>
			</div>
		</div>

		<script>
			document.addEventListener('DOMContentLoaded', function () {
		        const checkPwButton = document.getElementById('checkPw');
		        const passwordInput = document.getElementById('password');
		        const csrfToken = document.querySelector('input[name="_csrf"]').value;

		        if (!checkPwButton || !passwordInput) {
		            console.error("로딩되지 않았습니다.");
		            return;
		        }

		        checkPwButton.addEventListener('click', function () {
		            const pwcheck = passwordInput.value.trim();

		            if (!pwcheck) {
		                alert("비밀번호를 입력하세요.");
		                return;
		            }

		            const formData = new FormData();
		            formData.append("checkPw", pwcheck);
		            formData.append("_csrf", csrfToken);

		            // 비밀번호 확인 요청 (POST 방식으로 변경)
		            fetch('/Mypage/InfoUpdate/PwCheck', {
		                method: 'POST',
		                body: formData
		            })
		            .then(response => response.json())
		            .then(result => {
		                if (result) {
		                	alert("비밀번호 일치 수정페이지로 이동합니다.");
		                    window.location.href = "/Mypage/InfoUpdate/Update";
		                } else {
		                    alert("비밀번호가 틀렸습니다.");
		                }
		            })
		            .catch(error => {
		                console.error("오류 발생:", error);
		                alert("오류가 발생했습니다. 관리자에게 문의하세요.");
		            });
		        });
		    });
		</script>
	</main>
	<%@include file="/WEB-INF/include/fab.jsp"%>
</body>
</html>