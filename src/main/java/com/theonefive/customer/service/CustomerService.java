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
}
