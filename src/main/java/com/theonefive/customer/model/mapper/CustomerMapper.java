package com.theonefive.customer.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.theonefive.customer.model.dto.CustomerDTO;

@Mapper
public interface CustomerMapper {
	// 아이디 중복 개수 조회 ??
	int countByLoginId(String loginId);
	
	// 아이디로 회원 상세정보 조회
	CustomerDTO selectCustomerByLoginId(String loginId);
	
	// 회원가입 데이터 저장
	int insertCustomer(CustomerDTO customer);
	
}
