<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Floating Action Button</title>
<style>
/* 전체 페이지 스타일 */
body {
	margin: 0; /* 페이지의 여백을 0으로 설정 */
	padding: 0; /* 페이지의 패딩을 0으로 설정 */
	font-family: Arial, sans-serif; /* 글꼴 설정 */
}

/* FAB (Floating Action Button) 스타일 */
.fab-container {
	position: fixed; /* 페이지의 고정 위치 */
	bottom: 20px; /* 화면 아래쪽에서 20px 위치 */
	right: 20px; /* 화면 오른쪽에서 20px 위치 */
}

.fab {
    border: solid 2px #FE8015;
	width: 60px; /* 버튼의 너비 */
	height: 60px; /* 버튼의 높이 */
	background-color: rgba(255, 255, 255, 0.2); /* 버튼의 배경색 (어두운 회색) */
	color: #FE8015; /* 버튼 텍스트 색 (흰색) */
	font-size: 30px; /* 텍스트 크기 */
	text-align: center; /* 텍스트 수평 정렬 */
	line-height: 60px; /* 텍스트 수직 정렬 (버튼 가운데 배치) */
	border-radius: 50%; /* 원 모양 버튼 만들기 */
	cursor: pointer; /* 마우스를 올리면 클릭 가능한 커서로 변경 */
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.3); /* 그림자 효과 */
	transition: transform 0.3s; /* 0.3초 동안 변환 효과 적용 */
}

/* FAB 버튼에 마우스를 올렸을 때 */
.fab:hover {
	background-color: #FE8015; /* 배경색을 주황색으로 변경 */
	color: white;
	transform: scale(1.2); /* 버튼 크기를 1.2배 확대 */
}

/* FAB 옵션 버튼들을 담는 컨테이너 */
.fab-options {
	display: none; /* 처음에는 옵션 메뉴 숨김 */
	position: absolute; /* 메뉴 위치를 절대값으로 설정 */
	bottom: 70px; /* FAB 버튼 위에 배치 (70px 아래쪽) */
	right: 0; /* FAB 버튼과 같은 오른쪽 정렬 */
}

/* 각 옵션 버튼 스타일 */
.fab-option {
    border: solid 2px #FE8015;
	width: 50px; /* 옵션 버튼 너비 */
	height: 50px; /* 옵션 버튼 높이 */
	background-color: rgba(255, 255, 255, 0.2); /* 주황색 배경 */
	color: #FE8015; /* 텍스트 색은 검정 */
	text-align: center; /* 텍스트 수평 정렬 */
	line-height: 50px; /* 텍스트 수직 정렬 */
	border-radius: 50%; /* 원 모양 옵션 버튼 */
	margin-bottom: 10px; /* 버튼 간 간격 설정 */
	cursor: pointer; /* 클릭 가능한 커서 */
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.3); /* 그림자 효과 */
	transition: transform 0.2s; /* 변환 효과 시간 설정 */
}

/* 옵션 버튼에 마우스를 올렸을 때 */
.fab-option:hover {
color: white;
background-color: #FE8015; /* 배경색을 주황색으로 변경 */
	transform: scale(1.1); /* 마우스를 올리면 1.1배 확대 */
}

/* 링크 기본 스타일 없애기 */
a {
	text-decoration: none; /* 링크의 밑줄 제거 */
}
</style>
</head>
<body>

	<div class="fab-container">
		<!-- 메인 Floating Action Button (버튼의 텍스트는 '...') -->
		<div class="fab" id="main-fab">&middot;&middot;&middot;</div>

		<!-- 확장 옵션 버튼들 -->
		<div class="fab-options" id="fab-options">
			<!-- 각 옵션 버튼 -->
			<a class="fab-option" href="#">
			<img src="your-image.jpg" alt="Example Image" width="100" height="100">
			</a>
			<a class="fab-option" href="#">
			<img src="your-image.jpg" alt="Example Image" width="100" height="100">
			</a>
			<a class="fab-option" href="#">
			<img src="your-image.jpg" alt="Example Image" width="100" height="100">
			</a>
			<a class="fab-option" href="#">Top</a>
		</div>
	</div>

	<script>
    // FAB 버튼을 클릭하면 확장/축소 메뉴를 토글하는 기능
    const mainFab = document.getElementById("main-fab"); // 메인 FAB 버튼
    const fabOptions = document.getElementById("fab-options"); // 옵션 메뉴

    // FAB 버튼에 마우스를 올리면 메뉴를 보이도록 설정
    mainFab.addEventListener("mouseover", () => {
        if (fabOptions.style.display === "flex") {  // 메뉴가 이미 열려있다면
            fabOptions.style.display = "none";     // 메뉴를 숨김
        } else {
            fabOptions.style.display = "flex";     // 메뉴를 보여줌
            fabOptions.style.flexDirection = "column"; // 메뉴 옵션을 세로로 배치
        }
    });
</script>

</body>
</html>
