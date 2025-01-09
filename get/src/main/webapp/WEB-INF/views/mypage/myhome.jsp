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
    overflow:hidden;
    margin-top: 50px;
	background-color: white; /* 섹션 배경 */
	border-radius: 10px; /* 모서리를 둥글게 */
	padding: 20px;
	max-width: 600px;
	text-align: center;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
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
	max-height: 240px; /*2줄만 보이게*/
	overflow: hidden;
	transition: max-height 0.3s ease-in-out;
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
	border: 2px solid white; /* 뱃지 테두리 */
	transition: transform 0.3s, border-color 0.3s; /* 호버 효과 애니메이션 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
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
.load-more {
    display: block;
    margin-top: 20px;
    background-color: #ffdd57;
    border: none;
    color: white;
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 5px;
    cursor: e-resize;
    transition: background-color 0.3s;
}
.load-more:hidden {
    display: none;
}
.load-more:hover {
    background-color: #f4c842;
}
.lostitem-setbox {
	width: 400px;
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


/* 모달 전체 배경 */
.modal {
    position: fixed; /* 화면에 고정 */
    top: 0;
    left: 0;
    width: 50%;
    height: 50%;
    transform: translate(50%, 50%);
    background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
    display: flex; /* Flexbox 사용 */
    justify-content: center; /* 가로 중앙 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    z-index: 1000; /* 다른 요소 위에 표시 */
}

/* 모달 내용 */
.modal-content {
    height: 100%;
    width: 100%; /* 모달의 너비 */
    padding: 20px;
    background-color: white;
    border-radius: 8px; /* 모서리를 둥글게 */
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    text-align: center;
}

.modal-content button {
	display: block;
	width: 50%;
	margin: 10px 0;
	padding: 10px;
	background-color: #007bff;
	color: white;
	border: none;
	cursor: pointer;
}

.modal-content button:hover {
	background-color: #0056b3;
}

.modal-content #closeModalBtn {
	background-color: #6c757d;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/include/side.jsp"%>
	<main>
		<div>
			<div>
				<div class="profile-box">
					<div class="profile-header">
						<img src="/icon/user.png" alt="profile" />
						<div class="profile-info">
							<em class="nickname">${ user.nickname }</em> <em
								class="join-date">가입일 : ${ user.com_date }</em>
						</div>
					</div>
					<hr />
					<div class="profile-details">
						<ul>
							<c:choose>
								<c:when test="${user.user_grant == 'ADMIN'}">
									<li><em>회원 등급 : 관리자</em></li>
								</c:when>
								<c:when test="${user.user_grant == 'USER'}">
									<li><em>회원 등급 : 본인인증 회원</em></li>
								</c:when>
								<c:when test="${user.user_grant == 'BAN'}">
									<li><em>회원 등급 : 블라인드 회원</em></li>
								</c:when>
							</c:choose>

							<li><em>방문 횟수 : ${ user.join_count } 번</em></li>
							<li><em>내 게시글 : ${ count.count } 개</em></li>
						</ul>
					</div>
				</div>
				<div>
					<div class="lostitem-setbox">
						<h4>잃어버린 물품 등록</h4>
						<!-- 모달 -->
						<div class="modal" id="selectionModal" style="display: none;">
							<div class="modal-content">
								<h4>항목 선택</h4>
								<button id="selectRegionBtn">지역 선택</button>
								<button id="selectItemBtn">물품 선택</button>
								<div id="selectionOutput"></div>
								<button id="saveSelectionBtn">저장</button>
								<button id="closeModalBtn">닫기</button>
							</div>
						</div>
						<button id="openModalBtn">지역 및 물품 선택</button>
					</div>
					<section class="bedgebox">
					<!-- 뱃지 섹션 -->
					<div class="badge-container">
						<h2>My Badge Collection</h2>
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
		</div>

	</main>
	<script>
	document.addEventListener("DOMContentLoaded", function () {
	    const modal = document.getElementById("selectionModal");
	    const openModalBtn = document.getElementById("openModalBtn");
	    const closeModalBtn = document.getElementById("closeModalBtn");
	    const selectRegionBtn = document.getElementById("selectRegionBtn");
	    const selectItemBtn = document.getElementById("selectItemBtn");
	    const saveSelectionBtn = document.getElementById("saveSelectionBtn");
	    const selectionOutput = document.getElementById("selectionOutput");

	    let selectedRegion = null;
	    let selectedItem = null;

	    // 모달 열기
	    openModalBtn.addEventListener("click", function () {
	        modal.style.display = "block";
	    });

	    // 모달 닫기
	    closeModalBtn.addEventListener("click", function () {
	        modal.style.display = "none";
	    });

	    // 지역 선택
	    selectRegionBtn.addEventListener("click", function () {
	        fetch("/getRegions")
	            .then(response => response.json())
	            .then(data => {
	                selectionOutput.innerHTML = data.map(region => 
	                    `<button class="regionBtn" data-id="${region.id}">${region.name}</button>`
	                ).join("");
	                
	                document.querySelectorAll(".regionBtn").forEach(button => {
	                    button.addEventListener("click", function () {
	                        selectedRegion = button.dataset.id;
	                        alert("선택한 지역: " + button.innerText);
	                    });
	                });
	            });
	    });

	    // 물품 선택
	    selectItemBtn.addEventListener("click", function () {
	        fetch("/getItems")
	            .then(response => response.json())
	            .then(data => {
	                selectionOutput.innerHTML = data.map(item => 
	                    `<button class="itemBtn" data-id="${item.id}">${item.name}</button>`
	                ).join("");

	                document.querySelectorAll(".itemBtn").forEach(button => {
	                    button.addEventListener("click", function () {
	                        selectedItem = button.dataset.id;
	                        alert("선택한 물품: " + button.innerText);
	                    });
	                });
	            });
	    });

	    // 선택 저장
	    saveSelectionBtn.addEventListener("click", function () {
	        if (!selectedRegion || !selectedItem) {
	            alert("지역과 물품을 모두 선택해주세요.");
	            return;
	        }

	        fetch("/saveLostItem", {
	            method: "POST",
	            headers: { "Content-Type": "application/json" },
	            body: JSON.stringify({
	                regionId: selectedRegion,
	                itemId: selectedItem
	            })
	        })
	            .then(response => response.text())
	            .then(message => {
	                alert(message);
	                modal.style.display = "none";
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