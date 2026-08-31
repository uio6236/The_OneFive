package com.theonefive.common.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

//모든 API 응답을 이 형태({success, message, data})로 통일하기 위한 공통 응답 래퍼
@Getter
@AllArgsConstructor
public class ApiResponse<T> {

    private boolean success;   // 성공 여부
    private String message;    // 성공/실패 메시지 (없으면 null)
    private T data;            // 실제 응답 데이터 (실패 시 null)
    
    // 데이터만 담아서 성공 응답 생성 (메시지 없이)
    public static <T> ApiResponse<T> success(T data) {
        return new ApiResponse<>(true, null, data);
    }

    // 메시지 + 데이터를 함께 담아서 성공 응답 생성
    public static <T> ApiResponse<T> success(String message, T data) {
        return new ApiResponse<>(true, message, data);
    }

    // 실패 응답 생성 (data는 항상 null)
    public static <T> ApiResponse<T> fail(String message) {
        return new ApiResponse<>(false, message, null);
    }
}