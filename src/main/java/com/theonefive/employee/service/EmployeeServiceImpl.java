package com.theonefive.employee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.theonefive.employee.model.dto.EmployeeDTO;
import com.theonefive.employee.model.mapper.EmployeeMapper;


@Service
public class EmployeeServiceImpl implements EmployeeService {
 
    @Autowired
    private EmployeeMapper employeeMapper;
 
    // SecurityConfig에 이미 Bean으로 등록되어 있어서 그대로 주입받아 쓰면 됨
    @Autowired
    private PasswordEncoder passwordEncoder;
 
    @Override
    public EmployeeDTO getEmployee(Long id) {
        return employeeMapper.selectEmployeeById(id);
    }
 
    // 이름: 한글/영문/공백만 허용 (숫자, 특수문자 금지)
    private static final java.util.regex.Pattern NAME_PATTERN =
            java.util.regex.Pattern.compile("^[가-힣a-zA-Z\\s]+$");
 
    // 연락처: 숫자와 하이픈(-)만 허용
    private static final java.util.regex.Pattern PHONE_PATTERN =
            java.util.regex.Pattern.compile("^[0-9-]+$");
 
    @Override
    public String updateEmployeeInfo(EmployeeDTO dto) {
 
        if (!StringUtils.hasText(dto.getName()) || !NAME_PATTERN.matcher(dto.getName()).matches()) {
            return "이름에는 숫자나 특수문자를 입력할 수 없습니다.";
        }
 
        if (!StringUtils.hasText(dto.getPhone()) || !PHONE_PATTERN.matcher(dto.getPhone()).matches()) {
            return "연락처에는 숫자와 '-'만 입력할 수 있습니다.";
        }
 
        int duplicated = employeeMapper.countEmployeeByEmailExcludingSelf(dto.getEmail(), dto.getId());
        if (duplicated > 0) {
            return "이미 사용 중인 이메일입니다. 다른 이메일을 입력해주세요.";
        }
 
        employeeMapper.updateEmployeeInfo(dto);
        return null;
    }
 
    @Override
    public String changePassword(Long id, String currentPassword, String newPassword, String newPasswordCheck) {
 
        // 비밀번호 변경 폼을 아예 안 건드렸으면 그냥 통과 (성공 취급)
        if (!StringUtils.hasText(newPassword) && !StringUtils.hasText(newPasswordCheck)) {
            return null;
        }
 
        // 새 비밀번호 확인이 안 맞으면 실패
        if (!StringUtils.hasText(newPassword) || !newPassword.equals(newPasswordCheck)) {
            return "새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.";
        }
 
        // 현재 저장된(암호화된) 비밀번호를 가져와서 BCrypt로 비교
        EmployeeDTO employee = employeeMapper.selectEmployeeById(id);
        if (employee == null || !passwordEncoder.matches(currentPassword, employee.getPassword())) {
            return "현재 비밀번호가 일치하지 않습니다.";
        }
 
        // 새 비밀번호가 기존 비밀번호와 같은지 확인
        if (passwordEncoder.matches(newPassword, employee.getPassword())) {
            return "새 비밀번호가 기존 비밀번호와 동일합니다. 다른 비밀번호를 입력해주세요.";
        }
 
        // 새 비밀번호도 암호화해서 저장
        String encodedNewPassword = passwordEncoder.encode(newPassword);
        employeeMapper.updatePassword(id, encodedNewPassword);
        return null;
    }
}
 