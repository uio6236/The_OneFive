package com.theonefive.admin.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.theonefive.admin.model.dto.EmployeeDTO;

@Mapper
public interface AdminMapper {
	
	int countByCode(String code);

	// 아이디로 회원 상세정보 조회
	EmployeeDTO selectEmployeeByCode(String code);
	
	// 회원가입 데이터 저장
	int insertEmployee(EmployeeDTO employee);
}
