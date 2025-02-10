<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찾GET어 : 습득물게시판</title>
<link rel="icon" type="image/png" href="/img/favicon.ico" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<style>
  main{
    margin-left: 20%;
    padding: 20px 40px;
  }
  .searchBtn img{
    max-width: 20px; 
  }
  .modal{
    display:none;
    
    justify-content: center;
    top:0;
    left:0;

    width:100%;
    height:100%;

    background-color: rgba(0,0,0,0.3);
    z-index: 3; 
   }
   .modal_content{
      position:absolute;
      
      top: 50%;
      left: 50%;
      width:400px;
      height:600px;
      transform: translate(-50%, -50%);	

      padding:40px;  

      text-align: center;

      background-color: rgb(255,255,255);
      border-radius:10px; 
      box-shadow:0 2px 3px 0 rgba(34,36,38,0.15);
   }
   .content{
     display: flex;
   }
   .checked{ background-color: #FFD5B2; }
   .warning, .warningDate{
    position:absolute;
    display: none;
    
    justify-content: center;
    top:0;
    left:0;

    width:100%;
    height:100%;

    background: none;
    z-index: 2;
   }
   .warning_content, .warningDate_content{
     position:absolute;
      
      top: 10%;
      left: 50%;
      width:320px;
      height:70px;
      transform: translate(-50%, -50%);	

      padding:20px;  

      text-align: center;

      background-color: #FFD5B2;
      border-radius:10px;
      
      color: #FE8015;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      border: 2px solid rgba(0, 0, 0, 0.2);
   }
   .locationContent{
     max-height: 100%;
   }
   .locationMiddle{
     max-height: 400px;
     overflow-y: auto; 
   }
   .titleBox{
     min-height: 110px;
     max-height: 110px;
     padding: 10px;
     margin-bottom: 30px;
     margin-top: 20px;
   }
   .right{ width: 100%; padding-right: 20px; text-align:right; }
   .search{
     border: solid 1px #DFDFDF;
     border-radius: 10px;
     box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.3);
     padding: 20px;
     margin-bottom: 25px;
   }
   .search>div{
     margin-bottom: 10px;
   }
   .search input[type="text"], input[type="date"]{
     border: solid 1px #DFDFDF;
   }
   input[type="button"]{
     border: solid 1px #FE8015;
     border-radius: 5px;
     padding: 3px 15px;
     background-color: #FE8015;
     color: black;
   }
   input[type="button"]:hover{
     border: solid 1px #FE8015;
     border-radius: 5px;
     padding: 3px 15px;
     background-color: white;
     color: black;
     transition: background-color 0.3s ease
   }
   .search>div>span:first-child{
     margin-right: 30px;
   }
   .searchBtn{
     border: solid 1px #FE8015;
     border-radius: 5px;
     padding: 5px 15px;
     color: #FE8015;
   }
   .searchBtn:hover{
     background-color: #FFD5B2;
     transition: background-color 0.3s ease;
     cursor: pointer;
   }
   .list{
     display: block;
     text-align: center;
     width: 95%;
     border: #FE8015 solid 2.5px;
     padding: 20px;
     border-radius: 10px;
   }
   .list tr td:nth-child(1){ min-width: 40px; width: 5%; }
   .list tr td:nth-child(2){ min-width: 120px; width: 10%; }
   .list tr td:nth-child(3){ min-width: 200px; width: 50%; }
   .list tr td:nth-child(3):not(.listHead td){ text-align: left; padding-left: 30px; }
   .list tr td:nth-child(4){ min-width: 100px; width: 15%; }
   .list tr td:nth-child(5){ min-width: 100px; width: 15%; }
   .list tr td:nth-child(6){ min-width: 50px; width: 5%; }
   .list tr:not(.listHead){
     height: 40px;
   }
   .list tr:not(.listHead) td:not(td:first-child){
     border-left: #FE8015 solid 1px
   }
   .list tr:not(.listHead, tr:nth-child(1), tr:last-child):hover{
     background-color: #FFD5B2;
   }
   .bigBox{
     width: 100%;
     display: flex;
     flex-direction: column;
     justify-content: center;
     align-items: center;
     position: relative;
   }
   .listTable{ padding: 0; }
   .listTable tr:not(tr:first-child, tr:nth-child(2), tr:last-child){ border-top: solid 1px #DFD4D4; }
   .listTable tr:nth-child(1), .listTable tr:last-child{ height: 20px;}
   a{ color: black; cursor: pointer; text-decoration: none;}
   .writeBtn{
    border: solid 1px #FE8015;
    border-radius: 5px;
    padding: 5px 15px;
    color: #FE8015;
  }
   <c:if test="${ sessionScope.grant eq 'ADMIN' }">
     input[type="button"]{
       border: solid 1px #8C6C55;
       background-color: #8C6C55;
       color: white;
     }
     .searchBtn{
       border: solid 1px #8C6C55;
       color: #8C6C55;
     }
     .searchBtn img{
       filter: opacity(0.5) drop-shadow(0 0 0 #8C6C55);
     }
     .searchBtn:hover{
       background-color: #8C6C55;
       color: white;
     }
     .list { border: #684F36 solid 2.5px; }
     .list tr:not(.listHead) td:not(td:first-child){
     border-left: #684F36 solid 1px
   }.list tr:not(.listHead, tr:nth-child(1), tr:last-child):hover{
     background-color: #D3C4B1;
   }
   </c:if>
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
  <main>
    <div class="titleBox">
      <div class="right" style="font-size: 13px;">
        <a href="/">HOME</a>&nbsp;&gt;&nbsp;<a href="/found">습득물</a>&nbsp;&gt;&nbsp;<a href="/found">습득물 검색</a>
      </div>
      <h3 class="title">찾GET어 습득물</h3>
      <span>분실하신 물건 여부를 확인하시고, 아래 기재된 관할기관 신고나 습득자 채팅으로 연락바랍니다.</span>
    </div>

    <form method="GET" class="search">
      <div>
        <span>물품명&nbsp;<input type="text" id="found_title" style="width: 50%;"></span>
        <span>물품카테고리
          <input type="text" placeholder="자동입력" class="cateText item" readonly>
          <input type="button" value="찾기" id="cateBtn">
          <input type="button" value="삭제" id="cateDelBtn">
        </span>
      </div>
      <div>
        <span>분실장소
          <input type="text" placeholder="자동입력" class="addr" readonly>
          <input type="button" value="주소찾기" id="addBtn">
          <input type="button" value="삭제" id="addrDelBtn">
        </span>
      </div>
      <div>
        <span>분실일&nbsp;<input type="date" id="startDate"> ~ <input type="date" id="endDate"></span>
        <span>색상
          <input type="text" placeholder="자동입력" class="colorText" readonly>
          <input type="button" value="선택" class="color" id="colorBtn">
          <input type="button" value="삭제" class="color" id="colorDelBtn">
        </span>
      </div>
      <div class="searchBtnBox right" style="padding-right: 50px;">
        <span class="searchBtn"><img alt="" src="/img/dodbogi_orange.png">검색</span>
      </div>
    </form>

    <!-- modal -->
    <div class="modal cate">
      <div class="modal_content">
        <h3>물품 카테고리</h3>
        <div class="content">
          <div class="bigCate"><!-- 대분류 --></div>
          <div class="smallCate"><!-- 소분류 --></div>
        </div>
        <span class="cateOk">확인</span>
        <span class="cateClose">닫기</span>
      </div>
    </div>
    <div class="modal color">
      <div class="modal_content">
        <h3>물품 색상</h3>
        <div class="content colorContent">
          <div class="colorCate"></div>
        </div>
        <span class="colorOk">확인</span>
        <span class="colorClose">닫기</span>
      </div>
    </div>
    <div class="modal addrSearch">
      <div class="modal_content">
        <h3>분실장소</h3>
        <div class="content locationContent">
          <div class="locationBig"><!-- 큰 지역 --></div>
          <div class="locationMiddle"><!-- 중간 지역 --></div>
        </div>
        <span class="locationOk">확인</span>
        <span class="locationClose">닫기</span>
      </div>
    </div>
    <div class="warning">
      <div class="warning_content">* 값을 선택하고 확인버튼을 눌러주세요 *</div>
    </div>
    <div class="warningDate">
      <div class="warningDate_content">* 날짜값을 확인해주세요 *</div>
    </div>
    <div class="bigBox">
    <table class="list" style="border: none; padding: 20px 0;">
      <tr class="listHead" style="padding:0;margin: 0;">
        <td>순번</td>
        <td>작성자</td>
        <td>분실품명</td>
        <td>분실장소</td>
        <td>분실일자</td>
        <td>조회수</td>

      </tr>
    </table>
    <table class="list listTable">
    <c:if test="${ not empty foundList }">
      <tr>
        <c:forEach begin="1" end="6">
          <td></td>
        </c:forEach>
      </tr>
    </c:if>
    <c:if test="${ empty foundList }">
      <tr><td colspan="6">검색결과가 없습니다🥲</td></tr>
    </c:if>
      <c:forEach items="${ foundList }" var="found" varStatus="i">
        <tr class="listItem" id="${ found.found_idx }">
          <td>${ (pagingHelper.nowPage - 1 )* 15 + i.index + 1 }</td>
          <td>${ found.nickname }</td>
          <td>${ found.found_title }</td>
          <td>${ found.location }</td>
          <td>${ found.found_date }</td>
          <td>${ found.f_views }</td>
        </tr>
      </c:forEach>
      <c:if test="${ not empty foundList }">
      <tr>
        <c:forEach begin="1" end="6">
          <td></td>
        </c:forEach>
      </tr>
    </c:if>
    </table>
    <div class="pagingDiv">
      <%@include file="/WEB-INF/include/searchPaging.jsp" %>
    </div>
    </div>
    <c:if test="${ sessionScope.grant eq 'USER' }">
      <a class="writeBtn" href="/found/write">게시글 작성 </a>
    </c:if>
  </main>
  <script>
    const cateBtn = document.querySelector('#cateBtn');
    //모달 카테고리 대분류
    cateBtn.addEventListener('click', function(){
    	let modal = document.querySelector('.modal.cate');
    	modal.style.display = 'block';

    	//닫기버튼
    	const close = document.querySelector('.cateClose');
    	close.addEventListener('click', function(){
    		modal.style.display = 'none';
    	});

    	//대분류출력
    	fetch('/getBigCate',{
    		method: 'GET',
    		headers: { 'Content-Type': 'application/json' },
    	})
    	.then(response => response.json())
    	.then(list => {
    		//console.log(list);
    		const bigCate = document.querySelector('.bigCate');
    		let html = ''
    		for(let i = 0; i < list.length; i++){
    			html += '<span id="'+list[i].item_code+'" class="itemBigCate">'+list[i].item+'</span><br>';
    		}
    		bigCate.innerHTML = html;
    	});
    });
  //확인버튼
	const ok1 = document.querySelector('.cateOk');
	ok1.addEventListener('click', function(){
		let cate = document.querySelector('.itemCate.checked');
		const cateText = document.querySelector('.cateText');
		if(cate){
			cateText.value = cate.innerHTML;
    		cateText.id = cate.id;
    		cate.classList.remove('checked');
    		document.querySelector('.modal.cate').style.display = 'none';
		}
		else{
			const warning = document.querySelector('.warning');
			warning.style.display = 'block';
			setTimeout(function() {
				warning.style.display = 'none';
			  }, 1800);
		}
	});

    //선택 카테고리 소분류 출력
    const bigCate = document.querySelector('.bigCate');
    bigCate.addEventListener('click', function(e){
    	//console.log(e.target.classList);
    	const smallCate = document.querySelector('.smallCate');

    	if(e.target.classList == 'itemBigCate'){
    		let checked = document.querySelector('.itemBigCate.checked');
        	if(checked){
        		checked.classList.remove('checked');
        	}
        	e.target.classList.add('checked');
        	let item_code = e.target.id;
        	fetch('/getCate?item_code='+item_code,{
        		method: 'GET',
        		headers: { 'Content-Type': 'application/json' },
        	})
        	.then(response => response.json())
        	.then(list => {
        		//console.log(list);
        		let html = '';
        		for(let i = 0; i < list.length; i++){
        			html += '<span id="'+list[i].item_code+'" class="itemCate">'+list[i].item.split('-')[1]+'</span><br>';
        		}
        		smallCate.innerHTML = html;
        	});
    	}

    	//소분류 카테고리 선택
    	smallCate.addEventListener('click', function(e){
    		if(e.target.classList == 'itemCate'){
        		let checked = document.querySelector('.itemCate.checked');
            	if(checked){
            		checked.classList.remove('checked');
            	}
            	e.target.classList.add('checked');
    		}
    	});
    });


    const colorBtn = document.querySelector('#colorBtn');
    //모달 색상 분류
    colorBtn.addEventListener('click', function(){
    	let modal = document.querySelector('.modal.color');
    	modal.style.display = 'block';

    	//닫기버튼
    	const close = document.querySelector('.colorClose');
    	close.addEventListener('click', function(){
    		modal.style.display = 'none';
    	});

    	fetch('/getColor', {
    		method: 'GET',
    		headers: { 'Content-Type': 'application/json' },
    	})
    	.then(response => response.json())
    	.then(list => {
    		//console.log(list);
    		let html = '';
       		for(let i = 0; i < list.length; i++){
       			html += '<span id="'+list[i].color_code+'" class="colorList">'+list[i].color_name+'</span><br>';
       		}
       		const colorCate = document.querySelector('.colorCate');
       		colorCate.innerHTML = html;
    	});

    	const colorContent = document.querySelector('.colorContent');
    	colorContent.addEventListener('click', function(e){
    		if(e.target.classList == 'colorList'){
       		  let checked = document.querySelector('.colorList.checked');
           	  if(checked){
           		checked.classList.remove('checked');
           	  }
           	  e.target.classList.add('checked');
    		}
    	});
    });
  //확인버튼
	const ok2 = document.querySelector('.colorOk');
	//console.log(오케이);
	ok2.addEventListener('click', function(){
		let color = null;
		color = document.querySelectorAll('.colorList.checked')[0];
		const colorText = document.querySelector('.colorText');
		console.log(color);
		if(color){
			colorText.value = color.innerHTML;
			colorText.id = color.id;
			color.classList.remove('checked');
			document.querySelector('.modal.color').style.display = 'none';
		}
		else{
			const warning = document.querySelector('.warning');
			warning.style.display = 'block';
			setTimeout(function() {
				warning.style.display = 'none';
			  }, 1800);
		}
	});

    const addBtn = document.querySelector('#addBtn');
    //모달 주소 대분류
    addBtn.addEventListener('click', function(){
    	let modal = document.querySelector('.modal.addrSearch');
    	modal.style.display = 'block';

    	//닫기버튼
    	const close = document.querySelector('.locationClose');
    	close.addEventListener('click', function(){
    		modal.style.display = 'none';
    	});

    	//대분류출력
    	fetch('/getLocationBig',{
    		method: 'GET',
    		headers: { 'Content-Type': 'application/json' },
    	})
    	.then(response => response.json())
    	.then(list => {
    		//console.log(list);
    		const locationBig = document.querySelector('.locationBig');
    		let html = ''
    		for(let i = 0; i < list.length; i++){
    			html += '<span id="'+list[i].location_code+'" class="bigLocations">'+list[i].sido_name+'</span><br>';
    		}
    		locationBig.innerHTML = html;
    	});
    });
  //확인버튼
	const ok3 = document.querySelector('.locationOk');
	ok3.addEventListener('click', function(){
		let locationBig = document.querySelector('.bigLocations.checked');
		let locationMiddle = document.querySelector('.middleLocations.checked');
		//console.log(cate.innerHTML);
		const addr = document.querySelector('.addr');
		if(locationMiddle){
			addr.value = locationBig.innerHTML+' '+locationMiddle.innerHTML;
			addr.id = locationMiddle.id;
			locationBig.classList.remove('checked');
			locationMiddle.classList.remove('checked');
			document.querySelector('.modal.addrSearch').style.display = 'none';
		}
		else{
			const warning = document.querySelector('.warning');
			warning.style.display = 'block';
			setTimeout(function() {
				warning.style.display = 'none';
			  }, 1800);
		}
	});

    const locationContent = document.querySelector('.locationContent');
    locationContent.addEventListener('click', function(e){
    	//console.log(e.target);
    	const locationMiddle = document.querySelector('.locationMiddle');

    	if(e.target.classList == 'bigLocations'){
    		let checked = document.querySelector('.bigLocations.checked');
        	if(checked){
        		checked.classList.remove('checked');
        	}
        	e.target.classList.add('checked');
        	let location_code = e.target.id;
        	fetch('/getLocationMiddle?location_code='+location_code,{
        		method: 'GET',
        		headers: { 'Content-Type': 'application/json' },
        	})
        	.then(response => response.json())
        	.then(list => {
        		//console.log(list);
        		let html = '';
        		for(let i = 0; i < list.length; i++){
        			html += '<span id="'+list[i].location_code+'" class="middleLocations">'+list[i].gugun_name+'</span><br>';
        		}
        		locationMiddle.innerHTML = html;
        	});
    	}
    	else if(e.target.classList == 'middleLocations'){
    		let checked = document.querySelector('.middleLocations.checked');
        	if(checked){
        		checked.classList.remove('checked');
        	}
        	e.target.classList.add('checked');
    	}
    });

    //검색
    const searchBtn = document.querySelector('.searchBtn');
    searchBtn.addEventListener('click', function(){

    	// 날짜 데이터 확인
    	let startDateStr = document.querySelector('#startDate');
    	let endDateStr = document.querySelector('#endDate');
    	const today = new Date();
    	if(startDateStr.value && endDateStr.value){
    		let startDate = new Date(startDateStr.value);
    		let endDate = new Date(endDateStr.value);
    		if(endDate.getTime() <= startDate.getTime()){
    			//console.log('ok');
    			const warning = document.querySelector('.warningDate');
    			warning.style.display = 'block';
    			setTimeout(function() {
    				warning.style.display = 'none';
    			 }, 1800);
    			return false;
    		}
    	}
    	else if(startDateStr.value){
    		let startDate = new Date(startDateStr.value);
    		if(today.getTime() <= startDate.getTime()){
    			//console.log('ok');
    			const warning = document.querySelector('.warningDate');
    			warning.style.display = 'block';
    			setTimeout(function() {
    				warning.style.display = 'none';
    			 }, 1800);
    			return false;
    		}
    	}
    	else if(endDateStr.value){
    		let endDate = new Date(endDateStr.value);
    		if(today.getTime() <= endDate.getTime()){
    			//console.log('ok');
    			const warning = document.querySelector('.warningDate');
    			warning.style.display = 'block';
    			setTimeout(function() {
    				warning.style.display = 'none';
    			 }, 1800);
    			return false;
    		}
    	}

    	let searchData = new URLSearchParams();
    	searchData.append('found_title',document.querySelector('#found_title').value );
    	searchData.append('item_code',document.querySelector('.item').id );
    	searchData.append('location_code',document.querySelector('.addr').id );
    	searchData.append('start_date',document.querySelector('#startDate').value );
    	searchData.append('end_date',document.querySelector('#endDate').value );
    	searchData.append('color_code',document.querySelector('.colorText').id );

    	window.location.href = '/getFoundSearch?' + searchData.toString();

    })
    //내용 삭제버튼
    const cateDelBtn = document.querySelector('#cateDelBtn');
    const addrDelBtn = document.querySelector('#addrDelBtn');
    const colorDelBtn = document.querySelector('#colorDelBtn');

    cateDelBtn.addEventListener('click',function(){
    	document.querySelector('.item').removeAttribute('id');
    	document.querySelector('.item').value = "";
    })
    addrDelBtn.addEventListener('click',function(){
    	document.querySelector('.addr').removeAttribute('id');
    	document.querySelector('.addr').value = "";
    })
    colorDelBtn.addEventListener('click',function(){
    	document.querySelector('.colorText').removeAttribute('id');
    	document.querySelector('.colorText').value = "";
    })

    //tr 누르면 이동
    const listTable = document.querySelector('.listTable');
    listTable.addEventListener('click', function(e){
    	//console.log(e.target.parentNode);
    	if(e.target.parentNode.classList == 'listItem'){
    		console.log(e.target.parentNode.id);
    		window.location.href = '/found/view?foundIdx='+e.target.parentNode.id;
    	}
    });

  </script>
</body>
</html>