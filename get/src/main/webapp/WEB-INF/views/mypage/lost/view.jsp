<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분실물 상세</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
main {
	margin-left: 20%;
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
		<h1 class="main-title">분실물 상세보기</h1>
		<p class="sub-title">
			소중한 물건 어쩌고, <span class="highlight">보관장소 연락처</span>로 관리번호를 말씀해주시기를
			바랍니다.
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
						<td><strong>분실물명:</strong> ${ lost.lost_title }</td>
					</tr>
					<tr>
						<td><strong>관리번호:</strong> ${lost.lost_idx }</td>
					</tr>
					<tr>
						<td><strong>분실 날짜:</strong> ${lost.lost_date }</td>
					</tr>
					<tr>
						<td><strong>분실 지역:</strong> ${ locations.sido_name },${ locations.gugun_name }</td>
					</tr>
					<tr>
						<td><strong>물품분류:</strong> ${ items.item }</td>
					</tr>
					<tr>
						<td><strong>분실물 상세정보:</strong> ${ items.l_item_detail }</td>
					</tr>
					<tr>
						<td><strong>분실 상세 장소:</strong> ${ lost.l_location_detail }</td>
					</tr>
					<tr>
						<c:choose>
							<c:when
								test="${ lost.lost_state != null && lost.item_state == 1 }">
								<td><strong>분실물상태:</strong> <span class="highlight1">찾았음</span></td>
							</c:when>
							<c:when
								test="${ lost.lost_state != null && lost.lost_state == 2 }">
								<td><strong>분실물상태:</strong> <span class="highlight2">못찾았음</span></td>
							</c:when>
							<c:when
								test="${ lost.lost_state == null && lost.lost_state == 0 }">
								<td><strong>분실물상태:</strong> <span class="highlight3">블라인드</span></td>
							</c:when>
						</c:choose>

					</tr>
					<tr>
						<td><strong>분실자 연락처:</strong> 111</td>
					</tr>
				</table>
			</div>
		</div>

		<!-- 버튼 -->
		<div class="btn-box my-3">
			<a href="/some-link" class="button-link">1대1 톡 보내기</a> <a
				href="/some-link" class="button-link">분실물 처리절차</a> <a
				href="/some-link" class="button-link">지도로 분실위치 찾기</a>
		</div>

		<hr>

		<div>
			<textarea rows="4" readonly>${ lost.lost_content }</textarea>
			<div>
				<a class="btn btn-primary" href="/Mypage/Lost">목록</a>
				<c:if test="${sessionScope.email eq lost.email}">
					<a class="btn btn-primary"
						href="/Mypage/LostUpdate/${lost.lost_idx}">수정</a>
					<a class="btn btn-primary" id="delete"
						href="/Mypage/LostDelete/${lost.lost_idx}" onclick="return false">삭제
					</a>
				</c:if>
			</div>
		</div>
	</main>
	<%@include file="/WEB-INF/include/fab.jsp"%>
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
                    window.location.replace("/Mypage/Lost");
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