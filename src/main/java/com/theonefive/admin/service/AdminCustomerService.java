package com.theonefive.admin.service;

import java.util.List;

import com.theonefive.admin.model.dto.AdminCustomerSearchDTO;
import com.theonefive.customer.model.dto.CustomerDTO;

public interface AdminCustomerService {
	// 검색 조건에 맞는 고객 목록 조회
	List<CustomerDTO> getCustomerList(AdminCustomerSearchDTO search);
	
	// 검색 조건에 맞는 전체 고객 수 조회
	int getCustomerTotalCount(AdminCustomerSearchDTO search);
	
	// 고객 ID를 기준으로 고객 상세 정보 조회
	CustomerDTO getCustomerById(Long id);
	
	// 관리자 권한으로 고객 정보 수정
	void updateCustomer(CustomerDTO dto);
}
