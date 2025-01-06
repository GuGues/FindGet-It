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
   .right{ width: 100%; padding-right: 20px; text-align:right; }
   a{ color: black; cursor: pointer; text-decoration: none;}
   .contentBox{
     margin: 25px auto;
     width: 100%;
     border: 2px solid #FFAE6B;
     padding: 40px 20px;
     border-radius: 10px;
   }
   textarea {resize: none; width: 100%; padding: 0;margin: 0; border: 1px solid #E2D4D4; }
   input[type="text"]{ width: 100%; padding: 0;margin: 0; border: 1px solid #E2D4D4;}
   input[type="button"]{ background-color: #FE8015; border: none; border-radius: 5px; padding: 8px; color: white; }
   input[type="button"]:hover{ background-color: #FFAE6B; border: none; border-radius: 5px; padding: 8px; color: white; }
</style>
<body>
<%@include file="/WEB-INF/include/side.jsp" %>
  <main>
    <div class="titleBox">
      <div class="right" style="font-size: 13px;">
        <a href="/">HOME</a>&nbsp;&gt;&nbsp;<a href="/faq">FAQ</a>&nbsp;&gt;&nbsp;<a href="/faq">1대1 문의</a>
      </div>
      <h3 class="title">FAQ</h3>
    </div>
    <hr style="color: #FE8015; border-width: 3px;">
    <div><h4 style="padding-left: 20px;">1대1 문의</h4></div>
    <div class="right" style="margin-top: -20px;"><input type="button" value="목록" class="faqList"></div>
    <div class="contentBox">
    <form method="POST" class="submit">
      <input type="hidden" name="email" value="${ sessionScope.email }">
      <div class="right">
        <span>작성일</span>
        <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yy-MM-dd" />
      </div>
      <div>Q 문의사항</div>
      <div>
        제목 : <input type="text" name="cs_title">
      </div>
      <div>내용 :</div>
      <div>
        <textarea rows="2" cols="120" class="question" name="cs_content"></textarea>
      </div>
    </form>
    </div>
    <div class="right">
      <input type="button" value="작성완료" class="faqInsertBtn" style="padding: 5 10px;">
    </div>
  </main>
  <script>
    //목록 버튼 클릭
    const faqListBtn = document.querySelector('.faqList');
    faqListBtn.addEventListener('click',function(){
    	window.location.href = "/faq";
    });
    
    //작성 버튼 클릭
    const faqInsertBtn = document.querySelector('.faqInsertBtn');
    faqInsertBtn.addEventListener('click',function(){
    	let question = document.querySelector('.question');
    	if(question.value == ""){
    		alert("질문을 작성해주세요");
    		question.focus();
    	}
    	else{
    		document.querySelector('.submit').action = '/faq/cs/insert';
        	document.querySelector('.submit').submit();
    	}
    });
  </script>
</body>
</html>