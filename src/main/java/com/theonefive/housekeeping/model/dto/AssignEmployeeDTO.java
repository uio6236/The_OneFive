package com.theonefive.housekeeping.model.dto;

import lombok.Getter;
import lombok.Setter;
import java.util.List;

// 담당자 배정 요청 바디
@Getter
@Setter
public class AssignEmployeeDTO {
    private List<Long> ids;    // 담당자를 배정할 HOUSEKEEPING id 목록 (현재 화면은 항상 1개짜리 배열만 전송)
    private Long employeeId;   // 배정할 담당자의 EMPLOYEE.ID
}