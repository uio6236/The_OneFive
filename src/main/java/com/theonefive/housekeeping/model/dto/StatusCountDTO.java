package com.theonefive.housekeeping.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

// 상태별 건수 카드용 DTO
@Getter
@Setter
@NoArgsConstructor
public class StatusCountDTO {
    private String status;  // 청소대기 / 청소중 / 점검완료
    private int count;      // 해당 상태의 객실 건수
}