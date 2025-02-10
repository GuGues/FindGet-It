<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찾GET어 : 공지사항</title>
<link rel="icon" type="image/png" href="/img/favicon.ico" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<link rel="icon" type="image/png" href="/img/favicon.ico" />
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
   .btn{ background-color: #B39977; color: white;}
   .btn:hover{ background-color: #8C6C55;}
</style>
<body>
<%@include file="/WEB-INF/include/adminSide.jsp" %>
  <main>
    <div class="titleBox">
      <div class="right" style="font-size: 13px;">
        <a href="/">HOME</a>&nbsp;&gt;&nbsp;<a href="/notice">공지사항</a>
      </div>
      <h3 class="title">공지사항</h3>
    </div>
    <hr style="color: #8C6C55; border-width: 3px;">
    <div><h4 style="padding-left: 20px; margin-bottom: 20px;">공지사항 작성</h4></div>
    <div class="right" style="padding-right: 5%; margin-bottom: 5px; margin-top: -30px;">
      <input type="button" value="작성" class="updateBtn btn" style="padding: 5px 15px;">
      <input type="button" value="목록" class="listBtn btn" style="padding: 5px 15px;">
    </div>
    <div style="text-align: center;">
      <form action="/notice/insert" method="POST" class="form">
      <table style="width: 100%;">
        <colgroup>
          <col style="width: 10%;">
          <col style="width: 60%;">
          <col style="width: 20%;">
          <col style="width: 10%;">
        </colgroup>
        <tr>
          <td>제목</td>
          <td><input type="text" name="notice_title"></td>
          <td>작성일</td>
          <td><fmt:formatDate value="<%= new java.util.Date() %>" pattern="yy-MM-dd" /></td>
        </tr>
        <tr><td>내용</td></tr>
        <tr>
          <td colspan="4">
            <textarea rows="10" cols="100" style="width: 90%;" name="notice_content"></textarea>
          </td>
        </tr>
      </table>
      </form>
    </div>
  </main>
  <script>
    const updateBtn = document.querySelector('.updateBtn');
    updateBtn.addEventListener('click', function(){
  	  document.querySelector('.form').submit();
    });
    
    const listBtn = document.querySelector('.listBtn');
    listBtn.addEventListener('click', function(){
    	window.location.href="/notice";
    });
  </script>
</body>
</html>