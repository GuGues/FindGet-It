<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>습득물 상세 페이지</title>
  <link rel="stylesheet" href="/css/common.css" />
  <link rel="icon" type="image/png" href="/img/favicon.ico" />
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #ffffff;
      margin-left: 25%;
      padding: 0;
    }

    .detail-container {
      max-width: 1000px;
      height: 100%;
      margin-left: 30%;
      margin-right: 10%;
      background: #fff;
      border: none;
      padding: 20px;
    }

    .detail-header {
      text-align: left;
      margin-bottom: 5%;
      border-bottom: solid #FF914B;
    }

    .detail-header h1 {
      font-size: 28px;
      color: #333;
    }

    .info-section {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 20px;
    }

    .image-container {
      flex: 1;
      text-align: center;
      margin-right: 20px;
    }

    .image-container img {
      max-width: 100%;
      height: auto;
      border-radius: 8px;
      border: 1px solid #ddd;
    }

    .image-container .no-image {
      font-size: 14px;
      color: #777;
      margin-top: 10px;
    }

    .info-content {
      flex: 2;
    }

    .info-content .info {
      margin-bottom: 10px;
    }

    .info-content .label {
      font-weight: bold;
      display: inline-block;
      width: 120px;
    }

    .btn-container {
      text-align: right;
      margin: 20px 0;
    }
    .btn-container button {
      background-color: #FF914B;
      color: white;
      border: none;
      padding: 10px 20px;
      font-size: 16px;
      cursor: pointer;
      margin: 0 5px;
      transition: background-color 0.3s;
    }
    .btn-container button:hover {
      background-color: #E87A2E;
    }

    /* 하단 버튼(목록/수정/블라인드/신고)을 모두 한 줄에 배치 */
    .btn-container2 {
      text-align: center;
      margin: 20px 0;
    }
    .btn-container2 > * {
      display: inline-block; /* 버튼이나 폼을 인라인 블록으로 */
      margin: 0 5px;
      vertical-align: middle;
    }
    .btn-container2 button {
      background-color: #FF914B;
      color: white;
      border: none;
      padding: 10px 20px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .btn-container2 button:hover {
      background-color: #E87A2E;
    }

    .content {
      padding-top: 20px;
      text-align: left;
      height: 150px;
    }

    .content-container {
      text-align: center;
      border-top: solid #FF914B;
      border-bottom: solid #FF914B;
    }

    .map-section {
      margin-top: 30px;
      text-align: left;
    }

    .map-section img {
      width: 100%;
      max-width: 800px;
      border: 1px solid #ccc;
      border-radius: 8px;
    }

    .top-label {
      text-align: right;
    }

    .modal-overlay {
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background: rgba(0, 0, 0, 0.6);
      display: none; /* 초기 상태는 숨김 */
      justify-content: center;
      align-items: center;
      z-index: 1000;
    }
    .modal-content2 {
      background: white;
      padding: 20px;
      border-radius: 8px;
      max-width: 500px;
      width: 90%;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
      text-align: left;
    }

    /* ADMIN 전용 테마: 버튼/테두리색을 #8C6C55로 변경 */
    <c:if test="${ sessionScope.grant eq 'ADMIN' }">
      .detail-header {
        border-bottom: solid #8C6C55 !important;
      }
      .btn-container button {
        background-color: #8C6C55 !important;
      }
      .btn-container button:hover {
        background-color: #684F36 !important;
      }
      .btn-container2 button {
        background-color: #8C6C55 !important;
      }
      .btn-container2 button:hover {
        background-color: #684F36 !important;
      }
      .content-container {
        border-top: solid #8C6C55 !important;
        border-bottom: solid #8C6C55 !important;
      }
    </c:if>

    /*---------------------지도 영역--------------------------*/
    .map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
    .map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
    .map_wrap {position:relative;width:100%;height:500px;}
    #menu_wrap {
      position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;
      padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);
      z-index: 1;font-size:12px;border-radius: 10px; display: none; /* 검색 메뉴 숨김 */
    }
    .bg_white {background:#fff;}
    #menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
    #menu_wrap .option{text-align: center;}
    #menu_wrap .option p {margin:10px 0;}
    #menu_wrap .option button {margin-left:5px;}
    #placesList li {list-style: none;}
    #placesList .item {
      position:relative;border-bottom:1px solid #888;overflow: hidden;
      cursor: pointer;min-height: 65px;
    }
    #placesList .item span {display: block;margin-top:4px;}
    #placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
    #placesList .item .info{padding:10px 0 10px 55px;}
    #placesList .info .gray {color:#8a8a8a;}
    #placesList .info .jibun {
      padding-left:26px;
      background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;
    }
    #placesList .info .tel {color:#009900;}
    #placesList .item .markerbg {
      float:left;position:absolute;width:36px; height:37px;
      margin:10px 0 0 10px;
      background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;
    }
    #placesList .item .marker_1 {background-position: 0 -10px;}
    #placesList .item .marker_2 {background-position: 0 -56px;}
    #placesList .item .marker_3 {background-position: 0 -102px}
    #placesList .item .marker_4 {background-position: 0 -148px;}
    #placesList .item .marker_5 {background-position: 0 -194px;}
    #placesList .item .marker_6 {background-position: 0 -240px;}
    #placesList .item .marker_7 {background-position: 0 -286px;}
    #placesList .item .marker_8 {background-position: 0 -332px;}
    #placesList .item .marker_9 {background-position: 0 -378px;}
    #placesList .item .marker_10 {background-position: 0 -423px;}
    #placesList .item .marker_11 {background-position: 0 -470px;}
    #placesList .item .marker_12 {background-position: 0 -516px;}
    #placesList .item .marker_13 {background-position: 0 -562px;}
    #placesList .item .marker_14 {background-position: 0 -608px;}
    #placesList .item .marker_15 {background-position: 0 -654px;}
    #pagination {margin:10px auto;text-align: center;}
    #pagination a {display:inline-block;margin-right:10px;}
    #pagination .on {font-weight: bold; cursor: default;color:#777;}
    a{ color: black; }
  </style>
</head>
<body>
<!-- 사이드메뉴 조건 분기 -->
<c:choose>
    <c:when test="${ sessionScope.grant eq 'ADMIN' }">
      <%@include file="/WEB-INF/include/adminSide.jsp" %>
    </c:when>
    <c:otherwise>
      <%@include file="/WEB-INF/include/side.jsp" %>
    </c:otherwise>
</c:choose>

<div class="detail-container">
  <div class="top-label">
    <h5>
      <a href="/">home</a> >
      <a href="/found">습득물</a>>
      <a href="#">습득물 상세보기</a>
    </h5>
  </div>

  <div class="detail-header">
    <h1 class="title">습득물 상세보기</h1>
    <div class="detail-header-inside">
      <h4>분실하신 물건 여부를 확인하시고,<br>
      본인의 물건이 맞다면 관할기관 신고나 채팅으로 연락 부탁드립니다.</h4>
    </div>
  </div>

  <div class="info-section">
    <!-- 이미지 섹션 -->
    <div class="image-container">
      <c:if test="${ not empty filePath }">
        <img src="<spring:url value='${ severUrl }imgView?filePath=${ filePath }'/>" alt="이미지가 없습니다" />
      </c:if>
      <c:if test="${ empty filePath }">
        <img src="/img/noimg.png" alt="이미지가 없습니다" />
      </c:if>
      <div class="no-image"></div>
    </div>

    <!-- 상세 정보 섹션 -->
    <div class="info-content">
      <div class="info">
        <span class="label">작성자 닉네임:</span>
        <c:out value="${item.nickname}" />
      </div>
      <div class="info">
        <span class="label">관리번호:</span>
        <c:out value="${item.foundIdx}"/>
      </div>
      <div class="info">
        <span class="label">습득일:</span>
        <c:out value="${item.foundDate}"/>
      </div>
      <div class="info">
        <span class="label">물품분류:</span>
        <c:out value="${item.itemName}"/>
      </div>
      <div class="info">
        <span class="label">물품색상:</span>
        <c:out value="${item.colorName}"/>
      </div>
      <div class="info">
        <span class="label">지역:</span>
        <c:out value="${item.sidoName}" /> <c:out value="${item.gugunName}" />
      </div>
      <div class="info">
        <span class="label">물품상태:</span>
        <c:out value="${item.itemState}" />
      </div>
    </div>
  </div>

  <!-- 버튼 영역 -->
  <div class="btn-container">
    <button type="button" onclick="openChat()">1대1 채팅 보내기</button>
    <button type="button" onclick="scrollToMap()">지도에 습득위치 보기</button>
  </div>

  <!-- 본문 영역 -->
  <div class="content-container">
    <div class="content">
      <c:out value="${item.foundContent}"/>
    </div>

    <!-- 버튼영역: 목록/수정/블라인드/신고 모두 한 줄 -->
    <div class="btn-container2">
      <!-- 목록 버튼 -->
      <button onclick="location.href='/found'">목록</button>

      <!-- 작성자인 경우: 수정 버튼 -->
      <c:if test="${loginEmail eq item.email}">
        <button onclick="location.href='/found/update?foundIdx=${item.foundIdx}'">수정</button>
      </c:if>

      <!-- 관리자(ADMIN)인 경우: 블라인드 버튼 -->
      <c:if test="${sessionScope.grant eq 'ADMIN'}">
        <form class="form" method="post" style="display:inline-block;">
          <input type="hidden" name="resiver_idx" value="${item.foundIdx}" />
          <input type="hidden" name="foundState" value="${item.foundState}">
          <button type="button" class="banBtn">블라인드</button>
        </form>
      </c:if>

      <!-- 작성자가 아니고, 관리자도 아닌 경우: 신고 버튼 -->
      <c:if test="${loginEmail ne item.email && sessionScope.grant ne 'ADMIN'}">
        <button type="button" onclick="openReportModal()">신고하기</button>
      </c:if>
    </div>
  </div>


  <!-- 지도 섹션 -->
  <div class="map-section" id="mapSection">
    <div class="map_wrap">
      <!-- 지도 표시 영역 -->
      <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

      <!-- 검색 메뉴 숨김 처리 -->
      <div id="menu_wrap" class="bg_white" style="display: none;">
          <hr />
          <ul id="placesList"></ul>
          <div id="pagination"></div>
      </div>
    </div>
  </div>

</div>

<!-- 카카오 맵 API 스크립트 포함 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a38a546a4aaada7aec2c459d8d1d085a&libraries=services"></script>
<script>
  // [1] 지도 영역으로 스크롤
  function scrollToMap(){
    const mapSection = document.getElementById('mapSection');
    mapSection.scrollIntoView({ behavior: 'smooth' });
  }

  // 1) 채팅 열기(모달 or 새창 등)
  function openChat() {
    var modal = document.getElementById('modal');
    var iframe = document.getElementById('modal-iframe');
    // item.email은 습득물 작성자의 이메일
    iframe.src = '/chatting/room/open/${item.email}';
    modal.style.display = 'block';
  }

  // [2] 블라인드 폼 submit
  const banBtn = document.querySelector('.banBtn');
  if (banBtn) {
      banBtn.addEventListener('click', function() {
          const form = document.querySelector('.form');
          if (form) {
              form.action = "/admin/post/ban";
              form.submit();
          }
      });
  }

  // [3] 신고 모달 열기/닫기
  function openReportModal() {
    document.getElementById("reportModalOverlay").style.display = "flex";
  }
  function closeReportModal() {
    document.getElementById("reportModalOverlay").style.display = "none";
  }

  // 신고 폼 처리
  const reportForm = document.getElementById("reportForm");
  if(reportForm) {
    reportForm.addEventListener("submit", function(e) {
      e.preventDefault();
      const formData = new FormData(reportForm);
      fetch("/report/submit", {
        method: "POST",
        body: formData
      })
      .then(response => {
        if (!response.ok) {
          throw new Error("신고 접수 중 오류가 발생했습니다.");
        }
        return response.text();
      })
      .then(data => {
        alert("신고가 접수되었습니다.");
        closeReportModal();
        location.reload();
      })
      .catch(err => {
        alert(err.message);
      });
    });
  }
</script>

<!-- 실제 맵 로직 -->
<script>
  // 마커를 담을 배열
  var markers = [];
  var mapContainer = document.getElementById('map'), // 지도를 표시할 div
      mapOption = {
          center: new kakao.maps.LatLng(37.566826, 126.9786567),
          level: 3
      };
  var map = new kakao.maps.Map(mapContainer, mapOption);

  // 장소 검색 객체를 생성
  var ps = new kakao.maps.services.Places();
  // 검색 결과 목록이나 마커 클릭 시 장소명 표시할 인포윈도우
  var infowindow = new kakao.maps.InfoWindow({zIndex:1});

  // JSP에서 전달된 지역 상세정보
  var keyword = "<c:out value='${item.fLocationDetail}'/>";
  searchPlaces();

  function searchPlaces() {
      if (!keyword.trim()) {
          return;
      }
      ps.keywordSearch(keyword, placesSearchCB);
  }

  function placesSearchCB(data, status, pagination) {
      if (status === kakao.maps.services.Status.OK) {
          displayPlaces(data);
          displayPagination(pagination);
      } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
          console.warn('지도 정보가 없습니다.');
      } else if (status === kakao.maps.services.Status.ERROR) {
          console.error('검색 오류 발생');
      }
  }

  function displayPlaces(places) {
      var listEl = document.getElementById('placesList'),
          menuEl = document.getElementById('menu_wrap'),
          fragment = document.createDocumentFragment(),
          bounds = new kakao.maps.LatLngBounds();

      removeAllChildNods(listEl);
      removeMarker();

      for ( var i=0; i<places.length; i++ ) {
          var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
              marker = addMarker(placePosition, i),
              itemEl = getListItem(i, places[i]);

          bounds.extend(placePosition);

          (function(marker, title) {
              kakao.maps.event.addListener(marker, 'mouseover', function() {
                  displayInfowindow(marker, title);
              });
              kakao.maps.event.addListener(marker, 'mouseout', function() {
                  infowindow.close();
              });
              itemEl.onmouseover =  function () {
                  displayInfowindow(marker, title);
              };
              itemEl.onmouseout =  function () {
                  infowindow.close();
              };
          })(marker, places[i].place_name);

          fragment.appendChild(itemEl);
      }
      listEl.appendChild(fragment);
      menuEl.scrollTop = 0;
      map.setBounds(bounds);
  }

  function getListItem(index, places) {
      var el = document.createElement('li'),
      itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

      if (places.road_address_name) {
          itemStr += '    <span>' + places.road_address_name + '</span>' +
                      '   <span class="jibun gray">' + places.address_name  + '</span>';
      } else {
          itemStr += '    <span>' + places.address_name  + '</span>';
      }
      itemStr += '  <span class="tel">' + places.phone  + '</span></div>';

      el.innerHTML = itemStr;
      el.className = 'item';
      return el;
  }

  function addMarker(position, idx) {
      var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png',
          imageSize = new kakao.maps.Size(36, 37),
          imgOptions =  {
              spriteSize : new kakao.maps.Size(36, 691),
              spriteOrigin : new kakao.maps.Point(0, (idx*46)+10),
              offset: new kakao.maps.Point(13, 37)
          },
          markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
          marker = new kakao.maps.Marker({
              position: position,
              image: markerImage
          });
      marker.setMap(map);
      markers.push(marker);
      return marker;
  }

  function removeMarker() {
      for ( var i = 0; i < markers.length; i++ ) {
          markers[i].setMap(null);
      }
      markers = [];
  }

  function displayPagination(pagination) {
      var paginationEl = document.getElementById('pagination'),
          fragment = document.createDocumentFragment(), i;
      while (paginationEl.hasChildNodes()) {
          paginationEl.removeChild (paginationEl.lastChild);
      }
      for (i=1; i<=pagination.last; i++) {
          var el = document.createElement('a');
          el.href = "#";
          el.innerHTML = i;
          if (i===pagination.current) {
              el.className = 'on';
          } else {
              el.onclick = (function(i) {
                  return function() {
                      pagination.gotoPage(i);
                  }
              })(i);
          }
          fragment.appendChild(el);
      }
      paginationEl.appendChild(fragment);
  }

  function displayInfowindow(marker, title) {
      var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
      infowindow.setContent(content);
      infowindow.open(map, marker);
  }

  function removeAllChildNods(el) {
      while (el.hasChildNodes()) {
          el.removeChild (el.lastChild);
      }
  }
</script>

<!-- 신고 모달 HTML (화면 맨 하단) -->
<div id="reportModalOverlay" class="modal-overlay">
  <div class="modal-content2">
    <h3>신고 작성</h3>
    <form id="reportForm">
      <input type="hidden" name="reporterIdx" value="${loginMemIdx}" />
      <input type="hidden" name="resiverIdx" value="${item.foundIdx}" />
      <label for="rContent">신고 상세내용</label>
      <textarea id="rContent" name="rContent" required></textarea>
      <div class="modal-buttons">
        <button type="button" onclick="closeReportModal()">취소</button>
        <button type="submit">제출</button>
      </div>
    </form>
  </div>
</div>

<!-- 채팅 모달(예시) -->
<div id="modal" class="modal-overlay" style="display:none;">
  <div class="modal-content2">
    <iframe id="modal-iframe" style="width:100%;height:400px;"></iframe>
  </div>
</div>

</body>
</html>