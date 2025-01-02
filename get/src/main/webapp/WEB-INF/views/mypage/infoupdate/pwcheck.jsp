<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내 정보관리</title>
</head>
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
<body>
	<%@include file="/WEB-INF/include/side.jsp"%>
	<main>
		<div>
			<div>

				<div class="top">
					<a href="/">Home</a>><a href="#">Mypage</a>
				</div>
				<h2>나의 정보수정</h2>
				<hr>
				<div>
					<input type="hidden" name="_csrf" value="${_csrf.token}" />
					<div>
						<label class="form-label">비밀번호 확인</label> <input type="password"
							id="password" name="password" class="form-control">
					</div>
				</div>
				<div>
					<button id="checkPw">비밀번호 확인</button>
				</div>
			</div>
		</div>

		<script>
		document.addEventListener('DOMContentLoaded', function () {
		    document.getElementById('checkPw').addEventListener('click', function () {
		        const pwcheck = document.getElementById('password').value;
		        if (!pwcheck || pwcheck.trim() === "") {
		            alert("비밀번호를 입력하세요.");
		        } else {
		            const csrfToken = document.querySelector('input[name="_csrf"]').value;

		            fetch('/Mypage/InfoUpdate/PwCheck', {
		                method: 'GET',
		                headers: {
		                    'Content-Type': 'application/json',
		                    'X-CSRF-TOKEN': csrfToken
		                },
		                body: JSON.stringify({ checkPw: pwcheck })
		            })
		            .then(response => response.json())
		            .then(result => {
		                console.log(result);
		                if (result) {
		                    console.log("비밀번호 일치");
		                    window.location.href = "/Mypage/InfoUpdate/Update";
		                } else {
		                    console.log("비밀번호가 틀렸습니다.");
		                    alert("비밀번호가 틀렸습니다.");
		                    window.location.reload();
		                }
		            })
		            .catch(error => {
		                console.error(error);
		                alert("오류가 발생했습니다.");
		            });
		        }
		    });
		});
</script>
	</main>
	<%@include file="/WEB-INF/include/pagefab.jsp"%>
</body>
</html>