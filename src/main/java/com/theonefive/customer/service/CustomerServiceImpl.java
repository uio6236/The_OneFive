package com.theonefive.customer.service;

import java.io.IOException;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.theonefive.customer.model.dto.CustomerDTO;
import com.theonefive.customer.model.mapper.CustomerMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomerServiceImpl implements CustomerService {
	
	private final CustomerMapper customerMapper;
	
	private final PasswordEncoder passwordEncoder;
	
	public void signup(CustomerDTO customer) throws IOException {
		
		if(isLoginIdCheck(customer.getLoginId())) {
			throw new IllegalStateException("이미 사용 중인 아이디입니다.");
		}
		
		String encodePwd = passwordEncoder.encode(customer.getPassword());
		customer.setPassword(encodePwd);
		
		customerMapper.insertCustomer(customer);
	}
	
	@Override
    public boolean isLoginIdCheck(String loginId) {
        // CustomerMapper.xml에 작성해 두신 countByLoginId를 호출하여 0보다 크면 중복으로 판단
        return customerMapper.countByLoginId(loginId) > 0;
    }
	
	@Override
	public CustomerDTO login(String loginId, String password) throws IllegalStateException {
		// 아이디를 기준으로 회원 정보 조회
		CustomerDTO customer = customerMapper.selectCustomerByLoginId(loginId);
		
		// 조회된 정보 중 암호문과 전달된 평문이 일지하는지 확인
		if (customer == null || !passwordEncoder.matches(password, customer.getPassword())) {
			throw new IllegalStateException("아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		
		return customer;
	
	}
}
