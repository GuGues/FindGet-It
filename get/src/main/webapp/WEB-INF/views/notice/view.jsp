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
    height: 100%;
    width: 80%;
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
   .tableDiv { 
     border-radius: 7px;
     padding: 30px;
     box-shadow:3px 5px 5px 5px rgba(34,36,38,0.1);
     min-height: 300px;
     max-height: 700px;
   }
   .tableDiv tr:last-of-type *{
     border-bottom: none;
   }
  <c:if test="${ sessionScope.grant eq 'ADMIN' }">
     hr{ color: #8C6C55; border-width: 3px; }
     .tableDiv { border: 2px solid #684F36; }
     .btn{ background-color: #B39977; color: white;}
     .btn:hover{ background-color: #8C6C55;}
  </c:if>
  <c:if test="${ sessionScope.grant ne 'ADMIN' }">
     hr{ color: #FE8015; border-width: 3px; }
     .tableDiv { border: 2px solid #FE8015; }
     .btn{ background-color: #FE8015; color: white;}
     .btn:hover{ background-color: #FFD5B2;}
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
    <hr>
    <div><h4 style="padding-left: 20px; margin-bottom: 20px;">공지사항 상세보기</h4></div>
    <c:if test="${ sessionScope.grant eq 'ADMIN' }">
      <div class="right" style="padding-right: 5%; margin-bottom: 5px; margin-top: -30px;">
        <input type="button" value="수정" class="updateBtn btn" style="padding: 5px 15px;">
        <input type="button" value="삭제" class="delBtn btn" style="padding: 5px 15px;">
        &nbsp;&nbsp;&nbsp;
        <input type="button" value="목록" class="listBtn btn" style="padding: 5px 15px;">
      </div>
    </c:if>
    <c:if test="${ sessionScope.grant ne 'ADMIN' }">
      <div class="right" style="padding-right: 5%; margin-bottom: 5px; margin-top: -30px;">
        <input type="button" value="목록" class="listBtn btn" style="padding: 5px 15px;">
      </div>
    </c:if>
    <div class="tableDiv">
      <table class="table" style="width: 100%;">
        <colgroup>
          <col style="width: 10%;">
          <col style="width: 60%;">
          <col style="width: 20%;">
          <col style="width: 10%;">
        </colgroup>
        <tr>
          <td rowspan="3">제목</td>
          <td rowspan="3">${ notice.notice_title }</td>
        </tr>
        <tr>
          <td>작성일</td>
          <td>${ notice.n_reg_date }</td>
        </tr>
        <tr>
          <td>조회수</td>
          <td>${ notice.n_views }</td>
        </tr>
        <tr><td colspan="4">내용</td></tr>
        <tr>
          <td colspan="4">
            ${ notice.notice_content }
          </td>
        </tr>
      </table>
    </div>
  </main>
  <script>
    const updateBtn = document.querySelector('.updateBtn');
    if(updateBtn){
    	updateBtn.addEventListener('click', function(){
        	window.location.href="/notice/update?notice_idx=${notice.notice_idx}";
        });
    }
    
    const delBtn = document.querySelector('.delBtn');
    if(delBtn){
    	delBtn.addEventListener('click', function(){
        	window.location.href="/notice/delete?notice_idx=${notice.notice_idx}";
        });
    }
    
    const listBtn = document.querySelector('.listBtn');
    listBtn.addEventListener('click', function(){
    	window.location.href="/notice";
    });
  </script>
</body>
</html>