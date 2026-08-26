package com.theonefive.employee.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.theonefive.employee.model.dto.EmployeeDTO;

@Mapper
public interface EmployeeMapper {
 
    // 직원 정보 조회 (마이페이지 표시용)
    EmployeeDTO selectEmployeeById(Long id);
 
    // 이름/연락처/이메일 수정
    int updateEmployeeInfo(EmployeeDTO dto);
 
    // 현재 비밀번호가 맞는지 확인 (일치하면 1, 아니면 0)
    int countEmployeeWithPassword(@Param("id") Long id, @Param("password") String password);
 
    // 비밀번호 변경
    int updatePassword(@Param("id") Long id, @Param("newPassword") String newPassword);
}