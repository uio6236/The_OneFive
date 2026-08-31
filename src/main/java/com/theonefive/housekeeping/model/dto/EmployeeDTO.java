package com.theonefive.housekeeping.model.dto;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 담당자 배정 드롭다운용 직원 정보
@Alias("HousekeepingEmployeeDTO")
@Getter
@Setter
@NoArgsConstructor
public class EmployeeDTO {
    private Long id;      // EMPLOYEE 테이블의 PK
    private String name;  // 드롭다운에 표시할 직원 이름
}