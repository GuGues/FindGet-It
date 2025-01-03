package com.get.lostandfoundclient;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

/**
 * 이미지 업로드를 담당하는 서비스 클래스
 */
@Service
public class ImageUploadService {

    @Value("${image.storage.server.url}")
    private String imageStorageServerUrl;

    private final RestTemplate restTemplate = new RestTemplate();

    /**
     * 클라이언트에서 받은 이미지를 서버로 업로드
     *
     * @param file            업로드할 이미지 파일
     * @param usingTable      이미지를 사용하는 테이블명
     * @param usingTableIdx   이미지를 사용하는 테이블의 인덱스
     * @return 서버로부터 받은 이미지 업로드 응답
     */
    public ImageUploadResponse uploadImage(MultipartFile file, String usingTable, String usingTableIdx) {
        String uploadUrl = imageStorageServerUrl + "/upload";

        // 멀티파트 요청 설정
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("file", file.getResource());
        body.add("usingTable", usingTable);
        body.add("usingTableIdx", usingTableIdx);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);

        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

        // 서버로 POST 요청 보내기
        ResponseEntity<ImageUploadResponse> response = restTemplate.postForEntity(
                uploadUrl,
                requestEntity,
                ImageUploadResponse.class
        );

        return response.getBody();
    }
}