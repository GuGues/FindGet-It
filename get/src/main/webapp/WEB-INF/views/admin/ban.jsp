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
</style>
</head>
<body>
<%@include file="/WEB-INF/include/adminSide.jsp" %>
  <main>
    <div class="titleBox">
      <div class="right" style="font-size: 13px;">
        <a href="/">HOME</a>&nbsp;&gt;&nbsp;<a href="/admin/ban">사용자관리</a>
      </div>
      <h3 class="title">사용자관리</h3>
    </div>
    <hr style="color: #8C6C55; border-width: 3px;">
    <div><h4 style="padding-left: 20px; margin-bottom: 20px;">사용자 목록</h4></div>
    <div class="right" style="padding-right: 5%; margin-bottom: 5px; margin-top: -30px;">
      <input type="button" value="작성" class="write" style="padding: 5px 15px;">
    </div>
    ${ url }
    ${ sessionScope }
    <div class="pagingDiv">
      <%@include file="/WEB-INF/include/paging.jsp" %>
    </div>
  </main>
</body>
</html>