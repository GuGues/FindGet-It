<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
</head>
<body>
<form action="/sighup/reg" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

    <h2>회원가입</h2>
    <div>
        <input type="text" name="email" placeholder="EMAIL"/>
    </div>
    <div>
        <input type="password" name="password" placeholder="PASSWORD"/>
    </div>
    <div>
        <input type="text" name="nickname" placeholder="NICKNAME"/>
    </div>
    <div>
        <input type="text" name="username" placeholder="USERNAME"/>
    </div>
    <div>
        <input type="date" name="birth" placeholder="BIRTH"/>
    </div>
    <div>
        <input type="text" name="phone" placeholder="PHONE"/>
    </div>
    <div>
        <input type="text" name="address1" placeholder="ADDRESS1"/>
    </div>
    <div>
        <input type="text" name="address2" placeholder="ADDRESS2"/>
    </div>
    <div>
        <input type="number" name="postnumber" placeholder="POSTNUMBER"/>
    </div>
    <button type="submit">회원가입</button>
    <button type="button" onclick="location.href='/'">홈으로</button>
</form>
</body>
</html>