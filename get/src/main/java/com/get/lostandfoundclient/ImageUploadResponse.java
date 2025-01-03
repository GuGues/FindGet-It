package com.get.lostandfoundclient;

/**
 * 이미지 업로드 응답 정보를 담는 모델 클래스
 */
public class ImageUploadResponse {
    private String storageIdx;

    public String getStorageIdx() {
        return storageIdx;
    }

    public void setStorageIdx(String storageIdx) {
        this.storageIdx = storageIdx;
    }
}