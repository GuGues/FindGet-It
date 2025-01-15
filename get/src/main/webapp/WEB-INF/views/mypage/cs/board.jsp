<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내 문의관리</title>
</head>
<style>
main {
	margin-left: 25%;
}

table td, table th {
	border: solid 1px #FE8015;
	text-align: center;
}

th {
	background-color: #FE8015;
}

tr:hover {
	background-color: #FFD5B2;
}

tr.visited {
	background-color: #D9D9D9; /* 조회한 행의 배경색 변경 */
	background-image: url('/icon/get.png'); /* 배경 이미지 추가 */
	background-size: contain; /* 이미지 크기를 행에 맞게 조정 (cover 대신 contain) */
	background-position: right; /* 이미지 중앙 배치 */
	background-repeat: no-repeat; /* 이미지 반복을 방지 */
}

a {
	text-decoration: none;
	color: black;
}

a:hover {
	color: #000000;
}
</style>
<body>
	<%@include file="/WEB-INF/include/side.jsp"%>
	<main>
		<div>
			<div>
				<div class="top">
					<a href="/">Home</a>><a href="#">Mypage</a>
				</div>
				<h2>나의 문의글</h2>
				<hr>
				<h4>내가 쓴 글${count2}개</h4>
				<div>
					<button id="deleteBtn">삭제</button>
				</div>
				<div>
					<table>
						<colgroup>
							<col style="width: 10%;">
							<col style="width: 65%;">
							<col style="width: 10%;">
							<col style="width: 10%;">
							<col style="width: 5%;">
						</colgroup>
						<thead>
							<tr>
								<th>순번</th>
								<th>제목</th>
								<th>등록일</th>
								<th>상태</th>
								<th>삭제</th>
							</tr>
						</thead>
						<c:if test="${ empty csList }">
							<tr>
								<td colspan="4">등록한 문의글이 없습니다.😁</td>
							</tr>
						</c:if>
						<c:if test="${ not empty csList }">
							<c:forEach items="${ csList }" var="cs" varStatus="c_status">
								<tr onclick="markAsVisited(this)">
									<td><a href="#">${c_status.index + 1}</a></td>
									<td><a href="/Mypage/Cs/View/${cs.cs_idx }">${cs.cs_title}</a></td>
									<td><a href="#">${cs.cs_reg_date}</a></td>
									<td><a href="#">${cs.cs_state}</a></td>
									<td><input type="checkbox" value="${cs.cs_idx}" /></td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
				</div>
			</div>
		</div>

		<script>
    function markAsVisited(row) {
        row.classList.add('visited');  // 행에 visited 클래스 추가
    }
    
    document.querySelector('#deleteBtn').addEventListener('click', function () {
        const selectedbox = [];
        
        document.querySelectorAll('input[type="checkbox"]:checked').forEach(checkbox => {
            selectedbox.push(checkbox.value);
        });

        if (selectedbox.length > 0) {
            // AJAX 요청으로 삭제 처리
            fetch('/Mypage/Cs/Delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(selectedbox), 
            })
            .then(response => {
                if (response.ok) {
                    alert('삭제되었습니다.');
                    // 페이지 새로고침
                    location.reload();
                } else {
                    alert('삭제 중 문제가 발생했습니다.');
                }
            })
            .catch(error => {
                console.error('에러 발생:', error);
                alert('삭제 요청 중 에러가 발생했습니다.');
            });
        } else {
            alert('삭제할 문의글을 선택하세요.');
        }
    });

</script>
	</main>
	<%@include file="/WEB-INF/include/fab.jsp"%>
</body>
</html>