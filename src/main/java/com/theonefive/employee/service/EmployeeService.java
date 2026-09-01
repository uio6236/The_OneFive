package com.theonefive.employee.service;

import com.theonefive.employee.model.dto.EmployeeDTO;

public interface EmployeeService {
	 
    EmployeeDTO getEmployee(Long id);
 
    // 이메일이 이미 다른 직원 것과 중복되면 false, 저장 성공하면 true
    boolean updateEmployeeInfo(EmployeeDTO dto);
 
    // 성공하면 null, 실패하면 구체적인 실패 사유 메시지를 리턴
    String changePassword(Long id, String currentPassword, String newPassword, String newPasswordCheck);
}
 