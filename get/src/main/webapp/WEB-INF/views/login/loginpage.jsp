<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
    <link rel="icon" type="image/png" href="/img/favicon.ico" />
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>


    #headImage, #loginForm, #loginBox, #loginSideImage {
        text-align: center;
        margin: 0 auto;
    }

    #loginBox {
        margin: 10px auto;
        width: 36%;
        display: grid;
        grid-template-columns: 50% 50%;
        box-shadow: 3px 3px 3px 3px  rgba(0,0,0,0.3);
    }

    #headImage {
        margin: 0 auto;
    }

    #loginForm {
        width: 100%;
        border: 3px solid #FF914B;
        display: grid;
        grid-template-columns: 1fr 1fr;
    }

    #loginForm form {
        grid-column: 1 / 3;
    }

   #loginContent {
       text-align: center;
        margin:50px 30px;
        height: 50px;
        display: grid;
        grid-template-columns: 1fr 1fr;
    }
   #loginContent input{
       width: 200px;
       height: 40px;
       border: 1px solid #888888;
       border-radius:0;
   }

    #formTitle {
        grid-column: 1 / 3;
        background: #FF914B;
        width: 100%;
        color: white;
        height: 4vh;
    }
    #formTitle span{
        font-weight: bold;
        font-size: 20px;
    }

    #loginForm #submit {
        width: 5vw;
        height: 100%;
        background: #FF914B;
        border: none;
        color: white;
        font-weight: bold;

    }


    #loginForm .loginBtn {
        width: 100%;
        height: 2vw;
        background: #FF914B;
        border: none;
        color: white;
        font-weight: bold;
        margin: 80px auto 0;

    }

    #loginSideImage {
        width: 100%;
        border: 3px solid #FF914B;
    }
</style>
<body>
<div id="headImage">
    <img src="/img/loginHeader.png" alt="img">
</div>
<div id="loginBox">
    <div id="loginForm">
        <form action="/auth" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div id="formTitle"><span>아이디 로그인</span></div>
            <div id="loginContent">
                <div>
                <input type="text" name="username" placeholder="아이디"/>
                <input type="password" name="password" placeholder="비밀번호"/>
                </div>
                <button type="submit" id="submit">로그인</button>
                    <div id = "errorMessage" style="font-size: 13px; color: tomato">${errorMessage}</div>
            </div>
        </form>

        <button class="loginBtn modal-trigger" data-bs-toggle="modal"  data-modal-url="/findId" data-modal-title="아이디 찾기" id="find" >아이디 찾기</button>
        <button class="loginBtn modal-trigger" data-bs-toggle="modal"  data-modal-url="/findPw" data-modal-title="비밀번호 찾기" id="find" >비밀번호 찾기</button>
        <button class="loginBtn" id="signup" onclick="document.location.href='/sighup'">회원가입</button>
    </div>
    <div id="loginSideImage">
        <img src="/img/loginSideImage.png" alt="img">
    </div>
</div>

<!-- 모달 구조 -->
<div class="modal fade" id="modalCenter" tabindex="-1" aria-labelledby="modalCenterLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalCenterLabel">모달 제목</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeModal"></button>
            </div>
            <div class="modal-body">
                <!-- AJAX로 로드될 내용 -->
            </div>
        </div>
    </div>
</div>

</body>
<!-- jQuery 로드 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<!-- Bootstrap JS 로드 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).on("click", ".modal-trigger", function (e) {
          e.preventDefault();
          const modalUrl = $(this).data("modal-url");
          const modalTitle = $(this).data("modal-title");
          const modal = new bootstrap.Modal(document.getElementById('modalCenter'));
          $.get(modalUrl, function (data) {
              $("#modalCenter .modal-body").html(data);
              $("#modalCenterLabel").text(modalTitle);
              modal.show();
          });
      });

</script>
</html>