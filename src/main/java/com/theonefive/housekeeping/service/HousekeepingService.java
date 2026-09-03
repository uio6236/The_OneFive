package com.theonefive.housekeeping.service;

import com.theonefive.housekeeping.model.dto.EmployeeDTO;
import com.theonefive.housekeeping.model.dto.HousekeepingDTO;
import com.theonefive.housekeeping.model.dto.HousekeepingSearchConditionDTO;
import com.theonefive.housekeeping.model.dto.StatusCountDTO;
import java.util.List;

public interface HousekeepingService {
	
	// 조건에 따른 하우스키핑 작업 목록 조회
    List<HousekeepingDTO> getList(HousekeepingSearchConditionDTO condition);
    
    // 하우스키핑 작업 상세 정보 조회    
    HousekeepingDTO getDetail(Long id);
    
    // 하우스키핑 상태별 작업 건수 조회
    List<StatusCountDTO> getStatusCount();
   
    List<Long> assignEmployee(List<Long> ids, Long employeeId);
    
    // 선택한 작업을 청소중으로 변경하고 객실 상태를 청소중으로 변경
    List<Long> startCleaning(List<Long> ids);
    
    // 청소 완료 시간을 기록하고 객실 상태를 점검중으로 변경
    List<Long> completeCleaning(List<Long> ids);
    
    // 점검 완료 처리 후 객실 상태를 이용가능으로 변경
    List<Long> inspect(List<Long> ids);

    // 하우스키핑 작업 메모 수정
    void updateNote(Long id, String note);

    // 담당자 배정 드롭다운을 채우기 위한 전체 직원 목록 조회
    List<EmployeeDTO> getEmployees();
}