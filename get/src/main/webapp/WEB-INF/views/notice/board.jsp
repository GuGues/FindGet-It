<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찾GET어 : 공지사항</title>
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
  tr td:nth-child(1):not(.tableTitle td) { width: 10%; }
  tr td:nth-child(2):not(.tableTitle td) { width: 60%; }
  tr td:nth-child(3):not(.tableTitle td) { width: 20%; }
  tr td:nth-child(4):not(.tableTitle td) { width: 10%; }
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
      width:700px;
      height:420px;
      transform: translate(-50%, -50%);	

      padding:40px;  

      text-align: center;

      background-color: rgb(255,255,255);
      border-radius:10px; 
      box-shadow:0 2px 3px 0 rgba(34,36,38,0.15);
      
   }
   .content{ height: 60%; margin-top: 40px;}
   .btn{ background-color: #B39977; color: white;}
   .btn:hover{ background-color: #8C6C55;}
   input[type="text"]{ width: 70%; }
   .pagingDiv{
     display: flex;
     justify-content: center;
   }
   <c:if test="${ sessionScope.grant eq 'ADMIN' }">
   .contentBox { border: solid 2px #8C6C55; }
   tr td:nth-child(1):not(.tableTitle td, .answer td)  { border-right: 2px solid #B39977;  /* 셀에 경계 추가 */}
   tr:not(.tableTitle tr):hover{ background-color: #D3C4B1 }
   </c:if>
   <c:if test="${ sessionScope.grant ne 'ADMIN' }">
   .contentBox { border: solid 2px #FE8015; }
   tr td:nth-child(1):not(.tableTitle td, .answer td)  { border-right: 2px solid #FE8015;  /* 셀에 경계 추가 */}
   tr:not(.tableTitle tr):hover{ background-color: #FFD5B2 }
   </c:if>
</style>
<body>
  <c:choose>
    <c:when test="${ sessionScope.grant eq 'ADMIN' }">
      <%@include file="/WEB-INF/include/adminSide.jsp" %>
    </c:when>
    <c:when test="${ sessionScope.grant ne 'ADMIN' || !sessionScope.grant }">
      <%@include file="/WEB-INF/include/side.jsp" %>
    </c:when>
  </c:choose>
  <main>
    <div class="titleBox">
      <div class="right" style="font-size: 13px;">
        <a href="/">HOME</a>&nbsp;&gt;&nbsp;<a href="/notice">공지사항</a>
      </div>
      <h3 class="title">공지사항</h3>
    </div>
    <hr style="color: #8C6C55; border-width: 3px;">
    <div>
      <h4 style="padding-left: 20px; margin-bottom: 20px;">
        <c:if test="${ sessionScope.grant eq 'ADMIN' }">공지사항 관리</c:if>
        <c:if test="${ sessionScope.grant ne 'ADMIN' }">공지사항 목록</c:if>
      </h4>
    </div>
    <c:if test="${ sessionScope.grant eq 'ADMIN' }">
      <div class="right" style="padding-right: 5%; margin-bottom: 5px; margin-top: -30px;">
        <input type="button" value="작성" class="write" style="padding: 5px 15px;">
      </div>
    </c:if>
    <div style="text-align: center;">
    <table style="width: 100%;">
      <colgroup>
        <col style="width: 10%;">
        <col style="width: 60%;">
        <col style="width: 20%;">
        <col style="width: 10%;">
      </colgroup>
      <thead class="tableTitle list">
        <tr>
        <td>순번</td>
        <td>제목</td>
        <td>등록일</td>
        <td>조회수</td>
        </tr>
      </thead>
    </table>
    <table class="contentBox list">
      <c:forEach items="${ noticeList }" var="notice" varStatus="i">
        <tr class="question ${ notice.notice_idx }">
          <td>${ (pagingHelper.nowPage - 1 )* 15 + i.index + 1 }</td>
          <td class="faq_question">${ notice.notice_title }</td>
          <td>${ notice.n_reg_date }</td>
          <td>${ notice.n_views }</td>
        </tr>
      </c:forEach>
    </table>
    </div>
    <div class="pagingDiv">
      <%@include file="/WEB-INF/include/paging.jsp" %>
    </div>
  </main>
  <script>
	  const contentBox = document.querySelector('.contentBox');
	  contentBox.addEventListener('click', function(e){
		  
		  if(e.target.parentNode.classList.contains('question')){
			  let notice_idx = e.target.parentNode.classList[1];
			  console.log(notice_idx);
			  window.location.href="/notice/view?notice_idx="+notice_idx;
		  }
		  
		  //수정 버튼 클릭시(modal)
		  else if(e.target.classList.contains('upBtn')){
			  document.querySelector('.modal').style.display = 'block';
			  let id = e.target.classList[0];
			  let faq = document.querySelectorAll('.'+id);
			  document.querySelector('.idx').value=id;
			  for(let i = 0; i < faq.length; i++){
				  if(faq[i].querySelector('.faq_question')){
				    let question = faq[i].querySelector('.faq_question');
				    //console.log(question.innerHTML);
				    document.querySelector('.modalQuestion').value = question.innerHTML;
				  }
				  else if(faq[i].querySelector('.faq_answer')){
				    let answer = faq[i].querySelector('.faq_answer');
				    document.querySelector('.modalAnswer').value = answer.innerHTML;
				  }
			  }
			  
			  //확인버튼 클릭시
			  const okBtn = document.querySelector('.okBtn');
			  okBtn.addEventListener('click', function(){
				  document.querySelector('.submit').action = '/faq/update';
				  document.querySelector('.submit').submit();
			  })
			  
			  //닫기버튼 클릭시
			  const closeBtn = document.querySelector('.closeBtn');
			  closeBtn.addEventListener('click', function(){
				  document.querySelector('.modal').style.display = 'none';
			  });

		  }
		  
		  //삭제 버튼 클릭시
		  else if(e.target.classList.contains('delBtn')){
			  let id = e.target.classList[0];
			  if (confirm("정말로 삭제하시겠습니까?")) {
				    window.location.href="/faq/del?id="+id;
				}
		  }
	  });
	  
	  //작성 버튼 클릭시
	  const write = document.querySelector('.write');
	  write.addEventListener('click', function(){
		  window.location.href = '/notice/insert';
	  });
  </script>
</body>
<style>
  <c:if test="${ sessionScope.grant eq 'ADMIN' }">
   .contentBox { border: solid 2px #8C6C55; }
   tr td:nth-child(1):not(.tableTitle td, .answer td)  { border-right: 2px solid #B39977;  /* 셀에 경계 추가 */}
   tr:not(.tableTitle tr):hover{ background-color: #D3C4B1 }
   .now { background-color: #8C6C55; }
  .page-link { background-color: #B39977; }
  .page-link:hover { background-color: #D3C4B1;  color: black;}
   </c:if>
</style>
</html>