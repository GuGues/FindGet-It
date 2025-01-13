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
	margin-left: 20%;
}

table td, table th {
	border: solid 1px #FE8015;
	text-align: center;
}

th {
	background-color: #FE8015;
}

tr:hover {
	background-color: #FFD5B2;
}

a {
	text-decoration: none;
	color: black;
}

a:hover {
	color: #000000;
}
</style>
</head>
<body>
	
	<main>
		<div>
			<div class="top">
				<a href="/">Home</a> &gt; <a href="#">Mypage</a>
			</div>
			<h2>나의 정보수정</h2>
			<hr>
			<div>
				<input type="hidden" name="_csrf" value="${_csrf.token}" />
				<div>
					<label class="form-label" for="password">비밀번호 확인</label> 
					<input type="password" id="password" name="checkPw" class="form-control">
				</div>
				<div>
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
		            console.error("필수 요소가 로드되지 않았습니다.");
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
		                console.error("요청 처리 중 오류 발생:", error);
		                alert("오류가 발생했습니다. 관리자에게 문의하세요.");
		            });
		        });
		    });
		</script>
	</main>
	<%@include file="/WEB-INF/include/pagefab.jsp"%>
</body>
</html>