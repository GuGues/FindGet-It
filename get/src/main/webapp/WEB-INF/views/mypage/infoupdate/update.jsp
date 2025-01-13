<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>내 정보수정</title>
    <link rel="icon" type="image/png" href="/image/favicon.ico" />
    <link rel="stylesheet" href="/css/common.css" />
    <style>
        
    </style>
</head>
<body>
<div class="big-div">
    <div class="form-box">
        
        <form action="/Mypage/InfoUpdate/Save" method="post" onsubmit="return handleSubmit();">
            
            <div class="input-group">
                <div class="form-floating" style="flex: 1;">
                    <input type="text" id="email" name="email" value="${user.email}" readonly required placeholder=" ">
                    <label for="email">이메일</label>
                </div>
            </div>

            
            <div class="form-floating">
                <input type="password" id="password" name="password" required placeholder=" ">
                <label for="password">새 비밀번호</label>
            </div>

            
            <div class="form-floating">
                <input type="password" id="confirmPassword" name="confirmPassword" required placeholder=" ">
                <label for="confirmPassword">새 비밀번호 확인</label>
            </div>

            
            <div class="form-floating">
                <input type="text" id="name" name="name" value="${user.username}" readonly required placeholder=" ">
                <label for="name">이름</label>
            </div>

            
            <div class="form-floating">
                <input type="text" id="phone" name="phone" value="${user.phone}" required placeholder=" ">
                <label for="phone">전화번호</label>
            </div>


            
            <div class="submitdiv">
                <button type="submit" class="submit-btn">수정하기</button>
                <a href="/Mypage" class="back">돌아가기</a>
            </div>
        </form>
    </div>
</div>
<script>
    function handleSubmit() {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        
        if (password && password !== confirmPassword) {
            alert('비밀번호가 일치하지 않습니다.');
            return false;
        }
        return true;
    }
</script>
</body>
</html>