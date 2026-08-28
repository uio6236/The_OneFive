package com.theonefive.employee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.theonefive.employee.model.dto.EmployeeDTO;
import com.theonefive.employee.model.mapper.EmployeeMapper;

@Service
public class EmployeeServiceImpl implements EmployeeService {
 
    @Autowired
    private EmployeeMapper employeeMapper;
 
    @Override
    public EmployeeDTO getEmployee(Long id) {
        return employeeMapper.selectEmployeeById(id);
    }
 
    @Override
    public boolean updateEmployeeInfo(EmployeeDTO dto) {
 
        int duplicated = employeeMapper.countEmployeeByEmailExcludingSelf(dto.getEmail(), dto.getId());
        if (duplicated > 0) {
            return false;   // 이미 다른 직원이 쓰는 이메일 -> 저장 안 하고 실패로 리턴
        }
 
        employeeMapper.updateEmployeeInfo(dto);
        return true;
    }
 
    @Override
    public boolean changePassword(Long id, String currentPassword, String newPassword, String newPasswordCheck) {
 
        // 비밀번호 변경 폼을 아예 안 건드렸으면 그냥 통과 (변경 안 함)
        if (!StringUtils.hasText(newPassword) && !StringUtils.hasText(newPasswordCheck)) {
            return true;
        }
 
        // 새 비밀번호 확인이 안 맞으면 실패
        if (!newPassword.equals(newPasswordCheck)) {
            return false;
        }
 
        // 현재 비밀번호가 틀리면 실패
        int matched = employeeMapper.countEmployeeWithPassword(id, currentPassword);
        if (matched == 0) {
            return false;
        }
 
        employeeMapper.updatePassword(id, newPassword);
        return true;
    }
}
 