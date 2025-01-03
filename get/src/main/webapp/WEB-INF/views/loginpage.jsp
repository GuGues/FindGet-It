<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
</head>
<body>
<form action="/auth" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

    <h2>로그인</h2>
    <div>
        <input type="text" name="username" placeholder="Email"/>
    </div>
    <div>
        <input type="password" name="password" placeholder="Password"/>
    </div>

    <button type="submit">로그인</button>
    <a href="/sighup">회원가입</a>
</form>
</body>
</html>