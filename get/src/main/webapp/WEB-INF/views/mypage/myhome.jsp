<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소중한 내 정보 잇힝❤️</title>
<link rel="icon" type="image/png" href="/img/favicon.ico" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/common.css">
</head>
<style>
main {
	margin-left: 20%;
	padding: 20px 40px;
}
/* 전체 페이지 스타일 */
body {
	font-family: Arial, sans-serif;
	background-color: white; /* 어두운 배경 */
	color: #fff;
	margin: 0;
	padding: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
}

/* 뱃지 섹션 스타일 */
.badge-container {
	overflow: hidden;
	margin-top: 50px;
	background-color: white; /* 섹션 배경 */
	border-radius: 10px; /* 모서리를 둥글게 */
	padding: 20px;
	max-width: 380px;
	text-align: center;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.badge-container hr {
	color: black;
}

/* 제목 스타일 */
.badge-container h2 {
	margin-bottom: 20px;
	font-size: 24px;
	color: #FE8015;
}

.badge-list {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 20px;
	max-height: 240px;
	overflow: hidden;
	transition: max-height 0.3s ease-in-out;
}

/* 뱃지 아이템 스타일 */
.badge-item {
	width: 100px;
	height: 100px;
	background-color: #444;
	border-radius: 8px;
	display: flex;
	justify-content: center;
	align-items: center;
	overflow: hidden;
	border: 2px solid white;
	transition: transform 0.3s, border-color 0.3s;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

/* 뱃지 이미지 스타일 */
.badge-item img {
	width: 90%;
	height: auto;
}

/* 뱃지 호버 효과 */
.badge-item:hover {
	transform: scale(1.1);
	border-color: #ffdd57;
}

.load-more {
	display: block;
	background-color: #FE8015;
	border: none;
	color: white;
	position: relative;
	top: 20px;
	right: 20px;
	font-size: 16px;
	border-bottom-left-radius: 5px;
	border-bottom-right-radius: 5px;
	transition: background-color 0.3s;
	width: 400px;
}

.load-more:hidden {
	display: none;
}

.load-more:hover {
	background-color: #f4c842;
}

.box1 {
	display: flex;
	gap: 50px;
}

.lostitem-setbox {
	text-align: center;
	width: 400px;
	height: 375px;
	background-color: #fff;
	color: #333;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin-top: 50px; /* 가운데 정렬 */
}

/* 프로필 박스 전체 */
.profile-box {
	width: 700px;
	background-color: #fff;
	color: #333;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin: 0 auto; /* 가운데 정렬 */
}
/* 상단 프로필 영역 */
.profile-header {
	padding-left: 40px;
	display: flex;
	align-items: center;
	gap: 20px; /* 이미지와 정보 간격 */
	margin-bottom: 10px;
}

/* 프로필 이미지 */
.profile-header img {
	width: 80px;
	height: 80px;
	border-radius: 50%; /* 둥근 이미지 */
}

/* 프로필 텍스트 */
.profile-info {
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.profile-info .nickname {
	font-size: 1.2rem;
	font-weight: bold;
	color: #000;
}

.profile-info .join-date {
	font-size: 0.9rem;
	color: #555;
}

/* 상세 정보 */
.profile-details {
	padding-left: 40px;
}

.profile-details ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.profile-details ul li {
	margin-bottom: 10px;
	font-size: 0.9rem;
	color: #555;
}

/* 링크 스타일 */
.profile-details ul li a {
	color: #007bff;
	text-decoration: none;
	font-weight: bold;
}

.profile-details ul li a:hover {
	text-decoration: underline;
}

#topm {
	color: #FE8015;
	text-align: right;
	margin-bottom: 40px;
}

a {
	color: black;
	text-decoration: none;
}

.btnbox1 {
	display: flex;
	flex-direction: row;
}

.btnbox1 h5 {
	padding-bottom: 20px;
}

.upBtn {
    margin-top: 20px; /* 버튼과 다른 요소 간격 */
    background-color: #FE8015;
    border: none;
    color: white;
    font-size: 16px;
    border-radius: 5px;
    transition: background-color 0.3s;
    padding: 10px 20px;
    display: block; /* 가운데 정렬을 위해 block으로 변경 */
    margin: 0 auto; /* 가운데 정렬 */
}

.ver-line {
	width: 0.5px;
	height: 150px;
	background-color: black;
	margin: 0 auto;
}

.locationBtn {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 45%;
}

.itemBtn {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 45%;
}


.notfind {
	margin: 50px auto 0;
	text-align: center;
	max-width: 800px;
}

.notfind table td, table th {
	border: solid 1px #ccc;
	border-collapse: collapse;
}

.notfind th {
	background-color: #FE8015;
}
.notfind tr:hover {
	background-color: #FFD5B2;
}
table {
    width: 100%;
}

.upbox {
    
}

</style>
</head>
<body>
	<%@include file="/WEB-INF/include/adminSide.jsp"%>
	<main>
		<div>
			<div id="topm">
				<a href="/">Home</a> &nbsp;&nbsp;>&nbsp;&nbsp; <a href="#">Mypage</a>
			</div>
			<div>
				<div class="profile-box">
					<div class="profile-header">
						<img src="/icon/user.png" alt="profile" />
						<div class="profile-info">
							<em class="nickname">${ user.nickname }</em> 
							<em class="join-date">가입일 : ${ user.com_date }</em>
						</div>
					</div>
					<hr />

					<div class="profile-details">
						<ul>
							<c:choose>
								<c:when test="${user.user_grant == 'ADMIN'}">
									<li><em>회원 등급 &nbsp;&nbsp;:&nbsp;&nbsp; 관 리 자</em></li>
								</c:when>
								<c:when test="${user.user_grant == 'USER'}">
									<li><em>회원 등급 &nbsp;&nbsp;:&nbsp;&nbsp; 본인인증 회원</em></li>
								</c:when>
								<c:when test="${user.user_grant == 'BAN'}">
									<li><em>회원 등급 &nbsp;&nbsp;:&nbsp;&nbsp; 블라인드 회원</em></li>
								</c:when>
							</c:choose>

							<li><em>방문 횟수 &nbsp;&nbsp;:&nbsp;&nbsp; ${ user.join_count }
									번</em></li>
							<li><em>내 게시글 &nbsp;&nbsp;:&nbsp;&nbsp; ${ count.count }
									개</em></li>
						</ul>
					</div>
				</div>
				<div>
					<div class="box1">
						<div class="lostitem-setbox">
							<h4 style="padding-bottom: 10px;">나의 분실물 정보 받기</h4>
								<h6>설정날짜 : ${ myfind.set_date }</h6>
							<hr>
							<div class="btnbox1">
								<div class="locationBtn">
									<h5>지역</h5>
									<c:choose>
										<c:when
											test="${ userlocation.location_code != null && userlocation.location_code != 0 }">
											<h6>${ userlocation.sido_name }</h6>
										</c:when>
										<c:when
											test="${ userlocation.location_code == null || userlocation.location_code == 0 }">
											<h6>선택없음</h6>
										</c:when>
									</c:choose>
									<select>
										<c:forEach items="${alllocation }" var="alocation">
											<c:choose>
												<c:when test="${ alocation.sido_name !=null &&  alocation.gugun_name == null }">
													<option value="${alocation.location_code}" }>
													${ alocation.sido_name }</option>
												</c:when>
											</c:choose>
										</c:forEach>
									</select>
								</div>
								<div class="ver-line"></div>
								<div class="itemBtn">
									<h5>물품</h5>
									<c:choose>
										<c:when test="${ useritem.item_code != null && useritem.item_code != 0 }">
											<h6>${useritem.item }</h6>
										</c:when>
										<c:when
											test="${ useritem.item_code == null || useritem.item_code == 0 }">
											<h6>선택없음</h6>
										</c:when>
									</c:choose>
									<select>
										<c:forEach items="${ allitem }" var="aitem">
											<option value="${aitem.item_code}"}>
											${ aitem.item }</option>
										</c:forEach>
									</select>
								</div>
							</div>
						
								<hr>
									<button class="upBtn">업데이트</button>
							
						</div>
						<section class="bedgebox">
							<!-- 뱃지 섹션 -->
							<div class="badge-container">
								<h2>내가 모은 뱃지</h2>
								<hr />
								<!-- 뱃지 리스트 -->
								<div class="badge-list">
									<!-- 뱃지 아이템 -->
									<div class="badge-item">
										<a href="#"><img src="/icon/11.png" alt="Badge 1"></a>
									</div>
									<div class="badge-item">
										<img src="/icon/12.png" alt="Badge 2">
									</div>
									<div class="badge-item">
										<img src="/icon/13.png" alt="Badge 3">
									</div>
									<div class="badge-item">
										<img src="/icon/14.png" alt="Badge 4">
									</div>
									<div class="badge-item">
										<img src="/icon/15.png" alt="Badge 5">
									</div>
									<div class="badge-item">
										<img src="/icon/16.png" alt="Badge 6">
									</div>
									<div class="badge-item">
										<img src="/icon/17.png" alt="Badge 7">
									</div>
									<div class="badge-item">
										<img src="/icon/18.png" alt="Badge 8">
									</div>
									<div class="badge-item">
										<img src="/icon/19.png" alt="Badge 9">
									</div>
									<div class="badge-item">
										<img src="/icon/20.png" alt="Badge 10">
									</div>
									<!-- 더보기 -->
								</div>
								<button id="loadMore" class="load-more">더보기</button>
							</div>
						</section>
					</div>
				</div>
				<div class="notfind">
					<div>
						<table>
							<colgroup>
								<col style="width: 10%;">
								<col style="width: 60%;">
								<col style="width: 20%;">
								<col style="width: 10%;">
							</colgroup>
							<thead>
								<tr>
									<th>순번</th>
									<th>제목</th>
									<th>등록일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<c:if test="${ empty notFind }">
								<tr>
									<th colspan="4">등록한 미완료 글이 없습니다.😁</th>
								</tr>
							</c:if>
							<c:if test="${ not empty notFind }">
								<c:forEach items="${notFind}" var="nf" varStatus="nstatus">
									<tr>
										<td><a href="#">${nstatus.index + 1}</a></td>
										<td><a href="#">${nf.title}</a></td>
										<td><a href="#">${nf.reg_date}</a></td>
										<td><a href="#">${nf.views}</a></td>
									</tr>
								</c:forEach>
							</c:if>
						</table>
					</div>

				</div>
			</div>
		</div>

	</main>
	
	<script>
	 document.addEventListener("DOMContentLoaded", function() {
         document.querySelector(".upBtn").addEventListener("click", function() {
             var locationCode = document.querySelector(".locationBtn select").value;
             var itemCode = document.querySelector(".itemBtn select").value;
             var mem_idx = "${user.mem_idx}"; // JSP에서 전달

             console.log("locationCode:", locationCode);
             console.log("itemCode:", itemCode);
             console.log("mem_idx:", mem_idx);

             var formData = new FormData();
             formData.append("location_code", locationCode);
             formData.append("item_code", itemCode);
             formData.append("mem_idx", mem_idx);

             // fetch를 사용하여 AJAX 요청 보내기
             fetch("/updateMyFind", {
                 method: "POST",
                 body: formData
             })
             .then(response => response.text())
             .then(response => {
                 if (response === "success") {
                     alert("정보가 업데이트되었습니다.");
                 } else if (response === "error") {
                     alert("업데이트에 실패했습니다.");
                 } else {
                     alert("권한이 없습니다.");
                 }
             })
             .catch(error => {
                 alert("서버 오류가 발생했습니다.");
                 console.error("Error:", error);
             });
         });
     });
	
	
	document.addEventListener("DOMContentLoaded", () => {
		const badgeList = document.querySelector(".badge-list");
		const badgeItems = badgeList.querySelector(".badge-item")
		const loadMoreButton = document.getElementById("loadMore");
		const itemsPerRow = 4;
		let expanded = false;

		if(badgeItems.length <= itemsPerRow) {
			loadMoreButton.style.display = "none";
		} else {
			loadMoreButton.style.display = "block";
		}
		
		loadMoreButton.addEventListener("click", () => {
			if(!expanded){
				badgeList.style.maxHeight = "none";
				loadMoreButton.textContent = "접기";
			} else {
				badgeList.style.maxHeight = "240px";
				loadMoreButton.textContent = "더보기";
			}
			expanded = !expanded;
		});
	});
	
</script>
</body>
</html>