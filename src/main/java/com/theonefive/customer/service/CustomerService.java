package com.theonefive.customer.service;

import java.io.IOException;

import com.theonefive.customer.model.dto.CustomerDTO;

public interface CustomerService {
	
	// 회원가입
	void signup(CustomerDTO customer) throws IOException;
	
	// 아이디 중복 확인
	boolean isLoginIdCheck(String loginId);
	
	//로그인 처리
	CustomerDTO login(String loginId, String password);
	
	//회원 정보
	CustomerDTO getCustomerByLoginId(String loginId);
	
	//회원 정보 및 비밀번호 수정
	boolean updateCustomerInfo(CustomerDTO update);
}
