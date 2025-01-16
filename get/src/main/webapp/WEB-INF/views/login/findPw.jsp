<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GUGUIN : 개인비밀번호찾기</title>
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
            width: 100px;
            border: #E67E22 1px solid;
            border-radius: 5px;
            background-color: white;
        }
        .keyText{
          color: green;
          margin: 10px;
        }
        #result-text{
          display: flex;
          flex-direction: column;
          justify-content: center;
        }
        .keyBtn{
          display: flex;
          justify-content: center;
          align-items: center;
        }
        .find-modal-content .btn{
           display: flex;
          justify-content: center;
          align-items: center;
            width: 100%;;
            height: 60px;
            font-size: large;
            text-align: center;
            vertical-align: center;
            margin-top: 10px;
        }
        input:not(.inputLine input){
          margin-top: 20px;
        }
        .message{
          color: red;
        }
    </style>
</head>
<body>
<main class="findIdModal">
<%--    <img src="/img/banner.png" alt="Logo" style="width: 70%; margin-top: -15%; ">--%>
    <h2>비밀번호 찾기</h2>
<form action="" method="post">
    <div class='form-floating'>
        <input type="text" class='form-control' name="email"  id='floatingId' placeholder="아이디">
        <label for='floatingId'>아이디</label>
    </div>
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
            <div class="message"></div>
            <div class="btn btn-light changePwBtn">변경</div>
            <div class="btn btn-light find-close-modal">닫기</div>
        </div>
    </div>
</main>
<script>
    document.getElementsByTagName('form')[1].onsubmit=()=>{
        if(document.getElementById('floatingId').value==null||document.getElementById('floatingId').value==''){
            alert("아이디을 입력해주세요.");
            return false;
        }
        if(document.getElementById('floatingName').value==null||document.getElementById('floatingName').value==''){
            alert("이름을 입력해주세요.");
            return false;
        }
        if(document.getElementById('floatingTel').value==null||document.getElementById('floatingTel').value==''){
            alert("전화번호를 입력해주세요.");
            return false;
        }
        fetch("/findPw/check",{
            method:"POST",
            headers:{
                "Content-type":"application/json"
            },
            body:JSON.stringify({
                "email":document.getElementById('floatingId').value,
                "username":document.getElementById('floatingName').value,
                "phone":document.getElementById('floatingTel').value
            })
        }).then(result=>result.json())
    .then(result=>{
        if(result.status=="OK"){
        	//console.log(result.result);
        	fetch("/email/check", {
        		method: "POST",
        		headers:{
        			"Content-type":"application/json"
        		},
        		body:JSON.stringify({
        			"email":email,
        		})
        	}).then(result=>result.json())
        	.then(result=>{
        		console.log(result);
        		if(result.status=="OK"){
        			//이메일 인증번호 발송 성공했을경우
        			key = result.key;
        			document.getElementById("result-text").innerHTML = 
        			    "<div class='form-floating' style='margin: 20px 0;'>" +
        			    "<input type='text' class='form-control keyInput' name='key' id='floatingTel' placeholder='인증번호'>" +
        			    "<label for='floatingTel'>인증번호</label>" +
        			    "</div>" +
        			    "<div class='btn btn-light keyBtn' style='margin-top: 10px;' onclick='yourFunction()'>인증번호 확인</div>";
        		}
        		else{
                    //이메일 인증번호 발송 실패했을경우
        			document.getElementById("result-text").innerHTML = result.result;
                }

        	    const keyBtn = document.querySelector('.keyBtn')
        	    if(keyBtn!=null){
        	    	keyBtn.onclick= function() {
        	    		const keyInput = document.querySelector('.keyInput').value;
        	    		if(keyInput == key){
        	    			//console.log("hi")
        	    			document.getElementsByClassName('find-modal')[0].classList.remove("hidden");
        	    			//변경할 비번 창 닫기 버튼
        	    			document.getElementsByClassName('find-close-modal')[0].onclick=function(){
                	            document.getElementsByClassName("find-modal")[0].classList.add("hidden");
                	            document.querySelector('.btn-close').click();
                	        }
        	    			//비밀번호 변경 버튼
        	    			document.querySelector('.changePwBtn').onclick=()=>{
        	    				let newPw = document.querySelector('#newPw');
        	    				let newPwCheck = document.querySelector('#newPwCheck');
        	    				if(newPw.value == "" || newPw.value == null){
        	    					document.querySelector('.message').innerHTML = "* 비밀번호를 입력해주세요"
        	    					newPw.focus();
        	    				}
        	    				else if(newPw.value != newPwCheck.value){
        	    					document.querySelector('.message').innerHTML = "* 비밀번호가 일치하지 않습니다"
        	    					newPwCheck.focus();
        	    				}
        	    				else{
        	    					document.querySelector('#changePwEmail').value = email;
        	    					document.querySelector('.changePw').submit();
        	    				}
        	    			}
        	    		}
            	    }
        	    }
        	})
        }
        else{
            document.getElementById("result-text").innerHTML = result.result;
        }
        })
    return false;
    }
    document.getElementById("find-close-modal").onclick=()=>{
           document.getElementsByClassName("find-modal")[0].classList.add("hidden");
           document.querySelector('.btn-close').click();
    }
</script>

</body>
</html>