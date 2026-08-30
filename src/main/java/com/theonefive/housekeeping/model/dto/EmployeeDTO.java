package com.theonefive.housekeeping.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

// 담당자 배정 드롭다운용 직원 정보
@Getter
@Setter
@NoArgsConstructor
public class EmployeeDTO {
    private Long id;      // EMPLOYEE 테이블의 PK
    private String name;  // 드롭다운에 표시할 직원 이름
}