<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>분실물 작성</title>
  <style>
    /* 기존 스타일 유지 */
    body { font-family: Arial, sans-serif; padding: 20px; }
    .form-group { margin-bottom: 15px; }
    .form-group label { display: block; font-weight: bold; margin-bottom: 5px; }
    .form-control { width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; }
    select, input[type="text"], input[type="date"], textarea {
      border: 1px solid #ccc; border-radius: 4px;
      width: 100%;
    }
    button { padding: 10px 20px; background-color: #FF914B; color: white; border: none; border-radius: 5px; cursor: pointer; }
    button:hover { background-color: #E67E22; }

    /* 이미지 업로드 섹션 스타일 (나중에 구현할 예정) */
    .image-upload-section {
      margin-bottom: 20px;
    }
    .image-preview {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      margin-top: 10px;
    }
    .image-preview img {
      width: 100px;
      height: 100px;
      object-fit: cover;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    .image-preview .image-container {
      position: relative;
    }
    .image-preview .image-container .remove-image {
      position: absolute;
      top: 2px;
      right: 2px;
      background: rgba(255, 0, 0, 0.7);
      color: white;
      border: none;
      border-radius: 50%;
      width: 20px;
      height: 20px;
      cursor: pointer;
      font-size: 14px;
      line-height: 18px;
      text-align: center;
    }
    /* 호버 효과 */
    .listItem:hover {
      background-color: #FFD5B2 !important;
      cursor: pointer;
    }
    /* 로딩 스피너 스타일 */
    .spinner {
      display: none;
      border: 4px solid rgba(0,0,0,0.1);
      width: 36px;
      height: 36px;
      border-radius: 50%;
      border-left-color: #09f;
      animation: spin 1s ease infinite;
      margin: 20px auto;
    }
    @keyframes spin {
      to { transform: rotate(360deg); }
    }
  </style>
</head>
<body>

<main>
  <div class="titleBox">
    <div class="right" style="font-size: 13px;">
      <a href="/">HOME</a>&nbsp;&gt;&nbsp;<a href="/lost">습득물</a>&nbsp;&gt;&nbsp;<a href="/lost">습득물 작성</a>
    </div>
    <h3 class="title">습득물 작성</h3>
    <span>분실하신 물건 여부를 확인하시고, 아래 기재된 보관장소연락처로 보관번호를 말씀해주시기 바랍니다.</span>
  </div>

  <form action="/found/write" method="post">

    <div class="form-group">
      <label for="nickname">작성자 닉네임</label>
      <input type="text" id="nickname" class="form-control" value="${userNickname}" readonly />
    </div>
    <input type="hidden" name="email" value="${userEmail}" />

    <div class="form-group">
      <label for="locationCode">습득 지역</label>
      <select id="locationCode" name="locationCode" class="form-control" required>
        <option value="">선택</option>
        <c:forEach var="loc" items="${locations}">
          <c:out value="${loc['sidoName'][0].value}" />
          <option value="${loc.LOCATIONCODE}">
              ${loc.SIDONAME}:${loc.GUGUNNAME}
          </option>
        </c:forEach>
      </select>
    </div>


    <div class="form-group">
      <label for="fLocationDetail">상세 주소</label>
      <input type="text" id="fLocationDetail" name="fLocationDetail" class="form-control" required>
    </div>

    <div class="form-group">
      <label for="foundDate">습득일자</label>
      <input type="date" id="foundDate" name="foundDate" class="form-control" required>
    </div>

    <div class="form-group">
      <label for="itemCode">물품 분류</label>
      <select id="itemCode" name="itemCode" class="form-control" required>
        <option value="">선택</option>
        <c:forEach var="it" items="${items}">
          <c:out value="${it['colorName'][0].value}" />
          <option value="${it.ITEMCODE}">${it.ITEMNAME}</option>
        </c:forEach>
      </select>
    </div>


    <div class="form-group">
      <label for="lItemDetail">물품 상세 정보</label>
      <input type="text" id="lItemDetail" name="lItemDetail" class="form-control">
    </div>

    <div class="form-group">
      <label for="itemState">물품 상태 정보</label>
      <input type="text" id="itemState" name="itemState" class="form-control">
    </div>

    <!-- 이미지 업로드 섹션 -->
    <div class="form-group image-upload-section">
      <label for="imageUpload">물품 이미지 업로드</label>
      <input type="file" id="imageUpload" accept="image/*" multiple
             class="form-control" />
      <div class="image-preview" id="imagePreview"></div>

      <!-- 업로드된 imageStorage PK를 담을 hidden 필드 컨테이너 -->
      <div id="uploadedImagesContainer"></div>
    </div>


    <div class="form-group">
      <label for="colorCode">색상</label>
      <select id="colorCode" name="colorCode" class="form-control">
        <option value="">선택</option>
        <c:forEach var="color" items="${colors}">
          <c:out value="${color['colorName'][0].value}" />
          <option value="${color.COLORCODE}">${color.COLORNAME}</option>
        </c:forEach>
      </select>
    </div>


    <div class="form-group">
      <label for="foundTitle">공지 제목</label>
      <input type="text" id="foundTitle" name="foundTitle" class="form-control" required>
    </div>

    <div class="form-group">
      <label for="foundContent">내용 및 특이사항</label>
      <textarea id="foundContent" name="foundContent" rows="5" class="form-control" required></textarea>
    </div>

    <div class="spinner" id="loadingSpinner"></div>

    <div>
      <button type="submit">등록</button>
      <button type="reset">취소</button>
    </div>
  </form>
</main>

<script>
  // 단일 이미지 미리보기
  const imageFile = document.getElementById("imageFile");
  const imagePreview = document.getElementById("imagePreview");

  imageFile.addEventListener("change", ()=>{
    const file = imageFile.files[0];
    if(!file){
      imagePreview.innerHTML = "";
      return;
    }
    const reader = new FileReader();
    reader.onload = (e) => {
      imagePreview.innerHTML = `<img src="${e.target.result}" alt="preview" />`;
    };
    reader.readAsDataURL(file);
  });

  // 폼 submit -> 이미지 업로드 -> hidden 값 -> 최종 submit
  const foundForm = document.getElementById("foundForm");
  const uploadedContainer = document.getElementById("uploadedImagesContainer");

  foundForm.addEventListener("submit", function(e){
    e.preventDefault(); // 기본 submit 막고, JS에서 순서 제어

    const file = imageFile.files[0];
    if(!file){
      // 이미지 없는 경우 => 그냥 submit or 필수?
      // 요구사항: "게시글당 하나의 이미지만" => 이미지 없는 경우 등록 불가?
      alert("이미지를 첨부해주세요.");
      return;
    }

    // 1) 이미지 업로드(8080)
    uploadImageToServer(file)
            .then(storageIdx => {
              // 2) hidden input 추가
              const hidden = document.createElement("input");
              hidden.type = "hidden";
              hidden.name = "uploadedStorageIdx";
              hidden.value = storageIdx;  // ex) "IM00000001"
              uploadedContainer.appendChild(hidden);

              // 3) 최종 폼 submit
              foundForm.submit();
            })
            .catch(err => {
              // 업로드 실패 => 등록 중단
              alert("이미지 업로드 실패: " + err.message);
            });
  });

  // 실제 업로드
  function uploadImageToServer(file){
    return new Promise((resolve, reject)=>{
      const formData = new FormData();
      formData.append("file", file);
      formData.append("usingTable", "FOUND");
      formData.append("usingTableIdx", "TEMP"); // 아직 foundIdx 없음

      fetch("http://192.168.0.214:8080/images/upload", {
        method: "POST",
        body: formData
      })
              .then(res => {
                if(!res.ok){
                  throw new Error("이미지 서버 응답 오류");
                }
                return res.json(); // {storageIdx:"IM00000001"}
              })
              .then(json => {
                if(!json.storageIdx){
                  throw new Error("storageIdx가 응답에 없습니다.");
                }
                resolve(json.storageIdx);
              })
              .catch(err => {
                reject(err);
              });
    });
  }
</script>



</body>
</html>