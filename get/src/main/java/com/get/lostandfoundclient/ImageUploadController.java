package com.get.lostandfoundclient;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * 이미지 업로드를 처리하는 REST 컨트롤러
 */
@RestController
@RequestMapping("/api/images")
public class ImageUploadController {

    @Autowired
    private ImageUploadService imageUploadService;

    /**
     * 클라이언트에서 이미지를 업로드하는 엔드포인트
     *
     * @param file            업로드할 이미지 파일
     * @param usingTable      이미지를 사용하는 테이블명
     * @param usingTableIdx   이미지를 사용하는 테이블의 인덱스
     * @return 업로드 결과
     */
    @PostMapping("/upload")
    public ResponseEntity<String> uploadImage(
            @RequestParam("file") MultipartFile file,
            @RequestParam("usingTable") String usingTable,
            @RequestParam("usingTableIdx") String usingTableIdx
    ) {
        try {
            ImageUploadResponse response = imageUploadService.uploadImage(file, usingTable, usingTableIdx);
            return new ResponseEntity<>(response.getStorageIdx(), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("이미지 업로드 실패: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}