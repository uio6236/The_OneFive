package com.theonefive.housekeeping.model.dto;

import lombok.Getter;
import lombok.Setter;

// 목록 조회 필터 조건
@Getter
@Setter
public class HousekeepingSearchConditionDTO {
    private Integer floor;        // 배정 층 필터 (선택 안 하면 null → 전체 조회)
    private String status;        // 상태 필터: 청소대기 / 청소중 / 점검완료 (선택 안 하면 null → 전체 조회)
    private String employeeName;  // 담당자 이름 필터 (현재 화면에는 입력창 없음, 확장 대비 필드만 유지)
}