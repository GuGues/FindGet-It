<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>대시보드</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="icon" type="image/png" href="/img/favicon.ico" />
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            margin-left: 20%;
            padding: 0;
            background-color: #ffe6cb;

        }
        main{ margin-left: 20%; }
        h1 {
            color: #8C6C55;
            text-align: center;
            margin-top: 20px;
        }
        .section {
            /*display: flex;*/
            /*justify-content: space-evenly;*/
            align-items: center;
            /*flex-wrap: wrap;*/
            margin: auto;
            border-radius: 15px;
            border: solid #ffe6cb  8px;
            background-color: white;
            /*align-content: center;*/
            /*max-width: 800px;*/
            width: 80%;
            justify-content: center;
            /*padding-left: 20%;*/
            /*padding-right: ;*/
        }
        .stats {
            display: inline-block;
            text-align: center;
            width: 45%;
            margin-bottom: auto;
        }
        .stats-content {
            display: flex;
            /*justify-content: space-between;*/
            align-items: flex-start;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        .region-stats {
            flex: 1;
            max-width: 100px;
            margin: 0;
            /*margin-right: 20px;*/
            text-align: left;
        }
        .region-stats ul {
            list-style: none;
            padding: 0;
        }
        .region-stats li {
            margin: 5px 0;
            font-size: 14px;
        }
        .chart-container {
            flex: 1;
            width: 100%;
            /*min-width: 200px;*/
            /*max-width: 800px;*/
            height: 100%;
            /*
            border-right: #8C6C55 solid 3px;
            */
        }
        @media (max-width: 900px) {

            .stats-content {
                flex-direction: column;
                align-items: center;
            }
            .region-stats {
                margin-right: 0;
                margin-bottom: 20px;
            }
        }



        /* 추가 스타일 */
        .section {
            /* 기존 스타일 */
            margin-bottom: 40px; /* 그래프 간 간격 추가 */
            /*padding: 5%;*/
            text-align: center;
            gap: 20px;


        }
        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
        }


    </style>
</head>
<%@include file="/WEB-INF/include/adminSide.jsp" %>
<body>
<main>
<!-- 습득물 통계 -->
    <!-- [추가] 습득물 월별 업로드 통계 -->
    <div class="section">
        <div class="stats">
            <h2>24년도 습득물 월별 업로드 통계</h2>
            <div class="chart-container">
                <canvas id="foundMonthlyChart"></canvas>
            </div>
        </div>


    <!-- [추가] 분실물 월별 업로드 통계 -->

        <div class="stats" style="margin-left: 5%;" >
            <h2>24년도 분실물 월별 업로드 통계</h2>
            <div class="chart-container">
                <canvas id="lostMonthlyChart"></canvas>
            </div>
        </div>
    </div>
<div class="section">
    <div class="stats">
        <h2>습득물 지역 통계</h2>
        <div class="stats-content">
            <div class="region-stats">
                <ul>
                    <c:forEach var="region" items="${data.foundRegionStats}">
                        <li>${region.regionName}: <strong>${region.count}</strong></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="chart-container">
                <canvas id="foundRegionChart"></canvas>
            </div>
        </div>
    </div>
    <div class="stats" style="margin-left: 5%;">
        <h2>분실물 지역 통계</h2>
        <div class="stats-content">
            <div class="region-stats">
                <ul>
                    <c:forEach var="region" items="${data.lostRegionStats}">
                        <li>${region.regionName}: <strong>${region.count}</strong></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="chart-container">
                <canvas id="lostRegionChart"></canvas>
            </div>
        </div>
    </div>
</div>

<!-- 분실물 통계 -->
<div class="section">
    <div class="stats">
        <h2>습득물 완료 통계</h2>
        <p>습득물 총: <strong><c:out value="${data.foundTotalCount}" /></strong>
        찾아준: <strong><c:out value="${data.foundFinishedCount}" /></strong>
        진행중: <strong><c:out value="${data.foundOngoingCount}" /></strong></p>
        <div class="chart-container">
            <canvas id="foundCompletionChart"></canvas>
        </div>
    </div>
    <div class="stats">
        <h2>분실물 완료 통계</h2>
        <p>분실물 총: <strong><c:out value="${data.lostTotalCount}" /></strong>
        찾은: <strong><c:out value="${data.lostFinishedCount}" /></strong>
        진행중: <strong><c:out value="${data.lostOngoingCount}" /></strong></p>
        <div class="chart-container">
            <canvas id="lostCompletionChart"></canvas>
        </div>
    </div>
</div>
</main>
</main>
<script>
    // JSON 데이터 디버깅용: 콘솔에서 확인 가능
    console.log("습득물 지역 데이터: ", [
        <c:forEach var="region" items="${data.foundRegionStats}" varStatus="status">
        {
            regionName: "<c:out value='${fn:escapeXml(region.regionName)}' />",
            count: ${region.count}
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ]);

    console.log("분실물 지역 데이터: ", [
        <c:forEach var="region" items="${data.lostRegionStats}" varStatus="status">
        {
            regionName: "<c:out value='${fn:escapeXml(region.regionName)}' />",
            count: ${region.count}
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ]);

    // 습득물 완료 통계 차트
    const foundCompletionCtx = document.getElementById('foundCompletionChart').getContext('2d');
    new Chart(foundCompletionCtx, {
        type: 'pie',
        data: {
            labels: ['찾아준', '진행중'],
            datasets: [{
                data: [
                    <c:out value="${data.foundFinishedCount}" />,
                    <c:out value="${data.foundOngoingCount}" />
                ],
                backgroundColor: ['#8C6C55', '#CDB7A1']
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false
        }
    });

    // 습득물 지역 통계 차트
    var foundRegionData = [
        <c:forEach var="region" items="${data.foundRegionStats}" varStatus="status">
        {
            regionName: "<c:out value='${fn:escapeXml(region.regionName)}' />",
            count: ${region.count}
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    console.log("습득물 지역 데이터: ", foundRegionData);
    if (foundRegionData.length > 0) {
        const foundRegionCtx = document.getElementById('foundRegionChart').getContext('2d');

        // Define similar tones with slight variations
        const foundRegionColors = [
            '#8C6C55',
            '#A67C65',
            '#B78C75',
            '#C89C85',
            '#D8AC95',
            '#E9BCC5',
            '#FADCD5'
        ];

        new Chart(foundRegionCtx, {
            type: 'bar',
            data: {
                labels: foundRegionData.map(item => item.regionName),
                datasets: [{
                    label: '습득물 지역별 통계',
                    data: foundRegionData.map(item => item.count),
                    backgroundColor: foundRegionData.map((item, index) => foundRegionColors[index % foundRegionColors.length])
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });
    } else {
        console.warn("습득물 지역 데이터가 비어있습니다.");
    }

    // 분실물 완료 통계 차트
    const lostCompletionCtx = document.getElementById('lostCompletionChart').getContext('2d');
    new Chart(lostCompletionCtx, {
        type: 'pie',
        data: {
            labels: ['찾은', '진행중'],
            datasets: [{
                data: [
                    <c:out value="${data.lostFinishedCount}" />,
                    <c:out value="${data.lostOngoingCount}" />
                ],
                backgroundColor: ['#8C6C55', '#CDB7A1']
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false
        }
    });

    // 분실물 지역 통계 차트
    var lostRegionData = [
        <c:forEach var="region" items="${data.lostRegionStats}" varStatus="status">
        {
            regionName: "<c:out value='${fn:escapeXml(region.regionName)}' />",
            count: ${region.count}
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    console.log("분실물 지역 데이터: ", lostRegionData);
    if (lostRegionData.length > 0) {
        const lostRegionCtx = document.getElementById('lostRegionChart').getContext('2d');

        // Define similar tones with slight variations
        const lostRegionColors = [
            '#8C6C55',
            '#A67C65',
            '#B78C75',
            '#C89C85',
            '#D8AC95',
            '#E9BCC5',
            '#FADCD5'
        ];

        new Chart(lostRegionCtx, {
            type: 'bar',
            data: {
                labels: lostRegionData.map(item => item.regionName),
                datasets: [{
                    label: '분실물 지역별 통계',
                    data: lostRegionData.map(item => item.count),
                    backgroundColor: lostRegionData.map((item, index) => lostRegionColors[index % lostRegionColors.length])
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });
    } else {
        console.warn("분실물 지역 데이터가 비어있습니다.");
    }

    // 습득물 월별 업로드 통계 데이터
    var foundMonthlyData = [
        <c:forEach var="stat" items="${data.foundMonthlyStats}" varStatus="status">
        {
            month: "<c:out value='${stat.month}' />",
            count: ${stat.count}
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    console.log("습득물 월별 데이터: ", foundMonthlyData);

    const foundMonthlyCtx = document.getElementById('foundMonthlyChart').getContext('2d');
    const foundMonthlyLabels = foundMonthlyData.map(item => item.month);
    const foundMonthlyCounts = foundMonthlyData.map(item => item.count);

    new Chart(foundMonthlyCtx, {
        type: 'line',
        data: {
            labels: foundMonthlyLabels,
            datasets: [{
                label: '습득물 월별 업로드',
                data: foundMonthlyCounts,
                fill: false,
                borderColor: '#8C6C55',
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: { beginAtZero: true }
            }
        }
    });

    // 분실물 월별 업로드 통계 데이터
    var lostMonthlyData = [
        <c:forEach var="stat" items="${data.lostMonthlyStats}" varStatus="status">
        {
            month: "<c:out value='${stat.month}' />",
            count: ${stat.count}
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    console.log("분실물 월별 데이터: ", lostMonthlyData);

    const lostMonthlyCtx = document.getElementById('lostMonthlyChart').getContext('2d');
    const lostMonthlyLabels = lostMonthlyData.map(item => item.month);
    const lostMonthlyCounts = lostMonthlyData.map(item => item.count);

    new Chart(lostMonthlyCtx, {
        type: 'line',
        data: {
            labels: lostMonthlyLabels,
            datasets: [{
                label: '분실물 월별 업로드',
                data: lostMonthlyCounts,
                fill: false,
                borderColor: '#CDB7A1',
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
</script>
</body>
</html>