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
body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
<<<<<<< HEAD
    background-color: #FFF5EB;
=======
    background-color: #FFF;
>>>>>>> d4032ee16fce93ac50b05fcc4db0c5b9fe7ac6bd
}

main {
    margin-left: 20%;
}

.big-div {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    padding: 20px;
}

.form-box {
    background-color: white;
    border: 1px solid #FE8015;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 500px;
    padding: 30px;
}

h1 {
    text-align: center;
    color: #333333;
    margin-bottom: 20px;
}

.form-floating {
    position: relative;
    margin-bottom: 20px;
}

input[type="text"], input[type="password"] {
    width: 100%;
    padding: 10px;
    font-size: 14px;
    border: 1px solid #FE8015;
    border-radius: 5px;
    outline: none;
    background-color: #FFFDF9;
    box-sizing: border-box;
}

input[type="text"]:focus, input[type="password"]:focus {
    border-color: #FF5722;
    box-shadow: 0 0 5px rgba(255, 87, 34, 0.5);
}

label {
    position: absolute;
    top: 50%;
    left: 10px;
    transform: translateY(-50%);
    font-size: 14px;
    color: #999999;
    transition: all 0.2s ease-in-out;
    pointer-events: none;
}

input:focus + label, input:not(:placeholder-shown) + label {
    top: -10px;
    font-size: 12px;
    color: #FF5722;
    background-color: white;
    padding: 0 5px;
}

.submitdiv {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 20px;
}

button.submit-btn {
    background-color: #FE8015;
    color: white;
    font-weight: bold;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

button.submit-btn:hover {
    background-color: #FF5722;
}

a.back {
    text-decoration: none;
    font-size: 14px;
    color: #FF5722;
    font-weight: bold;
    transition: color 0.3s;
}

a.back:hover {
    color: #E64A19;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/include/side.jsp"%>
<main>
<div class="big-div">
    <div class="form-box">
        <!-- form 수정 -->
        <form action="/Mypage/InfoUpdate/UpdateUser" method="post" onsubmit="return handleSubmit();">
            
            <div class="input-group">
                <div class="form-floating" style="flex: 1;">
                    <input type="text" id="email" name="email" value="${user.email}" readonly required placeholder=" ">
                    <label for="email">이메일</label>
                </div>
            </div>
            
            <!-- 닉네임 -->
            <div class="form-floating" style="flex: 1;">
                <input type="text" id="nickname" name="nickname" value="${user.nickname}" required placeholder=" ">
                <label for="nickname">닉네임</label>
            </div>

            <!-- 비밀번호 -->
            <div class="form-floating">
                <input type="password" id="password" name="password" placeholder=" ">
                <label for="password">새 비밀번호</label>
            </div>

            <!-- 비밀번호 확인 -->
            <div class="form-floating">
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder=" ">
                <label for="confirmPassword">새 비밀번호 확인</label>
            </div>

            <!-- 이름 -->
            <div class="form-floating">
                <input type="text" id="username" name="username" value="${user.username}" readonly required placeholder=" ">
                <label for="username">이름</label>
            </div>

            <!-- 생년월일 -->
            <div class="form-floating" style="flex: 1;">
                <input type="text" id="birth" name="birth" value="${user.birth}" readonly required placeholder=" ">
                <label for="birth">생년월일</label>
            </div>
            
            <!-- 전화번호 -->
            <div class="form-floating">
                <input type="text" id="phone" name="phone" value="${user.phone}" required placeholder=" ">
                <label for="phone">전화번호</label>
            </div>

            <!-- 주소 -->
            <div class="form-floating" style="flex: 1;">
                <input type="text" id="address1" name="address1" value="${user.address1}" required placeholder=" ">
                <label for="address1">주소</label>
            </div>
                
            <div class="form-floating" style="flex: 1;">
                <input type="text" id="address2" name="address2" value="${user.address2}" required placeholder=" ">
                <label for="address2">상세주소</label>
            </div>
                
            <div class="form-floating" style="flex: 1;">
                <input type="text" id="postnumber" name="postnumber" value="${user.postnumber}" required placeholder=" ">
                <label for="postnumber">우편번호</label>
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
        
        // 비밀번호 확인 처리
        if (password && password !== confirmPassword) {
            alert('비밀번호가 일치하지 않습니다.');
            return false;
        }
        
        
        if (!password) {
            document.getElementById('password').value = "";  
            document.getElementById('confirmPassword').value = "";
        }
        
        return true;
    }
    
    
    document.addEventListener("DOMContentLoaded", function() {
        const form = document.querySelector("form");
        
        form.addEventListener("submit", function(event) {
            event.preventDefault(); 
            
            const formData = new FormData(form);
            const jsonData = {};
            formData.forEach((value, key) => jsonData[key] = value);
            
            fetch("/Mypage/InfoUpdate/UpdateUser", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(jsonData)
            })
            .then(response => response.json())
            .then(response => {
                if (response.status === "success") {
                    alert("업데이트 완료");
                    window.location.href = "/Mypage"; 
                } else {
                    alert(response.message || "업데이트 실패");
                }
            })
            .catch(error => {
                alert("서버 오류가 발생하였습니다.");
            });
        });
    });
</script>

</main>
</body>
</html>