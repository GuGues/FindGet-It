<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<style>
  #side_menu {
      max-width: 20%;
      height: 100vh;
      background-color: #D3C4B1;
      color: black;
      box-sizing: border-box;
      position: fixed;
      top: 0;
      left: 0;
      text-align: center;
      display: flex;
      flex-direction: column;
    }
  #side_menu img{
    width: 80%;
    padding: 40px 10px;
  }
  #side_menu ul{
    text-align: left;
  }
  #side_menu li{ list-style: none; }
  #side_menu a{
    text-decoration: none;
    color: black;
    padding: 10px;
  }
  #menu {
    width: 100%;
    display: flex;
    justify-content: space-between;  /* 항목들이 고르게 배치되도록 */
    padding: 0;
    margin: 0;
    background-color: #EFEFEF;
  }
  #menu li {
    flex: 1;
    text-align: center;
  }
  #menu a {
    display: block; /* a 태그가 블록 요소로 동작하게 함 */
    width: 100%; /* a 태그가 li의 너비를 채우도록 함 */
    padding: 20px 0;
    color: black;
  }
  #menu a:hover {
    background-color: #8C6C55;
    color: white;
    font-weight: 700;
  }
  #menu_detail{
    width: 100%;
    margin: 0;
    padding: 0;	
  }
  #menu_detail h3:first-of-type {
    color: white;
    margin: 0 20px; /* h2 상단 margin 없애기 */
    padding: 20px 0; /* h2와 아래 항목들 사이 간격 조정 */
   }
   #menu_detail li {
    width: 100%;
    padding: 20px 0px 20px 10px;
    margin: 0;
    font-size: large;
  }
  #menu_detail li:hover {
    background-color: white;
    text-transform: uppercase;
  }
  #menu_detail li:first-of-type {
    width: 100%;
    background-color: #8C6C55;
    padding: 0;
    margin-bottom: 15px;
  }
  
#side_com {
    margin-top: auto;  /* 자동으로 하단에 위치하게 설정 */
    text-align: center;
    padding: 10px 0;
    background-color: #8C6C55;
    font-size: 13px;
}
.side-title{
  font-family: 'SANJUGotgam';
}
</style>
<c:set var="REQ_URL" value="${ pageContext.request.requestURL }"/>
<c:set var="url" value="${ REQ_URL.toString() }"/>
<nav id="side_menu">
  <a href="/"><img alt="Logo" src="/logo/logo_open_brown.png"></a>
  
  <ul id="menu">
    <c:if test="${!url.contains('/admin/ban')}">
     <li><a href="/admin/ban">사용자 관리</a></li>
    </c:if>
    <c:if test="${!url.contains('/lost') && !url.contains('/found') && !url.contains('/admin/post')}">
     <li><a href="/admin/post">게시물 관리</a></li>
    </c:if>
    <c:if test="${!url.contains('/faq') && !url.contains('/cs')}">
     <li><a href="/faq">FAQ</a></li>
    </c:if>
    <c:if test="${!url.contains('/notice')}">
     <li><a href="/notice">공지사항</a></li>
    </c:if>
    <c:if test="${!url.contains('/admin/state')}">
     <li><a href="/admin/state">데이터 통계</a></li>
    </c:if>
  </ul>
  
  <ul id="menu_detail">
    <c:if test="${url.contains('/admin/ban')}">
     <li><a href="/lost">사용자 관리</a></li>
    </c:if>
    <c:if test="${url.contains('/lost') || url.contains('/found') || url.contains('/admin/post')}">
     <li><h3 class="side-title">분실물/습득물</h3></li>
     <li><a href="/lost">분실물 관리</a></li>
     <li><a href="/lost/write">습득물 관리</a></li>
     <li><a href="/lost/write">신고 게시글</a></li>
    </c:if>
    <c:if test="${url.contains('/faq') || url.contains('/cs')}">
     <li><h3>FAQ</h3></li>
     <li><a href="/faq">자주 묻는 질문</a></li>
     <li><a href="/cs">1:1 문의</a></li>
    </c:if>
    <c:if test="${url.contains('/notice')}">
     <li><h3>공지사항</h3></li>
     <li><a href="/notice">공지사항</a></li>
    </c:if>
    <c:if test="${url.contains('/admin/state')}">
     <li><a href="/admin/state">데이터 통계</a></li>
    </c:if>
  </ul>
  
  <div id="side_com">Ⓒnot_null</div>
</nav>