<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찾GET어 : 회원관리</title>
<link rel="icon" type="image/png" href="/img/favicon.ico" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<style>
  main{
    margin-left: 20%;
    padding: 20px 40px;
  }
  .titleBox{
     min-height: 60px;
     max-height: 60px;
     padding: 10px;
     margin-bottom: 30px;
     margin-top: 20px;
   }
   .right{ width: 100%; padding: 0 20px; text-align:right; margin: 0;}
   a{ color: black; cursor: pointer; text-decoration: none;}
   .pagingDiv{
     display: flex;
     justify-content: center;
   }
   .btn{ background-color: #B39977; color: white;}
   .btn:hover{ background-color: #8C6C55;}
   .modal{
    display:none;
    
    justify-content: center;
    top:0;
    left:0;

    width:100%;
    height:100%;

    background-color: rgba(0,0,0,0.3);
    z-index: 3; 
   }
   .modal_content{
      position:absolute;

      top: 50%;
      left: 50%;
      width:700px;
      height:800px;
      transform: translate(-50%, -50%);

      padding:40px;

      text-align: center;

      background-color: rgb(255,255,255);
      border-radius:10px;
      box-shadow:0 2px 3px 0 rgba(34,36,38,0.15);
      
   }
   .content{ height: 60%; margin-top: 40px;}
   .member_detail {
     height: 30%;
     padding: 15px 50px;
     text-align: left;
   }
   .banBtn:hover { background-color: red; color: white; }
   .memberThead{ margin-bottom: 20px;}
   .memberTable, .memberThead{
     display: table;
	 text-align: center;
	 width: 100%;
   }
   .memberTable{
     border: solid 2px #8C6C55;
	 border-radius: 10px;
	 border-collapse: separate;
	 border-spacing: 0;
   }
   .memberTr td:not(tr:last-of-type td){
    border-bottom: solid 1px #DFD4D4;
   }
   .memberTr td{ padding: 10px 0; }
   .memberTr:hover{ background-color: #D3C4B1; }
   .memberTr td:not(td:nth-child(1)) {
     border-left: solid 1.5px #8C6C55;
   }
   .reprotList{ height: 60%; }
   .report{ height: 20px; padding: 10px; }
   .report .chatting{
     box-sizing: border-box;
     overflow: scroll;
   }
   
   #viewChatting{
	position:absolute;
	margin:10px;
	padding:20px;
	left:10%;
	top:10%;   
	background-color:#D3C4B1;
	width:80%;
	height:80%;
	border-radius:10px;
   }
   button{
     background-color: #D3C4B1;
     border: 1px solid #8C6C55;
     border-radius: 5px;
     padding: 5px;
   }
   button:hover{
     background-color: #8C6C55;
     color: white;
   }
	#chatting_content{
	width:90%;
	height:80%;
	}
   .hidden{
   display:none;
   }
  .reports {
    table-layout: fixed; /* 테이블 열 너비 고정 */
    width: 100%; /* 전체 테이블 너비를 100%로 설정 */
  }

  .reports tr td:nth-of-type(1) { width: 10%; }
  .reports tr td:nth-of-type(2) { width: 50%; }
  .reports tr td:nth-of-type(3) { width: 20%; }
  .reports tr td:nth-of-type(4) { width: 20%; }
  .chatLog{ 
    background-color: white;
    border: 2px solid #8C6C55;
    border-radius: 5px;
    padding: 3px;
    margin-left: 20px;
  }
  #chatting_content{
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    overflow-y: scroll;
  }
  ::-webkit-scrollbar {
  display: none; /* Webkit */
}
</style>
</head>
<body>
<%@include file="/WEB-INF/include/adminSide.jsp" %>
  <main>
    <div class="titleBox">
      <div class="right" style="font-size: 13px;">
        <a href="/">HOME</a>&nbsp;&gt;&nbsp;<a href="/admin">회원관리</a>&nbsp;&gt;&nbsp;<a href="/admin/user">신고회원목록</a>
      </div>
      <h3 class="title">회원관리</h3>
    </div>
    <hr style="color: #8C6C55; border-width: 3px;">
    <div><h4 style="padding-left: 20px; margin-bottom: 20px;">회원 목록</h4></div>
    <table class="memberThead">
      <colgroup>
        <col style="width: 5%;">
        <col style="width: 50%;">
        <col style="width: 15%;">
        <col style="width: 15%;">
        <col style="width: 15%;">
      </colgroup>
      <tr>
        <td>순번</td>
        <td>아이디</td>
        <td>이름</td>
        <td>신고횟수</td>
        <td>가입일</td>
      </tr>
    </table>
    <table class="memberTable">
      <colgroup>
        <col style="width: 5%;">
        <col style="width: 50%;">
        <col style="width: 15%;">
        <col style="width: 15%;">
        <col style="width: 15%;">
      </colgroup>
      <c:forEach items="${ members }" var="member" varStatus="i">
        <tr class="memberTr ${ member.mem_idx }" id="${ member.email }">
          <td>${ (pagingHelper.nowPage - 1 )* 15 + i.index + 1 }</td>
          <td>${ member.email }</td>
          <td>${ member.username }</td>
          <td>${ member.receiver_email_cnt }</td>
          <td>${ member.com_date }</td>
        </tr>
      </c:forEach>
    </table>
    <div class="pagingDiv">
      <%@include file="/WEB-INF/include/paging.jsp" %>
    </div>
  </main>
<div class="modal">
    <div class="modal_content">
      <h3>회원정보 조회</h3>
      <div class="member_detail">
        <form class="form" method="POST">
          <input type="hidden" class="mem_idx" name="mem_idx">
        </form>
        이메일 : <span class="email"></span><br>
        이름 : <span class="username"></span><br>
        닉네임 : <span class="nickname"></span><br>
        핸드폰 번호 : <span class="phone"></span><br>
        생일 : <span class="birth"></span><br>
        주소 : <span class="address"></span><br>
        가입일 : <span class="com_date"></span><br>
        회원권한 : <span class="user_grant"></span><br>
      </div>
      <div class="reprotList">
        <h5>신고목록</h5>
        <table style="width: 100%;">
            <colgroup>
              <col style="width: 10%;">
              <col style="width: 50%;">
              <col style="width: 20%;">
              <col style="width: 20%;">
            </colgroup>
            <tr>
              <td>순번</td>
              <td>신고자</td>
              <td>신고일자</td>
              <td></td>
            </tr>
          </table>
          <table class="reports">
            <colgroup>
              <col style="width: 10%;">
              <col style="width: 50%;">
              <col style="width: 20%;">
              <col style="width: 20%;">
            </colgroup>
          </table>
          <div id="viewChatting" class="hidden">
            <div style="margin-bottom: 30px;"><h2>신고 채팅 로그</h2></div>
            <div id="chatting_content"></div>
	        <span class="chattingCloseBtn btn" onclick="closeChatting()">닫기</span>
          </div>
      </div>
      <span class="banBtn btn">회원차단</span>
      <span class="closeBtn btn">닫기</span>
    </div>
 </div>
  <script>
    const modal = document.querySelector('.modal');
    //모달 닫기 버튼
    const closeBtn = document.querySelector('.closeBtn')
    closeBtn.addEventListener('click', function(){
    	modal.style.display = 'none';
    });
    
    //멤버클릭시
    const memberTable = document.querySelector('.memberTable');
    memberTable.addEventListener('click', function(e){
    	//console.log(e.target.parentNode.classList[1]);
    	if(e.target.parentNode.classList[0] == 'memberTr'){
    		modal.style.display = 'block';
    		fetch('/admin/getMember?mem_idx='+e.target.parentNode.classList[1], {
    			method : 'GET',
    			headers: { 'Content-Type': 'application/json' },
    		})
    		.then(result => result.json())
    		.then(member => {
    			//console.log(member);
    			document.querySelector('input[name="mem_idx"]').value = member.mem_idx;
    			document.querySelector('.email').innerHTML = member.email;
    			document.querySelector('.username').innerHTML = member.username;
    			document.querySelector('.nickname').innerHTML = member.nickname;
    			document.querySelector('.phone').innerHTML = member.phone;
    			document.querySelector('.birth').innerHTML = member.birth;
    			document.querySelector('.address').innerHTML = member.address1+member.address2;
    			document.querySelector('.com_date').innerHTML = member.com_date;
    			
    			//사용권한
    			if(member.user_grant == 'ADMIN'){ document.querySelector('.user_grant').innerHTML = "관리자"; }
    			else if(member.user_grant == 'USER'){ document.querySelector('.user_grant').innerHTML = "일반회원"; }
    			else if(member.user_grant == 'BAN'){ document.querySelector('.user_grant').innerHTML = "차단회원"; }
    			else{ document.querySelector('.user_grant').innerHTML = "error"; }
    		});
    	};
    	
    	fetch('/admin/getReportMember', {
			method : 'POST',
			headers: { 'Content-Type': 'application/json' },
			body:JSON.stringify({
                email: e.target.parentNode.id // email을 JSON으로 변환하여 전달
            })
		})
		.then(result => result.json())
		.then(reportList => {
			//console.log(reportList);
			let report = reportList;
			let reportHTML = '';
			const reports = document.querySelector('.reports');
			for(let i=0; i<report.length; i++){
				console.log(report[i]);
				reportHTML += '<tr class="report" id='+report[i].report_room+'>'
			        + '<td>'+(i+1)+'</td>'
			        + '<td>'+report[i].reporter_email+'</td>'
			        + '<td>'+report[i].reg_date+'</td>'
			        + '<td><button class="viewChatting" onclick="reportChatting(\''+report[i].chat_report_content+'\')">채팅 확인 </button></td>'
			      +'</tr>';
			}
			reports.innerHTML += reportHTML;
			
			const reportTr = document.querySelectorAll('.report');
			reports.addEventListener('click', function(e){
				console.log(e.target.parentNode);
				let chatting_no = e.target.parentNode.id;
				
			});
		});
    });
    
    function reportChatting(chatList){
    	let html='<td class="chatting">';
    	 chatList = chatList.split(',')
		    for(let j = 0; j<chatList.length-1; j++){
		   		html += '<span class="chatLog">'+chatList[j]+'</span><br>';
		    }
    	 html+='</td>'
    	document.querySelector("#chatting_content").innerHTML=html;
    document.querySelector("#viewChatting").classList.remove("hidden");
    }
    function closeChatting(){
        document.querySelector("#viewChatting").classList.add("hidden");
    }
    //차단버튼 클릭시
    const banBtn = document.querySelector('.banBtn');
    banBtn.addEventListener('click', function(){
    	//차단
    	console.log(document.querySelector('.mem_idx').innerHTML);
    	const form = document.querySelector('.form');
    	form.action = "/admin/user/ban";
    	form.submit();
    })
  </script>
</body>
</html>