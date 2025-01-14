<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>분실물 상세 페이지</title>
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
      margin-left:  30%;
      margin-right: 100px;
      background: #fff;
      border: none;
      padding: 20px;
    }

    .detail-header {
      text-align: left;
      margin-bottom: 20px;
      border-bottom: solid #FF914B;
    }

    .detail-header h1 {
      font-size: 28px;
      color: #333;
    }

    .detail-header-inside h4 {
      margin-top: 10px;
      color: #555;
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

    .btn-container a {
      background-color: #FF914B;
      color: white;
      border: none;
      padding: 10px 20px;
      font-size: 16px;
      cursor: pointer;
      margin: 0 5px;
      transition: background-color 0.3s;
    }

    .btn-container a:hover {
      background-color: #E87A2E;
    }

    .content-container {
      text-align: center;
      border-top: solid #FF914B;
      border-bottom: solid #FF914B;
      margin-bottom: 20px;
    }

    .content {
      padding-top: 20px;
      text-align: left;
      min-height: 150px;
      /* 높이 상황에 따라 조정 */
    }

    .btn-container2 {
      text-align: center;
      margin: 20px 0;
    }
    .btn-container2 > * {
      display: inline-block;
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
      margin: 0 5px;
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

    .top-label h5 a {
      text-decoration: none;
      color: #666;
    }

    .top-label h5 a:hover {
      text-decoration: underline;
    }

    h1 {
      font-family: yangjin;
    }

    .modal-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.6);
      display: none; /* 초기 상태는 숨김 */
      justify-content: center;
      align-items: center;
      z-index: 1000;
    }

    .modal-content1 {
      background: white;
      padding: 20px;
      border-radius: 8px;
      max-width: 500px;
      width: 90%;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
      text-align: left;
    }
    .modal-content1 textarea{
     width: 100%;
     height: 100px;
     overflow-y: scroll;
     resize: none;
    }

    <c:if test="${ sessionScope.grant eq 'ADMIN' }">
    .detail-header {
      text-align: left;
      margin-bottom: 20px;
      border-bottom: solid #8C6C55;
    }
    .btn-container2 button {
      background-color: #8C6C55;
      color: white;
      border: none;
      padding: 10px 20px;
      font-size: 16px;
      cursor: pointer;
      margin: 0 5px;
      transition: background-color 0.3s;
    }

    .btn-container2 button:hover {
      background-color: #684F36;
    }

    .content {
      padding-top: 20px;
      text-align: left;
      height: 150px;
    }
    .content-container {
      text-align: center;
      border-top: solid #8C6C55;
      border-bottom: solid #8C6C55;
    }

    .map-section {
      margin-top: 30px;
      text-align: left;
    }
    .btn-container button {
      background-color: #8C6C55;
      color: white;
      border: none;
      padding: 10px 20px;
      font-size: 16px;
      cursor: pointer;
      margin: 0 5px;
      transition: background-color 0.3s;
    }
    .btn-container a {
      background-color: #8C6C55;
      color: white;
      border: none;
      padding: 10px 20px;
      font-size: 16px;
      cursor: pointer;
      margin: 0 5px;
      transition: background-color 0.3s;
    }

    .btn-container button:hover {
      background-color: #684F36;
    }

    .content-container {
      text-align: center;
      border-top: solid #8C6C55;
      border-bottom: solid #8C6C55;
      margin-bottom: 20px;
    }
    </c:if>

    /*---------------------지도 영역--------------------------*/
    .map_wrap, .map_wrap * {
      margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;
    }
    .map_wrap a, .map_wrap a:hover, .map_wrap a:active {
      color:#000;text-decoration: none;
    }
    .map_wrap {
      position:relative;width:100%;height:500px;
      /* 처음에 숨김 추가 -> inline style에서 처리 */
    }
    #menu_wrap {
      position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;
      padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;
      font-size:12px;border-radius: 10px; display: none;
    }
    .bg_white {background:#fff;}
    #menu_wrap hr {
      display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;
    }
    #menu_wrap .option {text-align: center;}
    #menu_wrap .option p {margin:10px 0;}
    #menu_wrap .option button {margin-left:5px;}
    #placesList li {list-style: none;}
    #placesList .item {
      position:relative;border-bottom:1px solid #888;overflow: hidden;
      cursor: pointer;min-height: 65px;
    }
    #placesList .item span {display: block;margin-top:4px;}
    #placesList .item h5, #placesList .item .info {
      text-overflow: ellipsis;overflow: hidden;white-space: nowrap;
    }
    #placesList .item .info{padding:10px 0 10px 55px;}
    #placesList .info .gray {color:#8a8a8a;}
    #placesList .info .jibun {
      padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;
    }
    #placesList .info .tel {color:#009900;}
    #placesList .item .markerbg {
      float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;
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
<c:choose>
    <c:when test="${ sessionScope.grant eq 'ADMIN' }">
      <%@include file="/WEB-INF/include/adminSide.jsp" %>
    </c:when>
    <c:when test="${ sessionScope.grant ne 'ADMIN' || !sessionScope.grant }">
      <%@include file="/WEB-INF/include/side.jsp" %>
    </c:when>
  </c:choose>
<div class="detail-container">
  <div class="top-label">
    <h5>
      <a href="/">home</a> >
      <a href="/lost">분실물</a> >
      <a href="#">분실물 상세보기</a>
    </h5>
  </div>

  <div class="detail-header">
    <h1>분실물 상세보기</h1>
    <div class="detail-header-inside">
      <h4>소중한 물품을 분실하셨습니다.
        <br>아래와 같은 물품을 습득하셨다면 관할기관 신고나 채팅으로 연락 부탁드립니다.</h4>
    </div>
  </div>

  <div class="info-section">
    <div class="image-container">
      <c:if test="${ not empty filePath }">
        <img src="<spring:url value='${ severUrl }imgView?filePath=${ filePath }'/>" alt="${ filePath }">
      </c:if>
      <c:if test="${ empty filePath }">
        <img src="/img/noimg.png" alt="이미지가 없습니다">
      </c:if>

      <div class="no-image"></div>
    </div>

    <div class="info-content">
      <!-- 작성자 닉네임 표시 -->
      <div class="info">
        <span class="label">작성자 닉네임:</span>
        <c:out value="${item.nickname}" />
      </div>
      <div class="info">
        <span class="label">분실물명:</span>
        <c:out value="${item.lostTitle}"/>
      </div>
      <div class="info">
        <span class="label">분실일:</span>
        <c:out value="${item.lostDate}"/>
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
        <c:out value="${item.sidoName}"/>
        <c:out value="${item.gugunName}"/>
        <c:out value="${item.lLocationDetail}"/>
      </div>
      <div class="info">
        <span class="label">사례금:</span>
        <c:out value="${item.reward}"/>
      </div>
      <!-- 상태 -->
      <div class="lost-state-message">
        <c:choose>
          <c:when test="${item.lostState == 2}">
            주인이 아직 애타게 찾고 있는 물건입니다.
          </c:when>
          <c:when test="${item.lostState == 1}">
            주인의 품으로 돌아간 물건입니다.
          </c:when>
        </c:choose>
      </div>

    </div>
  </div>

  <!-- 상단 버튼 (예: 1:1문의, 처리현황, 지도보기) -->
  <div class="btn-container">
    <button onclick="openChat()">1대1 채팅 보내기</button>
    <a href="/lost/process">처리절차안내</a>
    <!-- 버튼 클릭 -> 지도 보이기 + 스크롤 이동 -->
    <button onclick="scrollToMap()">지도에 분실위치 보기</button>
  </div>

  <!-- 본문 컨텐츠 -->
  <div class="content-container">
    <div class="content">
      <c:out value="${item.lostContent}"/>
    </div>
    <div class="btn-container2">
      <button onclick="history.back()">목록</button>

      <!-- 작성자인지 비교 (loginEmail eq item.email) -->
      <c:choose>
        <c:when test="${loginEmail eq item.email}">
          <!-- 작성자인 경우 수정 버튼 -->
          <button onclick="location.href='/lost/update?lostIdx=${item.lostIdx}'">수정</button>

          <!-- 찾음/취소 버튼 -->
          <form action="<c:out value='${item.lostState == 1 ? "/lost/cancel" : "/lost/complete"}' />"
                method="post" style="display: inline;">
              <input type="hidden" name="lostIdx" value="${item.lostIdx}" />
              <input type="hidden" name="email" value="${item.email}" />
              <button type="submit">
                  <c:choose>
                      <c:when test="${item.lostState == 1}">
                          잘못 눌렀어요!
                      </c:when>
                      <c:otherwise>
                          물건을 찾았어요!
                      </c:otherwise>
                  </c:choose>
              </button>
          </form>
        </c:when>

        <c:when test="${ sessionScope.grant eq 'ADMIN'}">
          <form class="form" method="post">
              <input type="hidden" name="resiver_idx" value="${item.lostIdx}">
              <input type="hidden" name="lostState" value="${item.lostState}">
              <button type="button" class="banBtn btn">블라인드</button>
          </form>
        </c:when>

        <c:otherwise>
          <!-- 작성자가 아니면 신고하기 버튼 -->
          <button type="button" onclick="openReportModal()">신고하기</button>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- 지도 섹션 -->
  <!-- 처음에 감춰둠 -->
  <div class="map_wrap" style="display: none;">
    <!-- 지도 표시 영역 -->
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <!-- 검색 메뉴 숨김 처리 -->
    <div id="menu_wrap" class="bg_white" style="display: none;">
      <hr>
      <ul id="placesList"></ul>
      <div id="pagination"></div>
    </div>
  </div>

  <!-- 카카오 맵 API 스크립트 포함 -->
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a38a546a4aaada7aec2c459d8d1d085a&libraries=services"></script>
  <script>
 // 마커를 담을 배열
  var markers = [];

  // 지도 생성 옵션
  var mapContainer = document.getElementById('map'),
      mapOption = {
          center: new kakao.maps.LatLng(37.566826, 126.9786567),
          level: 3
      };

  // 지도 생성
  var map = new kakao.maps.Map(mapContainer, mapOption);

  // 전역 변수: 검색된 마커 범위(bounds) 보관
  var lastBounds = null;

  // 장소 검색 객체 생성
  var ps = new kakao.maps.services.Places();
  var infowindow = new kakao.maps.InfoWindow({zIndex:1});

  // JSP에서 전달된 지역 상세 정보를 키워드로 설정
  var keyword = "<c:out value='${item.lLocationDetail}'/>";
  // 키워드 검색 실행
  searchPlaces();

  function searchPlaces() {
      if (!keyword.replace(/^\s+|\s+$/g, '')) {
          alert('키워드를 입력해주세요!');
          return false;
      }
      ps.keywordSearch(keyword, placesSearchCB);
  }

  function placesSearchCB(data, status, pagination) {
      if (status === kakao.maps.services.Status.OK) {
          displayPlaces(data);
          displayPagination(pagination);
      } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
          alert('검색 결과가 존재하지 않습니다.');
      } else if (status === kakao.maps.services.Status.ERROR) {
          alert('검색 결과 중 오류가 발생했습니다.');
      }
  }

  function displayPlaces(places) {
      var listEl = document.getElementById('placesList'),
          menuEl = document.getElementById('menu_wrap'),
          fragment = document.createDocumentFragment(),
          bounds = new kakao.maps.LatLngBounds();

      removeAllChildNods(listEl);
      removeMarker();

      for (var i = 0; i < places.length; i++) {
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
              itemEl.onmouseover = function() {
                  displayInfowindow(marker, title);
              };
              itemEl.onmouseout = function() {
                  infowindow.close();
              };
          })(marker, places[i].place_name);

          fragment.appendChild(itemEl);
      }

      listEl.appendChild(fragment);
      menuEl.scrollTop = 0;

      // 처음 실행 시 (화면이 숨겨져 있어도) 한 번 bounds 적용
      map.setBounds(bounds);

      // 전역 변수에 보관 -> 지도 노출 후 재적용
      lastBounds = bounds;
  }

  function getListItem(index, places) {
      var el = document.createElement('li'),
          itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                    '<div class="info">' +
                    '   <h5>' + places.place_name + '</h5>';

      if (places.road_address_name) {
          itemStr += '    <span>' + places.road_address_name + '</span>' +
                     '   <span class="jibun gray">' +  places.address_name  + '</span>';
      } else {
          itemStr += '    <span>' +  places.address_name  + '</span>';
      }
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                 '</div>';

      el.innerHTML = itemStr;
      el.className = 'item';
      return el;
  }

  function addMarker(position, idx, title) {
      var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png',
          imageSize = new kakao.maps.Size(36, 37),
          imgOptions = {
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
      for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(null);
      }
      markers = [];
  }

  function displayPagination(pagination) {
      var paginationEl = document.getElementById('pagination'),
          fragment = document.createDocumentFragment(),
          i;

      while (paginationEl.hasChildNodes()) {
          paginationEl.removeChild(paginationEl.lastChild);
      }
      for (i=1; i<=pagination.last; i++) {
          var el = document.createElement('a');
          el.href = "#";
          el.innerHTML = i;

          if (i === pagination.current) {
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
          el.removeChild(el.lastChild);
      }
  }

  // 버튼 클릭 시 지도 노출 + 화면 스크롤 + Bounds 재적용
  function scrollToMap() {
      const mapWrap = document.querySelector('.map_wrap');
      // 지도 영역 보이기
      mapWrap.style.display = 'block';

      // 숨겨진 상태로 지도 생성 시 표시가 깨질 수 있어 재정렬
      setTimeout(function() {
          map.relayout();

          // 전역 변수에 저장된 Bounds 재적용 -> 마커를 다시 가운데로
          if (lastBounds) {
              map.setBounds(lastBounds);
          }

          // 지도 영역으로 부드럽게 스크롤
          mapWrap.scrollIntoView({ behavior: 'smooth' });
      }, 50);
  }
  // 모달 열기/닫기, 신고 폼 로직은 원본 그대로
  function openReportModal() {
    document.getElementById("reportModalOverlay").style.display = "flex";
  }
  function closeReportModal() {
    document.getElementById("reportModalOverlay").style.display = "none";
  }

  const reportForm = document.getElementById("reportForm");
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

  // 블라인드
  const banBtn = document.querySelector('.banBtn');
  if (banBtn) {
    banBtn.addEventListener('click', function () {
      const form = document.querySelector('.form');
      if (form) {
        form.action = "/admin/post/ban";
        form.submit();
      }
    });
  }

  // 채팅 열기
  function openChat() {
    var modal = document.getElementById('modal');
    var iframe = document.getElementById('modal-iframe');
    iframe.src = '/chatting/room/open/${item.email}';
    modal.style.display = 'block';
  }
  </script>
</div>
</body>
</html>