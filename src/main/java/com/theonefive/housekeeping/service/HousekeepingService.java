package com.theonefive.housekeeping.service;

import com.theonefive.housekeeping.model.dto.EmployeeDTO;
import com.theonefive.housekeeping.model.dto.HousekeepingDTO;
import com.theonefive.housekeeping.model.dto.HousekeepingSearchConditionDTO;
import com.theonefive.housekeeping.model.dto.StatusCountDTO;
import java.util.List;

public interface HousekeepingService {
	
	// 하우스키핑 업무 로직 인터페이스
    List<HousekeepingDTO> getList(HousekeepingSearchConditionDTO condition);
    HousekeepingDTO getDetail(Long id);
    List<StatusCountDTO> getStatusCount();

    List<Long> assignEmployee(List<Long> ids, Long employeeId);
    List<Long> startCleaning(List<Long> ids);
    List<Long> completeCleaning(List<Long> ids);
    List<Long> inspect(List<Long> ids);

    void updateNote(Long id, String note);

    // 담당자 배정 드롭다운을 채우기 위한 전체 직원 목록 조회
    List<EmployeeDTO> getEmployees();
}