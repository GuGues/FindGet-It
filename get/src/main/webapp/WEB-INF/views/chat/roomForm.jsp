<%--
  Created by IntelliJ IDEA.
  User: GGG
  Date: 2024-12-19
  Time: 오후 4:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h2>채팅방 만들기</h2>
    <form action="/roomOpen" method="post">
    <input type="text" name="chatting_no" placeholder="방번호"/>
    <input type="text" name="open_member" placeholder="user idx"/>
        <button type="submit">확인</button>
    </form>

</body>
</html>
