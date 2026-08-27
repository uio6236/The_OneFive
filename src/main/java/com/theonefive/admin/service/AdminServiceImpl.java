package com.theonefive.admin.service;

import java.io.IOException;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.theonefive.admin.model.dto.EmployeeDTO;
import com.theonefive.admin.model.mapper.AdminMapper;


import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {

		private final AdminMapper adminMapper;
		
		private final PasswordEncoder passwordEncoder;
	@Override
	public void signup(EmployeeDTO employee) throws IOException {
		
		if(isCodeCheck(employee.getCode())) {
			throw new IllegalStateException("이미 사용 중인 사번입니다.");
		}
		
		String encodePwd = passwordEncoder.encode(employee.getPassword());
		employee.setPassword(encodePwd);
		
		adminMapper.insertEmployee(employee);
	}
	
	@Override
    public boolean isCodeCheck(String code) {
        // CustomerMapper.xml에 작성해 두신 countByLoginId를 호출하여 0보다 크면 중복으로 판단
        return adminMapper.countByCode(code) > 0;
    }
	
	@Override
	public EmployeeDTO code(String code, String password) throws IllegalStateException {
		// 아이디를 기준으로 회원 정보 조회
		EmployeeDTO employee = adminMapper.selectEmployeeByCode(code);
		
		// 조회된 정보 중 암호문과 전달된 평문이 일지하는지 확인
		if (employee == null || !passwordEncoder.matches(password, employee.getPassword())) {
			throw new IllegalStateException("아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		
		return employee;
	
	}
}
