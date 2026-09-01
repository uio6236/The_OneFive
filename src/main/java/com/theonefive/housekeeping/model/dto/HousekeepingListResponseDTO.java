package com.theonefive.housekeeping.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.util.List;

// 폴링 API(GET /api/housekeeping/list) 응답 바디
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class HousekeepingListResponseDTO {
    private List<HousekeepingDTO> list;         // 표에 뿌릴 하우스키핑 목록
    private List<StatusCountDTO> statusCounts;  // 카드에 뿌릴 상태별 건수 (항상 3개, 고정 순서)
}