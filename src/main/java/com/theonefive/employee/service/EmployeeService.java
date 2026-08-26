package com.theonefive.employee.service;

import com.theonefive.employee.model.dto.EmployeeDTO;

public interface EmployeeService {
	 
    EmployeeDTO getEmployee(Long id);
 
    void updateEmployeeInfo(EmployeeDTO dto);
 
    // 성공하면 true, 현재 비밀번호가 틀리거나 새 비밀번호 확인이 안 맞으면 false
    boolean changePassword(Long id, String currentPassword, String newPassword, String newPasswordCheck);
}
 