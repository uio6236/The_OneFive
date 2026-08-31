package com.theonefive.housekeeping.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import java.util.Date;

// 하우스키핑 목록/상세 조회 결과를 담는 DTO
@Getter
@Setter
@NoArgsConstructor
public class HousekeepingDTO {

    private Long id;              // HOUSEKEEPING 테이블의 PK
    private Long roomId;          // 객실 ID (ROOM FK)
    private Long employeeId;      // 담당자 ID (EMPLOYEE FK)
    private String status;        // 청소대기 / 청소중 / 점검완료
    private Date requestedAt;     // 청소 요청 시각
    private Date startedAt;       // 청소 시작 시각
    private Date completedAt;     // 청소 완료 시각 (점검 대기 여부 판단에 사용)
    private Date inspectedAt;     // 점검 완료 시각
    private String note;          // 비고 / 전달사항
    private String roomNum;       // 객실 번호
    private Integer floor;        // 층
    private String typeName;      // 객실 타입명
    private String employeeName;  // 담당자 이름
}