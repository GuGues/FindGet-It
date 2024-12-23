
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h2>채팅방 리스트</h2>
    <c:forEach items="${roomList}" var="room">
        <c:choose>
            <c:when test="${room.open_member eq sessionScope.email}">
                <a href="/chatting/room/${room.chatting_no}">${room.participant}님 과의 채팅</a>
            </c:when>
            <c:otherwise>
                <a href="/chatting/room/${room.chatting_no}">${room.open_member}님 과의 채팅</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</body>
</html>
