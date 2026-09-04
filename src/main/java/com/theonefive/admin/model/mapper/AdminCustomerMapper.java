package com.theonefive.admin.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.theonefive.admin.model.dto.AdminCustomerSearchDTO;
import com.theonefive.customer.model.dto.CustomerDTO;

@Mapper
public interface AdminCustomerMapper {
	// 검색 조건에 맞는 고객 목록 조회
	List<CustomerDTO> selectCustomerList(AdminCustomerSearchDTO search);
	
	// 검색 조건에 맞는 고객 수 조회
	int countCustomerList(AdminCustomerSearchDTO search);
	
	// 고객 ID로 고객 상세 조회
	CustomerDTO selectCustomerById(@Param("id") Long id);
	
	// 관리자가 고객 정보 수정
	int updateCustomerByAdmin(CustomerDTO dto);
}