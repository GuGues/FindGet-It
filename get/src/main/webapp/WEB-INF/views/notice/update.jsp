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
    <div><h4 style="padding-left: 20px; margin-bottom: 20px;">공지사항 수정</h4></div>
    <div class="right" style="padding-right: 5%; margin-bottom: 5px; margin-top: -30px;">
      <input type="button" value="수정" class="updateBtn btn" style="padding: 5px 15px;">
      <input type="button" value="목록" class="listBtn btn" style="padding: 5px 15px;">
    </div>
    <div style="text-align: center;">
      <form action="/notice/update" method="POST" class="form">
      <input type="hidden" name="notice_idx" value="${ notice.notice_idx }">
      <table style="width: 100%;">
        <colgroup>
          <col style="width: 10%;">
          <col style="width: 60%;">
          <col style="width: 20%;">
          <col style="width: 10%;">
        </colgroup>
        <tr>
          <td rowspan="3">제목</td>
          <td rowspan="3"><input type="text" name="notice_title" value="${ notice.notice_title }"></td>
        </tr>
        <tr>
          <td>작성일</td>
          <td>${ notice.n_reg_date }</td>
        </tr>
        <tr>
          <td>조회수</td>
          <td>${ notice.n_views }</td>
        </tr>
        <tr><td>내용</td></tr>
        <tr>
          <td colspan="4">
            <textarea rows="10" cols="100" style="width: 90%;" name="notice_content">${ notice.notice_content.replaceAll("<br>","") }</textarea>
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