package com.theonefive.admin.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.theonefive.admin.model.dto.AdminCustomerSearchDTO;
import com.theonefive.admin.model.mapper.AdminCustomerMapper;
import com.theonefive.customer.model.dto.CustomerDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminCustomerServiceImpl implements AdminCustomerService{
	private final AdminCustomerMapper adminCustomerMapper;
	
	@Override
	public List<CustomerDTO> getCustomerList(AdminCustomerSearchDTO search) {
		// 검색 조건에 맞는 고객 목록 조회
		return adminCustomerMapper.selectCustomerList(search);
	}
	@Override
    public int getCustomerTotalCount(AdminCustomerSearchDTO search) {
		// 검색 조건에 맞는 전체 고객 수 조회
        return adminCustomerMapper.countCustomerList(search);
    }

    @Override
    public CustomerDTO getCustomerById(Long id) {
    	// 고객 ID를 기준으로 고객 상세 정보 조회
        return adminCustomerMapper.selectCustomerById(id);
    }

    @Override
    public void updateCustomer(CustomerDTO dto) {
    	// 관리자 권한으로 고객 정보 수정
        adminCustomerMapper.updateCustomerByAdmin(dto);
    }
}
