<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찾GET어 : 회원관리</title>
<link rel="icon" type="image/png" href="/img/favicon.ico" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<style>
  main{
    margin-left: 20%;
    padding: 20px 40px;
  }
  .titleBox{
     min-height: 60px;
     max-height: 60px;
     padding: 10px;
     margin-bottom: 30px;
     margin-top: 20px;
   }
   .right{ width: 100%; padding: 0 20px; text-align:right; margin: 0;}
   a{ color: black; cursor: pointer; text-decoration: none;}
   .pagingDiv{
     display: flex;
     justify-content: center;
   }
   .btn{ background-color: #B39977; color: white;}
   .btn:hover{ background-color: #8C6C55;}
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
      width:700px;
      height:800px;
      transform: translate(-50%, -50%);

      padding:40px;

      text-align: center;

      background-color: rgb(255,255,255);
      border-radius:10px;
      box-shadow:0 2px 3px 0 rgba(34,36,38,0.15);

   }
   .content{ height: 60%; margin-top: 40px;}
   .member_detail {
     height: 80%;
     padding: 15px 50px;
     text-align: left;
   }
   .banBtn:hover { background-color: red; color: white; }
   .memberThead{ margin-bottom: 20px;}
   .memberTable, .memberThead{
     display: table;
	 text-align: center;
	 width: 100%;
   }
   .memberTable{
     border: solid 2px #8C6C55;
	 border-radius: 10px;
	 border-collapse: separate;
	 border-spacing: 0;
   }
   .memberTr td:not(tr:last-of-type td){
    border-bottom: solid 1px #DFD4D4;
   }
   .memberTr td{ padding: 10px 0; }
   .memberTr:hover{ background-color: #D3C4B1; }
   .memberTr td:not(td:nth-child(1)) {
     border-left: solid 1.5px #8C6C55;
   }
   .reporter{ height: 90%;}
   .resive{ min-height: 30%;}
   .reports{
     display: flex;
     max-height: 60%;
     overflow-y: auto;
     flex-direction: column;
   }
   .reports tr{
     display:flex;
     height: 30px;
     width: 100%;
   }
   .modal .reports td:nth-child(1) { flex: 0 0 10%; }
   .modal .reports td:nth-child(2) { flex: 0 0 45%; }
   .modal .reports td:nth-child(3) { flex: 0 0 25%; }
   .modal .reports td:nth-child(4) { flex: 0 0 20%; }
</style>
</head>
<body>
<%@include file="/WEB-INF/include/adminSide.jsp" %>
  <main>
    <div class="titleBox">
      <div class="right" style="font-size: 13px;">
        <a href="/">HOME</a>&nbsp;&gt;&nbsp;<a href="/lost">게시물관리</a>&nbsp;&gt;&nbsp;<a href="/admin/post">신고게시글</a>
      </div>
      <h3 class="title">게시물관리</h3>
    </div>
    <hr style="color: #8C6C55; border-width: 3px;">
    <div><h4 style="padding-left: 20px; margin-bottom: 20px;">신고 게시물 목록</h4></div>
    <table class="memberThead">
      <colgroup>
        <col style="width: 5%;">
        <col style="width: 45%;">
        <col style="width: 20%;">
        <col style="width: 10%;">
        <col style="width: 10%;">
        <col style="width: 10%;">
      </colgroup>
      <tr>
        <td>순번</td>
        <td>제목</td>
        <td>작성자</td>
        <td>상태</td>
        <td>신고횟수</td>
        <td>작성일</td>
      </tr>
    </table>
    <table class="memberTable">
      <colgroup>
        <col style="width: 5%;">
        <col style="width: 45%;">
        <col style="width: 20%;">
        <col style="width: 10%;">
        <col style="width: 10%;">
        <col style="width: 10%;">
      </colgroup>
      <c:forEach items="${ reportList }" var="report" varStatus="i">
        <tr class="memberTr" id="${ report.resiver_idx }">
          <td>${ (pagingHelper.nowPage - 1 )* 15 + i.index + 1 }</td>
          <td>${ report.title }</td>
          <td>${ report.email }</td>
          <td>
            <c:if test="${ report.post_state eq 1 }">
              완료
            </c:if>
            <c:if test="${ report.post_state eq 2 }">
              진행
            </c:if>
          </td>
          <td>${ report.resiver_idx_cnt }</td>
          <td>${ report.p_reg_date }</td>
        </tr>
      </c:forEach>
    </table>
    <div class="pagingDiv">
      <%@include file="/WEB-INF/include/paging.jsp" %>
    </div>
  </main>
<div class="modal">
    <div class="modal_content">
      <h3>해당 게시글 신고 목록</h3>
      <div class="member_detail">
        <form class="form" method="POST">
          <input type="hidden" class="resiver_idx" name="resiver_idx">
        </form>
        <div class="reporter">
          <div><h5>신고받은 게시글</h5></div>
          <div class="resive"></div>
          <div><h5>신고목록</h5></div>
          <table style="width: 100%;">
            <colgroup>
              <col style="width: 10%;">
              <col style="width: 45%;">
              <col style="width: 25%;">
              <col style="width: 20%;">
            </colgroup>
            <tr>
              <td>순번</td>
              <td>신고내용</td>
              <td>신고자</td>
              <td>신고시간</td>
            </tr>
          </table>
          <table class="reports">
          </table>
        </div>
      </div>
      <span class="banBtn btn">게시글 블라인드</span>
      <span class="aBtn btn">게시글 상세보기</span>
      <span class="closeBtn btn">닫기</span>
    </div>
 </div>
  <script>
    const modal = document.querySelector('.modal');
    //모달 닫기 버튼
    const closeBtn = document.querySelector('.closeBtn')
    closeBtn.addEventListener('click', function(){
    	modal.style.display = 'none';
    });

    //멤버클릭시
    const memberTable = document.querySelector('.memberTable');
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
    			const resive = document.querySelector('.resive');
    			let resiveHTML;
    			if(map.found){
    				let found = map.found;
    				resiveHTML = '게시판 구분 : 습득물 게시판<br>'
    					       + '제목 : ' + found.foundTitle + '<br>'
    				           + '내용 : ' + found.foundContent + '<br>';

    			}
    			else if(map.lost){
    				let lost = map.lost;
    				resiveHTML = '게시판 구분 : 분실물 게시판<br>'
					           + '제목:' + lost.lostTitle + '<br>'
    				           + '내용 : ' + lost.lostContent + '<br>'
    				           + '사례금 : '+ lost.reward;
    			}
    			resive.innerHTML = resiveHTML;

    			//신고목록
    			let report = map.reports;
    			let reportHTML ='';
    			for(let i = 0; i < report.length; i++){
    				reportHTML += '<tr class="report">'
    			        + '<td>'+(i+1)+'</td>'
    			        + '<td>'+report[i].r_content+'</td>'
    			        + '<td>'+report[i].reporter_idx+'</td>'
    			        + '<td>'+report[i].r_reg_date+'</td>'
    			      +'</tr>';
    			  reports.innerHTML = reportHTML;
    			}

    			//게시글 상세보기 클릭시
    	    	const aBtn = document.querySelector('.aBtn');
    	        aBtn.addEventListener('click', function(){
    	        	console.log(e.target.parentNode.id);
    	        	if(map.found){
    	        	  window.location.href = "/found/view?foundIdx="+e.target.parentNode.id;
    	        	}
    	        	else if(map.lost){
    	        	  window.location.href = "/lost/view?lostIdx="+e.target.parentNode.id;
    	        	}
    	        });

    	        document.querySelector('.resiver_idx').value = e.target.parentNode.id;
    	        //차단버튼 클릭시
    	        const banBtn = document.querySelector('.banBtn');
    	        banBtn.addEventListener('click', function(){
    	        	const form = document.querySelector('.form');
    	        	let stateUrl = '';
    	        	if(map.lost){
    	        		stateUrl = "lostState="+map.lost.lostState
    	        	}
    	        	else if(map.found){
    	        		stateUrl = "foundState="+map.found.foundState
    	        	}
    	        	form.action = "/admin/post/ban?"+stateUrl;
    	        	form.submit();
    	        })
    		});
    	};
    });
  </script>
</body>
</html>