package com.theonefive.admin.service;

import java.io.IOException;

import com.theonefive.admin.model.dto.EmployeeDTO;

public interface AdminService {
	// 관리자 비밀번호를 암호화하고 계정 등록
	void signup(EmployeeDTO employee) throws IOException;

	// 사번과 비밀번호를 검증해 관리자 로그인 정보 반환
	EmployeeDTO code(String code, String password);
	
	// 관리자 사번의 중복 여부 확인
	boolean isCodeCheck(String code);
}
