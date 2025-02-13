<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/css/common.css" />
<!DOCTYPE html>
<style>
  #side_menu {
      max-width: 20%;
      height: 100vh;
      background-color: #FFD5B2;
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
    background-color: #FE8015;
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
    background-color: #FE8015;
    padding: 0;
    margin-bottom: 15px;
  }
  
#side_com {
    margin-top: auto;  /* 자동으로 하단에 위치하게 설정 */
    text-align: center;
    padding: 10px 0;
    background-color: #FFD5B2; /* 배경색은 기존과 동일 */
    font-size: 13px;
}
.side-title{
  font-family: 'SANJUGotgam';
}
</style>
<c:set var="REQ_URL" value="${ pageContext.request.requestURL }"/>
<c:set var="url" value="${ REQ_URL.toString() }"/>

<nav id="side_menu">
  <a href="/"><img alt="Logo" src="/logo/logo_open_orange.png"></a>
  
  <ul id="menu">
    <c:if test="${!url.contains('/lost') || url.contains('/mypage')}">
     <li><a href="/lost">분실물</a></li>
    </c:if>
    <c:if test="${!url.contains('/found') && !url.contains('/police') || url.contains('/mypage')}">
     <li><a href="/found">습득물</a></li>
    </c:if>
    <c:if test="${!url.contains('/faq') && !url.contains('/cs') || url.contains('/mypage')}">
     <li><a href="/faq">FAQ</a></li>
    </c:if>
    <c:if test="${!url.contains('/notice') || url.contains('/mypage')}">
     <li><a href="/notice">공지사항</a></li>
    </c:if>
  </ul>
  
  <ul id="menu_detail">
    <c:if test="${url.contains('/lost') && !url.contains('/mypage')}">
     <li><h3 class="side-title">분실물</h3></li>
     <li><a href="/lost">찾GET어 분실물</a></li>
     <c:if test="${ empty sessionScope.grant }">
       <li><a href="/login">분실물 의뢰</a></li>
     </c:if>
     <c:if test="${ not empty sessionScope.grant }">
       <li><a href="/lost/write">분실물 의뢰</a></li>
     </c:if>
     <li><a href="https://www.lost112.go.kr/html.do?html=/member/login&sub=U&title=%ED%9A%8C%EC%9B%90%EB%A7%88%EB%8B%B9&ptitle=%EB%A1%9C%EA%B7%B8%EC%9D%B8&MENU_NO=MENU5400" target="blank">경찰청 분실물 신고</a></li>
    </c:if>
    <c:if test="${ url.contains('/police') || url.contains('/found') && !url.contains('/mypage')}">
     <li><h3>습득물</h3></li>
     <li><a href="/found">찾GET어 습득물</a></li>
     <li><a href="/police/found">경찰청 등록 습득물</a></li>
     <li><a href="https://www.handphone.or.kr/" target="blank">핸드폰찾기 콜센터</a></li>
    </c:if>
    <c:if test="${url.contains('/faq') || url.contains('/cs') && !url.contains('/mypage')}">
     <li><h3>FAQ</h3></li>
     <li><a href="/faq">자주 묻는 질문</a></li>
     <c:if test="${ empty sessionScope.grant }">
       <li><a href="/login">1:1 문의</a></li>
     </c:if>
     <c:if test="${ not empty sessionScope.grant }">
       <li><a href="/faq/cs/insert">1:1 문의</a></li>
     </c:if>
    </c:if>
    <c:if test="${url.contains('/notice')}">
     <li><h3>공지사항</h3></li>
     <li><a href="/notice">공지사항</a></li>
    </c:if>
    <c:if test="${url.contains('/mypage')}">
     <li><h3><a class="h3" href="/Mypage">마이페이지</a></h3></li>
     <li><a href="/Mypage/Lost/Board">나의 분실물</a></li>
     <li><a href="/Mypage/Found/Board">나의 습득물</a></li>
     <li><a href="/Mypage/Cs/Board">나의 문의글</a></li>
     <li><a href="/Mypage/InfoUpdate/Password">내정보수정</a></li>
    </c:if>

     <c:if test="${url.contains('/search')}">
     <li><h3>검색 페이지</h3></li>
     <li><a href="/">홈으로</a></li>
     <c:if test="${ empty sessionScope.grant }">
       <li><a href="/login">1:1 문의</a></li>
     </c:if>
     <c:if test="${ not empty sessionScope.grant }">
       <li><a href="/cs/write">1:1 문의</a></li>
     </c:if>
     <li><a href="/police/found">경찰 습득물</a></li>
     <li><a href="https://www.handphone.or.kr/" target="blank">핸드폰찾기 콜센터</a></li>
     <li><a href="https://www.lost112.go.kr/html.do?html=/member/login&sub=U&title=%ED%9A%8C%EC%9B%90%EB%A7%88%EB%8B%B9&ptitle=%EB%A1%9C%EA%B7%B8%EC%9D%B8&MENU_NO=MENU5400" target="blank">경찰청 분실물 신고</a></li>
    </c:if>

  </ul>
  
  <div id="side_com">Ⓒnot_null</div>
</nav>
<%@include file="/WEB-INF/include/fab.jsp" %>
