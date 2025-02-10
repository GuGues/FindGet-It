<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 상세</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        main {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            margin-left: 20%;
        }
        h2 {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            text-align: left;
            padding: 10px;
        }
        th {
            font-weight: bold;
            color: #555;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            margin-bottom: 20px;
        }
        textarea {
            resize: none;
            height: 120px;
        }
        .btn-submit {
            display: inline-block;
            padding: 10px 20px;
            background-color: #ff7f27;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-align: center;
            font-size: 14px;
        }
        .btn-submit:hover {
            background-color: #e0691b;
        }
        .response-box {
            background-color: #f9f9f9;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            padding: 15px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <main>
    	<%@include file="/WEB-INF/include/side.jsp"%>
    	<div>
    	<h5><a href="/">Home</a>><a href="#">Mypage</a></h5>
    	</div>
        <h2>1:1 문의</h2>
        <hr>
        <table>
            <tr>
                <th>성명</th>
                <td>${member.username }</td>
                <th>아이디</th>
                <td>${member.email }</td>
                <th>닉네임</th>
                <td>${member.nickname }</td>
                <th>작성일</th>
                <td>${cs.cs_reg_date }</td>
            </tr>
        </table>
            <div>
                <label for="title">제목</label>
                <input type="text" id="title" name="title" value="${ cs.cs_title }"readonly>
            </div>
            <div>
                <label for="content">내용</label>
                <textarea id="content" name="content" readonly>${ cs.cs_content }</textarea>
            </div>                
        <h3>관리자 답변</h3>
        <div class="response-box">
            <p>관리자가 답변을 작성할 공간입니다.</p>
        </div>
    </main>
    	<%@include file="/WEB-INF/include/fab.jsp"%>
</body>
</html>