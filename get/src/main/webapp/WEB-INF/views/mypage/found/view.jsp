<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>습득물 상세</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
main {
	margin-left: 20%
}

.main-title {
	font-size: 24px;
	font-weight: bold;
}

.sub-title {
	font-size: 14px;
	color: #555;
}

.highlight1 {
	color: orange;
	font-weight: bold;
}

.highlight2 {
	color: blue;
	font-weight: bold;
}

.info-table td {
	padding: 10px;
	border-bottom: 1px solid #ddd;
}

.btn-box button {
	margin-right: 10px;
}

textarea {
	width: 100%;
	margin-top: 20px;
	resize: none;
}

.button-link {
	display: inline-block;
	padding: 10px 20px;
	background-color: #007bff;
	color: white;
	text-decoration: none;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	text-align: center;
}

.button-link:hover {
	background-color: #0056b3;
}
</style>
</head>
<body class="container my-5">
	<%@include file="/WEB-INF/include/side.jsp"%>
	<header>
		<h1 class="main-title">습득물 상세보기</h1>
		<p class="sub-title">
			분실하신 물건 여부를 확인하시고, <span class="highlight">보관장소 연락처</span>로 관리번호를
			말씀해주시기를 바랍니다.
		</p>
		<hr>
	</header>

	<main>
		<div class="row">
			<!-- 이미지 -->
			<div class="col-md-4">
				<img src="example-image.jpg" alt="습득물 사진" class="img-fluid">
			</div>

			<!-- 정보 테이블 -->
			<div class="col-md-8">
				<table class="info-table w-100">
					<tr>
						<td><strong>습득물명:</strong> ${ found.found_title }</td>
					</tr>
					<tr>
						<td><strong>관리번호:</strong> ${found.found_idx }</td>
					</tr>
					<tr>
						<td><strong>습득일:</strong> ${found.found_date }</td>
					</tr>
					<tr>
						<td><strong>습득장소:</strong> ${ locations.sido_name },${ locations.gugun_name }</td>
					</tr>
					<tr>
						<td><strong>물품분류:</strong> ${ items.item }</td>
					</tr>
					<tr>
						<td><strong>보관장소:</strong> ${ found.f_location_detail }</td>
					</tr>
					<tr>
						<c:choose>
							<c:when
								test="${ found.item_state != null && found.item_state == 1 }">
								<td><strong>유실물상태:</strong> <span class="highlight1">보관중</span></td>
							</c:when>
							<c:when
								test="${ found.item_state == null && found.item_state == 0 }">
								<td><strong>유실물상태:</strong> <span class="highlight2">분실접수</span></td>
							</c:when>
						</c:choose>

					</tr>
					<tr>
						<td><strong>보관자 연락처:</strong> 1121212</td>
					</tr>
				</table>
			</div>
		</div>

		<!-- 버튼 -->
		<div class="btn-box my-3">
			<a href="#" class="button-link">1대1 톡 보내기</a> 
			<a href="#" class="button-link">습득물 처리절차</a> 
			<a href="#" class="button-link">지도로 보관위치 찾기</a>
		</div>

		<hr>

		<div>
			<textarea rows="4" readonly>${ found.found_content }</textarea>
			<div>
				<a class="btn btn-primary" href="/Mypage/Found">목록</a>
				<c:if test="${sessionScope.email eq found.email}">
					<a class="btn btn-primary"
						href="/Mypage/FoundUpdate/${found.found_idx}">수정</a>
					<a class="btn btn-primary" id="delete"
						href="/Mypage/FoundDelete/${found.found_idx}"
						onclick="return false">삭제 </a>
				</c:if>
			</div>
		</div>
	</main>
	<%@include file="/WEB-INF/include/pagefab.jsp"%>
	<script>
	<script>
    document.getElementById("delete").onclick=()=>{
        if(confirm("정말 삭제하시겠습니까?")){
            fetch(document.getElementById("delete").href,{
                method:"DELETE"
                ,headers:{
                    'Content-type': 'application/json; charset=UTF-8'
                }
            }).then(response=> {
                    alert("삭제 되었습니다.");
                    window.location.replace("/Mypage/Found");
                }
            ).catch(err=>alert("삭제 실패")+err)
        }
        return false;
    }
</script>
</body>
</html>
</body>
</html>