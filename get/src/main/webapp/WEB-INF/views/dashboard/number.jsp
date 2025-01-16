<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>통계 수치 페이지</title>
    <link rel="icon" type="image/png" href="/img/favicon.ico" />
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            margin-left: 20%;
            padding: 20px;
            background-color: #ffe6cb;
        }
        h1 {
            color: #8C6C55;
            text-align: center;
            margin-top: 20px;
        }
        .summary-section, .regional-section {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
            margin: 40px auto;
            width: 80%;
        }
        .summary-card, .regional-card {
            background-color: #fff;
            border: 2px solid #8C6C55;
            border-radius: 10px;
            padding: 20px;
            width: 200px;
            text-align: center;
            box-shadow: 2px 2px 12px rgba(0,0,0,0.1);
        }
        .summary-card h3, .regional-card h3 {
            color: #8C6C55;
            margin-bottom: 10px;
        }
        .summary-card .count, .regional-card .count {
            font-size: 2em;
            color: #333;
        }
        .regional-section {
            margin-top: 60px;
        }
        .regional-section h2 {
            width: 100%;
            text-align: center;
            color: #8C6C55;
            margin-bottom: 20px;
        }
        .regional-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
        }
        .regional-item {
            background-color: #fff;
            border: 1px solid #8C6C55;
            border-radius: 8px;
            padding: 15px;
            width: 180px;
            text-align: center;
            box-shadow: 1px 1px 8px rgba(0,0,0,0.1);
        }
        .regional-item h4 {
            color: #8C6C55;
            margin-bottom: 8px;
            font-size: 1.1em;
        }
        .regional-item .count {
            font-size: 1.5em;
            color: #333;
        }
    </style>
</head>

<!-- 필요하다면 사이드 메뉴 등 include -->
<%@ include file="/WEB-INF/include/adminSide.jsp" %>

<body>
    <h1>통계 수치</h1>

    <!-- 통계 요약 섹션 -->
    <div class="summary-section">
        <div class="summary-card">
            <h3>총 유저수</h3>
            <div class="count" id="totalUserCount">0</div>
        </div>
        <div class="summary-card">
            <h3>정지당한 유저</h3>
            <div class="count" id="bannedUserCount">0</div>
        </div>
        <div class="summary-card">
            <h3>신고건수</h3>
            <div class="count" id="reportCount">0</div>
        </div>
        <div class="summary-card">
            <h3>성사된 채팅</h3>
            <div class="count" id="successfulChatCount">0</div>
        </div>
    </div>

    <!-- 지역별 통계 섹션 (습득물) -->
    <div class="regional-section">
        <h2>습득물 지역별 통계</h2>
        <div class="regional-list">
            <c:forEach var="region" items="${data.foundRegionStats}" varStatus="status">
                <div class="regional-item">
                    <h4>${region.regionName}</h4>
                    <div class="count" id="foundRegionCount${status.index}">0</div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 지역별 통계 섹션 (분실물) -->
    <div class="regional-section">
        <h2>분실물 지역별 통계</h2>
        <div class="regional-list">
            <c:forEach var="region" items="${data.lostRegionStats}" varStatus="status">
                <div class="regional-item">
                    <h4>${region.regionName}</h4>
                    <div class="count" id="lostRegionCount${status.index}">0</div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- (A) 데이터: 단순 숫자 세팅 (애니메이션 없이) -->
    <script>
        const data = {
            totalUserCount: ${empty data.totalUserCount ? 0 : data.totalUserCount},
            bannedUserCount: ${empty data.bannedUserCount ? 0 : data.bannedUserCount},
            reportCount: ${empty data.reportCount ? 0 : data.reportCount},
            successfulChatCount: ${empty data.successfulChatCount ? 0 : data.successfulChatCount},

            foundRegionStats: [
                <c:forEach var="region" items="${data.foundRegionStats}" varStatus="status">
                {
                    regionName: "${region.regionName}",
                    count: ${empty region.count ? 0 : region.count}
                }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ],
            lostRegionStats: [
                <c:forEach var="region" items="${data.lostRegionStats}" varStatus="status">
                {
                    regionName: "${region.regionName}",
                    count: ${empty region.count ? 0 : region.count}
                }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ]
        };

        // 디버깅: 콘솔 출력
        console.log("foundRegionStats:", data.foundRegionStats);
        console.log("lostRegionStats:", data.lostRegionStats);

        document.addEventListener('DOMContentLoaded', () => {
            // 상단 4개
            document.getElementById("totalUserCount").textContent = data.totalUserCount.toLocaleString();
            document.getElementById("bannedUserCount").textContent = data.bannedUserCount.toLocaleString();
            document.getElementById("reportCount").textContent = data.reportCount.toLocaleString();
            document.getElementById("successfulChatCount").textContent = data.successfulChatCount.toLocaleString();

            // 습득물 지역
            data.foundRegionStats.forEach((region, i) => {
                const el = document.getElementById(`foundRegionCount${i}`);
                if (!el) {
                    console.warn("NOT FOUND: #foundRegionCount" + i, region);
                } else {
                    el.textContent = region.count.toLocaleString();
                }
            });

            // 분실물 지역
            data.lostRegionStats.forEach((region, i) => {
                const el = document.getElementById(`lostRegionCount${i}`);
                if (!el) {
                    console.warn("NOT FOUND: #lostRegionCount" + i, region);
                } else {
                    el.textContent = region.count.toLocaleString();
                }
            });
        });
    </script>
</body>
</html>