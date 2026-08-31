package com.theonefive.housekeeping.model.dto;

import lombok.Getter;
import lombok.Setter;
import java.util.List;

// 청소 시작/완료, 점검 완료 요청 바디 (세 API가 공통으로 사용)
@Getter
@Setter
public class StatusChangeDTO {
    private List<Long> ids;  // 상태를 변경할 HOUSEKEEPING id 목록
}