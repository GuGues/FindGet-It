
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h2>채팅방 리스트</h2>
    <c:forEach items="${roomList}" var="room">
        <a href="/room/${room.chatting_no}">${room.chatting_no}번의 채팅방</a>
    </c:forEach>
    <a href="/roomForm">채팅방 만들기</a>
</body>
</html>
