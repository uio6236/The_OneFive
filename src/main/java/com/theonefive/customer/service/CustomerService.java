package com.theonefive.customer.service;

import java.io.IOException;

import com.theonefive.customer.model.dto.CustomerDTO;

public interface CustomerService {
	
	// 회원가입: 고객 비밀번호를 암호화하고 회원 정보를 등록
	void signup(CustomerDTO customer) throws IOException;
	
	// 로그인 ID의 중복 여부 확인
	boolean isLoginIdCheck(String loginId);
	
	// 로그인 처리: 아이디와 비밀번호를 검증해 로그인 고객 정보 반환
	CustomerDTO login(String loginId, String password);
	
	// 로그인 ID를 기준으로 고객 정보 조회
	CustomerDTO getCustomerByLoginId(String loginId);
	
	// 회원 정보 및 비밀번호 수정
	boolean updateCustomerInfo(CustomerDTO update);
}
