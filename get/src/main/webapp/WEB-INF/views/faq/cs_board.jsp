<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찾GET어 : FAQ</title>
<link rel="icon" type="image/png" href="/img/favicon.ico" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
</head>
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
   .contentBox{ width: 100%; }
   input[type="button"]{ background-color: #B39977; border: none; border-radius: 5px; padding: 5px; color: white;}
   .tableTitle{ height: 80px; }
   .contentBox {
    display: block;
	border: solid 2px #8C6C55;
	border-radius: 10px;
	width: 100%;
   }
  tbody:not(.tableTitle tbody) {
    display: block;  /* thead와 tbody를 block으로 설정 */
    width: 100%;      /* tbody도 100% 너비 설정 */
  }
  tr:not(.tableTitle tr) {
    display: flex;  /* tr을 flex로 설정하여 셀들이 가로로 나열되도록 */
    width: 100%;
  }
  td:not(.tableTitle td)  {
    display: inline-block;  /* 셀을 inline-block으로 설정 */
    padding: 8px;
  }
  td:not(.tableTitle td, .answer td)  { border-bottom: 1px solid #ddd;  /* 셀에 경계 추가 */}
  tr td:nth-child(1):not(.tableTitle td) { width: 5%; }
  tr td:nth-child(1):not(.tableTitle td, .answer td)  { border-right: double #B39977;  /* 셀에 경계 추가 */}
  tr td:nth-child(2):not(.tableTitle td) { width: 50%; }
  tr td:nth-child(3):not(.tableTitle td) { width: 25%; }
  tr td:nth-child(4):not(.tableTitle td) { width: 10%; }
  tr td:nth-child(5):not(.tableTitle td) { width: 10%; }
  tr td:nth-child(5):not(.tableTitle td, .answer td)  { border-left: 2px solid #B39977;  /* 셀에 경계 추가 */}
  .answer{ min-height: 100px; display: table; border: 15px white solid; border-radius: 5px; border-collapse: separate;}
  .answer td{ background-color: #F3E6D5; }
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
      width:50%;
      height:60%;
      transform: translate(-50%, -50%);	

      padding:40px 10px;  

      text-align: center;

      background-color: rgb(255,255,255);
      border-radius:10px; 
      box-shadow:0 2px 3px 0 rgba(34,36,38,0.15);
      
   }
   .content{ height: 60%; margin-top: 40px;}
   .btn{ background-color: #B39977; color: white;}
   .btn:hover{ background-color: #8C6C55;}
   input[type="text"]{ width: 70%; }
   .questionBox, .answerBox{
     border: solid 1px #ECECEC;
     border-radius: 7px;
     box-shadow:0 2px 3px 0 rgba(34,36,38,0.15);
     margin: 15px auto;
   }
   .questionBox{
     width: 80%;
     height: 70%;
     padding: 30px;
   }
   .answerBox{
     width: 80%;
     height: 20%;
     padding: 30px;
     overflow-y: scroll;
   }
   .answerBox textarea{
     border: solid 1px #ECECEC;
     width: 80%;
     resize: none;
     overflow-y: scroll;
   }
   .none{ display: none; }
   tr:not(.tableTitle tr):hover{ background-color: #D3C4B1 }
   .pagingDiv{
     display: flex;
     justify-content: center;
   }
</style>
<body>
<%@include file="/WEB-INF/include/adminSide.jsp" %>
  <main>
    <div class="titleBox">
      <div class="right" style="font-size: 13px;">
        <a href="/">HOME</a>&nbsp;&gt;&nbsp;<a href="/faq">FAQ</a>&nbsp;&gt;&nbsp;<a href="/faq/one">1:1문의</a>
      </div>
      <h3 class="title">FAQ</h3>
    </div>
    <hr style="color: #8C6C55; border-width: 3px;">
    <div><h4 style="padding-left: 20px; margin-bottom: 20px;">1:1 문의 목록</h4></div>
    <div style="text-align: center;">
    <table style="width: 100%;">
      <colgroup>
        <col style="width: 5%;">
        <col style="width: 50%;">
        <col style="width: 25%;">
        <col style="width: 10%;">
        <col style="width: 10%;">
      </colgroup>
      <thead class="tableTitle list">
        <tr>
        <td>순번</td>
        <td>문의 제목</td>
        <td>문의자 이메일</td>
        <td>등록일</td>
        <td>문의상태</td>
        </tr>
      </thead>
    </table>
    <table class="contentBox list">
      <c:forEach items="${ csList }" var="cs" varStatus="i">
        <tr class="${ cs.cs_idx } ${ cs.cs_state } question">
          <td>${ (pagingHelper.nowPage - 1 )* 15 + i.index + 1 }</td>
          <td class="cs_question">${ cs.cs_title }</td>
          <td>${ cs.email }</td>
          <td>${ cs.cs_reg_date }</td>
          <td>
            <c:if test="${ cs.cs_state==1 }">답변완료</c:if>
            <c:if test="${ cs.cs_state==2 }">미답변</c:if>
            <c:if test="${ cs.cs_state==3 }">블라인드</c:if>
          </td>
        </tr>
      </c:forEach>
    </table>
    </div>
    <div class="modal">
      <div class="modal_content">
        <form method="POST" class="submit">
        <h3>1:1문의 답변</h3>
        <div class="content">
          <input type="hidden" name="cs_idx" class="idx">
          <div class="questionBox">
            <div style="text-align: left; margin-left: 5%;" class="cs_email"></div>
            <div style="text-align: left; margin-left: 5%;" class="cs_title"></div>
            <div style="text-align: left; margin-left: 5%;" class="cs_content"><br></div>
          </div>
          <div class="answerBox">
            <div style="text-align: left; margin-left: 10%;">답변: </div>
            <div><textarea rows="5" cols="50" class="modalAnswer" name="cs_answer"></textarea></div>
          </div>
        </div>
        <span class="okBtn btn">답변 작성</span>
        <span class="closeBtn btn">닫기</span>
        </form>
      </div>
    </div>
    <div class="pagingDiv">
      <%@include file="/WEB-INF/include/paging.jsp" %>
    </div>
  </main>
  <script>
	  const contentBox = document.querySelector('.contentBox');
	  contentBox.addEventListener('click', function(e){
		
		  
		  //클릭시 modal
		  if(e.target.parentNode.classList.contains('question')){
			  document.querySelector('.modal').style.display = 'block';
			  
			  //console.log(e.target.parentNode.classList[0]);
			  document.querySelector('.idx').value = e.target.parentNode.classList[0];
			  
			  fetch('/faq/cs/question?cs_idx='+e.target.parentNode.classList[0], {
				  method: 'GET',
				  headers: { 'Content-Type': 'application/json' },
			  })
			  .then(response => response.json())
			  .then(cs => {
				  document.querySelector('.cs_email').innerHTML = '문의자 이메일: ' + cs.email;
				  document.querySelector('.cs_title').innerHTML = '제목: ' + cs.cs_title;
				  document.querySelector('.cs_content').innerHTML = '내용:<br>' + cs.cs_content;
				  
				  if(cs.cs_state == 1 || cs.cs_state == 3){
					  document.querySelector('.okBtn').classList.add('none');
					  document.querySelector('.cs_content').readOnly = true;
					  document.querySelector('.modalAnswer').value = cs.cs_reply;
				  }
				  else if(cs.cs_state == 2){
					  document.querySelector('.okBtn').classList.remove('none');
					  document.querySelector('.cs_content').readOnly = false;
				  }
			  });
			  
			  //확인버튼 클릭시
			  const okBtn = document.querySelector('.okBtn');
			  okBtn.addEventListener('click', function(){
				  document.querySelector('.submit').action = '/faq/cs/update';
				  document.querySelector('.submit').submit();
			  })
			  
			  //닫기버튼 클릭시
			  const closeBtn = document.querySelector('.closeBtn');
			  closeBtn.addEventListener('click', function(){
				  document.querySelector('.modalAnswer').value="";
				  document.querySelector('.modal').style.display = 'none';
			  });
		  }
	  });
  </script>
</body>
</html>