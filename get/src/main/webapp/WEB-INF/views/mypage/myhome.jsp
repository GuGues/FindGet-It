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
	padding: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
}

/* 뱃지 섹션 스타일 */
.badge-container {
	background-color: #2a2a3b; /* 섹션 배경 */
	border-radius: 10px; /* 모서리를 둥글게 */
	padding: 20px;
	max-width: 600px;
	text-align: center;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
}

/* 제목 스타일 */
.badge-container h2 {
	margin-bottom: 20px;
	font-size: 24px;
	color: #ffdd57; /* 눈에 띄는 노란색 */
}

/* 뱃지 리스트 스타일 */
.badge-list {
	display: flex;
	flex-wrap: wrap; /* 여러 줄로 자동 정렬 */
	justify-content: center;
	gap: 20px; /* 뱃지 간격 */
}

/* 뱃지 아이템 스타일 */
.badge-item {
	width: 100px;
	height: 100px;
	background-color: #444; /* 뱃지 배경 */
	border-radius: 8px;
	display: flex;
	justify-content: center;
	align-items: center;
	overflow: hidden; /* 이미지가 영역을 벗어나지 않도록 */
	border: 2px solid #555; /* 뱃지 테두리 */
	transition: transform 0.3s, border-color 0.3s; /* 호버 효과 애니메이션 */
}

/* 뱃지 이미지 스타일 */
.badge-item img {
	width: 90%; /* 이미지를 뱃지 안에 맞게 크기 조정 */
	height: auto;
}

/* 뱃지 호버 효과 */
.badge-item:hover {
	transform: scale(1.1); /* 뱃지를 확대 */
	border-color: #ffdd57; /* 테두리 색상 변경 */
}

.lostitem-setbox {
    padding: 20px;
	border: 1px solid gray;
}

/* 프로필 박스 전체 */
.profile-box {
    width: 400px;
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

/* 구분선 */
hr {
    border: none;
    border-top: 1px solid #ddd;
    margin: 20px 0;
}

/* 상세 정보 */
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
}.modal {
	display: none;
	justify-content: center;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.3);
	z-index: 3;
}

.modal_content {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 700px;
	height: 800px;
	transform: translate(-50%, -50%);
	padding: 40px;
	text-align: center;
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/include/adminSide.jsp"%>
	<main>
		<div>
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
            <li><em>회원 등급 : 본인인증 회원</em></li>
            <li><em>방문 횟수 : ${ user.join_count } 번</em></li>
            <li><em>내 게시글 : ${ user.write_count } 개</em></li>
        </ul>
    </div>
</div>
				<div>
					<div class="lostitem-setbox">
						<h4>잃어버린 물품 등록</h4>
						<div class="modal">
							<div class="modal_content">
								<h3>지역을 선택해 주세요.</h3>
								<div class="location_button">
									<div>
										<ul style="display: flex; flex-wrap: wrap; gap: 10px;">
											<!-- Sido 버튼 생성 -->
											<li><button class="swap-button" data-target="pass_table">전국</button></li>
											<c:forEach items="${alllocation}" var="allL"
												varStatus="status">
												<li>
													<button class="swap-button"
														data-target="gugun_group_${allL.location_code}">${allL.sido_name}</button>
												</li>
											</c:forEach>
										</ul>
									</div>
									<hr />
									<!-- Gugun 버튼 그룹 생성 -->
									<c:forEach items="${alllcation}" var="allL">
										<div id="gugun_group_${allL.location_code}"
											class="gugun-group">
											<ul style="display: flex; gap: 10px; flex-wrap: wrap;">
												<li><button class="filter-button active"
														data-target="pass_table_${allL.loacation_code}_all">전체</button></li>
												<c:forEach items="${alllocation}" var="gugun">
													<c:if test="${gugun.location_code == allL.location_code}">
														<li>
															<button class="filter-button"
																data-target="pass_table_${allL.location_code}_${gugun.location_code}">${gugun.gugun_name}</button>
														</li>
													</c:if>
												</c:forEach>
											</ul>
										</div>
									</c:forEach>
								</div>

							</div>
							<!-- 뱃지 섹션 -->
							<div class="badge-container">
								<h2>My Badge Collection</h2>
								<!-- 뱃지 리스트 -->
								<div class="badge-list">
									<!-- 뱃지 아이템 -->
									<!-- <div class="badge-item">
										<img src="badge1.png" alt="Badge 1">
									</div>
									<div class="badge-item">
										<img src="badge2.png" alt="Badge 2">
									</div>
									<div class="badge-item">
										<img src="badge3.png" alt="Badge 3">
									</div>
									<div class="badge-item">
										<img src="badge4.png" alt="Badge 4">
									</div>
									<div class="badge-item">
										<img src="badge5.png" alt="Badge 5">
									</div>
									<div class="badge-item">
										<img src="badge6.png" alt="Badge 6"> -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>

	</main>
	<script>
const modal = document.querySelector('.modal');
//모달 닫기 버튼
const closeBtn = document.querySelector('.closeBtn')
closeBtn.addEventListener('click', function(){
	modal.style.display = 'none';
});


//멤버클릭시
const memberTable = document.querySelector('.lostitem-setbox');
memberTable.addEventListener('click', function(e){
	//console.log(e.target.parentNode);
	if(e.target.parentNode.classList == 'memberTr'){
		modal.style.display = 'block';
		const reports = document.querySelector('.reports');
		fetch('/admin/post?resiver_idx='+e.target.parentNode.id, {
			method : 'POST',
			headers: { 'Content-Type': 'application/json' },
		})
		.then(result => result.json())
		.then(map => {
			//신고받은 게시글
			console.log(map);
			const resive = document.querySelector('.resive');
			let resiveHTML;
			if(map.found){
				let found = map.found; 
				resiveHTML = '제목 : ' + found.foundTitle + '<br>'
				           + '내용 : ' + found.foundContent + '<br>';
				
			}
			else if(map.lost){
				let lost = map.lost; 
				resiveHTML = '제목:' + lost.lostTitle + '<br>'
				           + '내용 : ' + lost.lostContent + '<br>'
				           + '사례금 : '+ lost.reward;
			}
			resive.innerHTML = resiveHTML;

			//신고목록
			let report = map.reports;
			let reporHTML = '<colgroup><col style="width: 10%;"><col style="width: 45%;"><col style="width: 25%;"><col style="width: 20%;"></colgroup>' 
				+'<tr><td>순번</td><td>신고내용</td><td>신고자</td><td>신고시간</td></tr>';
			for(let i = 0; i < report.length; i++){
				reporHTML+='<tr class="report">'
			        + '<td>'+(i+1)+'</td>'
			        + '<td>'+report[i].r_content+'</td>'
			        + '<td>'+report[i].reporter_idx+'</td>'
			        + '<td>'+report[i].r_reg_date+'</td>'
			      +'</tr>';
			  reports.innerHTML = reporHTML;
			}
			

	    	const aBtn = document.querySelector('.aBtn');
	        aBtn.addEventListener('click', function(){
	        	console.log(e.target.parentNode.id);
	        	window.location.href = "";
	        });
		});
	};
});

			
</script>
</body>
</html>