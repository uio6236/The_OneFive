package com.theonefive.housekeeping.model.mapper;

import com.theonefive.housekeeping.model.dto.EmployeeDTO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

// 담당자 배정 드롭다운을 위한 EMPLOYEE 전체 목록 조회 Mapper
@Mapper
public interface HouseEmployeeMapper {
	// 하우스키핑 업무에 배정 가능한 전체 직원 조회
    List<EmployeeDTO> selectAll();
}