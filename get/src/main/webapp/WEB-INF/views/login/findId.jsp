<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GUGUIN : 개인아이디찾기</title>
    <link rel="icon" type="image/png" href="/img/favicon.png" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        main{
            display: grid;
            place-items: center;
            margin: 50px 0;
        }

        .clicked{
            background: #999999;
        }
        form table tr{
            height: 50px;
        }
/*        form table td{
            padding:0 10px;
        }*/

        form{
            width: 380px;
        }
        .btn{
            width: 110px;
            font-size: 13px;
        }
        .btn-light{
            width:380px;
            height: 60px;
            font-size: large;
            text-align: center;
            vertical-align: center;
        }
        #result-text{
            color: red;
        }
        .hidden{
            display: none;
        }

        .find-modal {
            justify-content: center;
            align-items: center;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 100;
            padding: 20px;
        }

        .find-modal-content {
            position: relative;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        .find-modal-detail{
            margin-bottom: 20px;
        }
        .find-modal-content>button{
            height: 30px;
            line-height: 30px;
            width: 30px;
            border: #E67E22 1px solid;
            border-radius: 5px;
            background-color: white;
        }
        .find-modal-content>button:hover{
            background-color: #E67E22;
            color: white;
        }
    </style>
</head>
<body>
<main>
<%--    <img src="/img/banner.png" alt="Logo" style="width: 70%; margin-top: -15%; ">--%>
    <h2>아이디 찾기</h2>
<form action="" method="post">
    <div class='form-floating'>
        <input type="text" class='form-control' name="username"  id='floatingName' placeholder="이름">
        <label for='floatingName'>이름</label>
    </div>
    <div class='form-floating'>
        <input type="text" class='form-control' name="phone"  id='floatingTel' placeholder="전화번호">
        <label for='floatingTel'>전화번호</label>
    </div>
    <div id="result-text"></div>
    <input type="submit" class="btn btn-light" value="확인"/>
</form>
    <div class="find-modal hidden">
        <div class="find-modal-content">
            <div class="find-modal-detail">
            </div>
            <button id="find-close-modal">닫기</button>
        </div>
    </div>
</main>
<script>
    document.getElementsByTagName('form')[1].onsubmit=()=>{
        if(document.getElementById('floatingName').value==null||document.getElementById('floatingName').value==''){
            alert("이름을 입력해주세요.");
            return false;
        }
        if(document.getElementById('floatingTel').value==null||document.getElementById('floatingTel').value==''){
            alert("전화번호를 입력해주세요.");
            return false;
        }
        fetch("/findId/check",{
            method:"POST",
            headers:{
                "Content-type":"application/json"
            },
            body:JSON.stringify({
                "username":document.getElementById('floatingName').value,
                "phone":document.getElementById('floatingTel').value
            })
        }).then(result=>result.json())
    .then(result=>{
        if(result.status=="OK"){
            document.getElementsByClassName("find-modal-detail")[0].innerHTML=result.result;
            document.getElementsByClassName("find-modal")[0].classList.remove("hidden");
        }
        else{
            document.getElementById("result-text").innerHTML = result.result;
        }
        })
    return false;
    }
    document.getElementById("find-close-modal").onclick=()=>{
            document.getElementsByClassName("find-modal")[0].classList.add("hidden");
            document.getElementById("modalCenter").classList.add("hidden");
            document.getElementById("modalCenter").classList.remove("show");
            document.body.click();
    }
</script>

</body>
</html>