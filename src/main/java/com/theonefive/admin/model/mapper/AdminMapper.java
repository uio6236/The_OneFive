package com.theonefive.admin.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.theonefive.admin.model.dto.EmployeeDTO;

@Mapper
public interface AdminMapper {
	// 동일한 관리자 사번의 존재 여부 조회
	int countByCode(String code);

	// 사번을 기준으로 관리자 정보 조회
	EmployeeDTO selectEmployeeByCode(String code);
	
	// 신규 관리자 정보 등록
	int insertEmployee(EmployeeDTO employee);
}
