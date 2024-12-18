<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head><title>채팅방 목록</title></head>
<body>
<h1>채팅방 목록</h1>
<ul>
  <c:forEach var="room" items="${rooms}">
    <li>
      <a href="/chat/room/${room.roomId}">
        방번호: ${room.roomId}, 생성일: ${room.createdAt}
      </a>
    </li>
  </c:forEach>
</ul>

<form action="/chat/create" method="post">
  <input type="text" name="targetEmail" placeholder="상대방 이메일"/>
  <button type="submit">채팅방 생성</button>
</form>
</body>
</html>