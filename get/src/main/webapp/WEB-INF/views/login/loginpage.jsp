<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
  body{ height: 80vh; }
  #headImage{
  text-align: center;
    margin-top: 40px;
  }
    #loginForm, #loginBox, #loginSideImage {
        text-align: center;
        margin: 0 auto;
    }

    #loginBox {
        margin: 5% auto;
        width: 50%;
        height: 50%;
        display: flex;
        box-shadow: 3px 3px 3px 3px  rgba(0,0,0,0.3);
        border: 3px solid #FF914B;
    }

    .loginBtns {
        display: flex;
        height: 70px;
        width: 100%;
        margin-top: auto;
        justify-content: center;
        align-items: flex-end;
    }
    .loginBtn{
      display:flex;
      align-items: center;
      margin: 10px;
      height: 50px;
      padding: 10px 20px;;
      background: #FF914B;
      border: none;
      border-radius: 5px;
      color: white;
    }
    .loginBtn:hover{
      background-color: #FE8015;
    }

   #loginContent {
       text-align: center;
        width: 80%;
        margin:50px auto;
        height: 100%;
        max-height: 100px;
        display: flex;
    }
   #loginContent input{
       border: 1px solid #888888;
       border-radius:0;
       width: 100%;
   }

    #formTitle {
        background: #FF914B;
        width: 100%;
        color: white;
        padding-top: 20px;
        padding-bottom: 20px;
    }
    #formTitle span{
        font-weight: bold;
        font-size: 20px;
    }
     #submit {
        width: 100px;
        height: 100%;
        background: #FF914B;
        border: none;
        color: white;
        font-weight: bold;
        margin-left: auto;
    }
     #submit:hover {
        background: #FE8015;
    }

    #loginForm {
    box-sizing: border-box;
        width: 100%;
        height: 100%;
        border: none;
        color: white;
        font-weight: bold;
    }

    #loginSideImage {
        width: 100%;
        border-left: 3px solid #FF914B;
        display: flex;
    }
    #loginSideImage>a {
    display: flex;
    width: 100%;
    }
    #loginSideImage>a img{
      box-sizing: border-box;
      width: 80%;
      aspect-ratio: 15 / 15;
      margin: auto;
    }
    #loginForm form{
    width: 100%;
    height: 100%;
    }
    .formContent{
      display: flex;
      flex-direction: column;
      align-content: center;
      height: 80%;
    }
    .inputLine{
      height: 100%;
    }
    .inputLine input{
      height: 50%;
    }
    footer img{
      aspect-ratio: 16 / 10;
      height: 50px;
    }
    footer{
      display: flex;
      justify-content: center;
      align-items: flex-end;
      margin-top: auto;
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
            <div class="formContent">
            <div id="loginContent">
                <div class="inputLine">
                <input type="text" name="username" placeholder="아이디"/>
                <input type="password" name="password" placeholder="비밀번호"/>
                </div>
                <button type="submit" id="submit">로그인</button>
            </div>
            <div class="loginBtns">
              <div class="loginBtn modal-trigger" data-bs-toggle="modal"  data-modal-url="/findId" data-modal-title="아이디 찾기" id="find" >아이디 찾기</div>
              <div class="loginBtn modal-trigger" data-bs-toggle="modal"  data-modal-url="/findPw" data-modal-title="비밀번호 찾기" id="find" >비밀번호 찾기</div>
              <div class="loginBtn" id="signup" onclick="document.location.href='/sighup'">회원가입</div>
            </div>
            </div>
        </form>
<<<<<<< HEAD
=======

        <button class="loginBtn modal-trigger" data-bs-toggle="modal"  data-modal-url="/findId" data-modal-title="아이디 찾기" id="find" >아이디 찾기</button>
        <button class="loginBtn modal-trigger" data-bs-toggle="modal"  data-modal-url="/findPw" data-modal-title="비밀번호 찾기" id="find" >비밀번호 찾기</button>
        <button class="loginBtn" id="signup" onclick="document.location.href='/sighup'">회원가입</button>
>>>>>>> d4032ee16fce93ac50b05fcc4db0c5b9fe7ac6bd
    </div>
    <div id="loginSideImage">
      <a href="/">
        <img src="/img/loginSideImage.png" alt="img">
      </a>
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
<<<<<<< HEAD
<footer>
  <img alt="" src="/logo/logoopen.png">
  &nbsp;
  <span>&copy;guguin</span>
</footer>
=======

>>>>>>> d4032ee16fce93ac50b05fcc4db0c5b9fe7ac6bd
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