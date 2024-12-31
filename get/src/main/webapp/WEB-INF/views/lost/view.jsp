<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>분실물 상세 페이지</title>
  <link rel="stylesheet" href="/css/common.css" />
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
      margin-left: 100px;
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

    .modal-content {
      background: white;
      padding: 20px;
      border-radius: 8px;
      max-width: 500px;
      width: 90%;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
      text-align: left;
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
    .map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
    .map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
    .map_wrap {position:relative;width:100%;height:500px;}
    #menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px; display: none;} /* 검색 메뉴 숨김 */
    .bg_white {background:#fff;}
    #menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
    #menu_wrap .option{text-align: center;}
    #menu_wrap .option p {margin:10px 0;}
    #menu_wrap .option button {margin-left:5px;}
    #placesList li {list-style: none;}
    #placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
    #placesList .item span {display: block;margin-top:4px;}
    #placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
    #placesList .item .info{padding:10px 0 10px 55px;}
    #placesList .info .gray {color:#8a8a8a;}
    #placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
    #placesList .info .tel {color:#009900;}
    #placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
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
      <a href="/">분실물</a> >
      <a href="/">분실물 검색</a> >
      <a href="/">분실물 상세보기</a>
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
        <img src="<spring:url value='${ severUrl }imgView?filePath=${ filePath }'/>" alt="이미지가 없습니다">
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
    </div>
  </div>

  <!-- 상단 버튼 (예: 1:1문의, 처리현황, 지도보기) -->
  <div class="btn-container">
    <button>1대1 문의 보내기</button>
    <button>분실물 처리현황</button>
    <button>지도에 분실위치 보기</button>
  </div>

  <!-- 본문 컨텐츠 -->
  <div class="content-container">
    <div class="content">
      <c:out value="${item.lostContent}"/>
    </div>
    <div class="btn-container2">
      <button onclick="location.href='/lost'">목록</button>

      <!-- 작성자인지 비교 (loginEmail eq item.email) -->
      <c:choose>
        <c:when test="${loginEmail eq item.email}">
          <!-- 작성자인 경우 수정 버튼 -->
          <button onclick="location.href='/lost/update?lostIdx=${item.lostIdx}'">수정</button>
        </c:when>
        <c:when test="${ sessionScope.grant eq 'ADMIN'}" >
       <form class="form" method="post">

    <input type="hidden" name="resiver_idx" value="${item.lostIdx}">
    <button type="button" class="banBtn btn">게시글 블라인드</button>
</form>

<script>
    // 버튼 요소를 가져옵니다.
    const banBtn = document.querySelector('.banBtn');
    if (banBtn) {
        banBtn.addEventListener('click', function () {
            // 폼 태그를 가져옵니다.
            const form = document.querySelector('.form');
            if (form) {
                // 폼의 액션 설정 및 제출
                form.action = "/admin/post/ban";
                form.submit();
            } else {
                console.error('폼 태그가 존재하지 않습니다.');
            }
        });
    } else {
        console.error('banBtn 버튼이 존재하지 않습니다.');
    }
</script>

        </c:when>
        <c:otherwise>
          <!-- 작성자가 아니면 신고하기 버튼 -->
          <button type="button" onclick="openReportModal()">신고하기</button>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- 지도 섹션 -->
  <div class="map_wrap">
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
  // 마커를 담을 배열입니다
  var markers = [];

  var mapContainer = document.getElementById('map'), // 지도를 표시할 div
      mapOption = {
          center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표 (기본값: 서울시청)
          level: 3 // 지도의 확대 레벨
      };

  // 지도를 생성합니다
  var map = new kakao.maps.Map(mapContainer, mapOption);

  // 장소 검색 객체를 생성합니다
  var ps = new kakao.maps.services.Places();

  // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
  var infowindow = new kakao.maps.InfoWindow({zIndex:1});

  // JSP에서 전달된 지역 상세 정보를 키워드로 설정
  var keyword = "<c:out value='${item.lLocationDetail}'/>";

  // 키워드로 장소를 검색합니다
  searchPlaces();

  // 키워드 검색을 요청하는 함수입니다
  function searchPlaces() {

      // 키워드가 유효한지 확인
      if (!keyword.replace(/^\s+|\s+$/g, '')) {
          alert('키워드를 입력해주세요!');
          return false;
      }

      // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
      ps.keywordSearch( keyword, placesSearchCB);
  }

  // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
  function placesSearchCB(data, status, pagination) {
      if (status === kakao.maps.services.Status.OK) {

          // 정상적으로 검색이 완료됐으면
          // 검색 목록과 마커를 표출합니다
          displayPlaces(data);

          // 페이지 번호를 표출합니다
          displayPagination(pagination);

      } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

          alert('검색 결과가 존재하지 않습니다.');
          return;

      } else if (status === kakao.maps.services.Status.ERROR) {

          alert('검색 결과 중 오류가 발생했습니다.');
          return;

      }
  }

  // 검색 결과 목록과 마커를 표출하는 함수입니다
  function displayPlaces(places) {

      var listEl = document.getElementById('placesList'),
      menuEl = document.getElementById('menu_wrap'),
      fragment = document.createDocumentFragment(),
      bounds = new kakao.maps.LatLngBounds(),
      listStr = '';

      // 검색 결과 목록에 추가된 항목들을 제거합니다
      removeAllChildNods(listEl);

      // 지도에 표시되고 있는 마커를 제거합니다
      removeMarker();

      for ( var i=0; i<places.length; i++ ) {

          // 마커를 생성하고 지도에 표시합니다
          var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
              marker = addMarker(placePosition, i),
              itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

          // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
          // LatLngBounds 객체에 좌표를 추가합니다
          bounds.extend(placePosition);

          // 마커와 검색결과 항목에 mouseover 했을때
          // 해당 장소에 인포윈도우에 장소명을 표시합니다
          // mouseout 했을 때는 인포윈도우를 닫습니다
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

      // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
      listEl.appendChild(fragment);
      menuEl.scrollTop = 0;

      // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
      map.setBounds(bounds);
  }

  // 검색결과 항목을 Element로 반환하는 함수입니다
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

  // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
  function addMarker(position, idx, title) {
      var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
          imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
          imgOptions =  {
              spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
              spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
              offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
          },
          markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
              marker = new kakao.maps.Marker({
              position: position, // 마커의 위치
              image: markerImage
          });

      marker.setMap(map); // 지도 위에 마커를 표출합니다
      markers.push(marker);  // 배열에 생성된 마커를 추가합니다

      return marker;
  }

  // 지도 위에 표시되고 있는 마커를 모두 제거합니다
  function removeMarker() {
      for ( var i = 0; i < markers.length; i++ ) {
          markers[i].setMap(null);
      }
      markers = [];
  }

  // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
  function displayPagination(pagination) {
      var paginationEl = document.getElementById('pagination'),
          fragment = document.createDocumentFragment(),
          i;

      // 기존에 추가된 페이지번호를 삭제합니다
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

  // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
  // 인포윈도우에 장소명을 표시합니다
  function displayInfowindow(marker, title) {
      var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

      infowindow.setContent(content);
      infowindow.open(map, marker);
  }

   // 검색결과 목록의 자식 Element를 제거하는 함수입니다
  function removeAllChildNods(el) {
      while (el.hasChildNodes()) {
          el.removeChild (el.lastChild);
      }
  }
  </script>

  <!-- 신고 모달 영역 -->
  <div id="reportModalOverlay" class="modal-overlay">
    <div class="modal-content">
      <h3>신고 작성</h3>
      <form id="reportForm">
        <input type="hidden" name="reporterIdx" value="${loginMemIdx}" />
        <input type="hidden" name="resiverIdx" value="${item.lostIdx}" />

        <label for="rContent">신고 상세내용</label>
        <textarea id="rContent" name="rContent" required></textarea>

        <div class="modal-buttons">
          <button type="button" onclick="closeReportModal()">취소</button>
          <button type="submit">제출</button>
        </div>
      </form>
    </div>
  </div>

  <script>
    // 모달 열기
    function openReportModal() {
      document.getElementById("reportModalOverlay").style.display = "flex";
    }
    // 모달 닫기
    function closeReportModal() {
      document.getElementById("reportModalOverlay").style.display = "none";
    }

    // 신고 폼 submit
    const reportForm = document.getElementById("reportForm");
    reportForm.addEventListener("submit", function(e) {
      e.preventDefault();

      // 폼 데이터 직렬화
      const formData = new FormData(reportForm);

      // fetch POST
      fetch("/report/submit", {
        method: "POST",
        body: formData
      })
              .then(response => {
                if (!response.ok) {
                  throw new Error("신고 접수 중 오류가 발생했습니다.");
                }
                return response.text(); // 단순 응답
              })
              .then(data => {
                alert("신고가 접수되었습니다.");
                closeReportModal();
                // 신고 후 필요하다면 페이지 새로고침/이동
                location.reload();
              })
              .catch(err => {
                alert(err.message);
              });
    });



  </script>
</div>
</body>
</html>

