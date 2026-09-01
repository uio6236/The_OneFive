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
		return adminCustomerMapper.selectCustomerList(search);
	}
	@Override
    public int getCustomerTotalCount(AdminCustomerSearchDTO search) {
        return adminCustomerMapper.countCustomerList(search);
    }

    @Override
    public CustomerDTO getCustomerById(Long id) {
        return adminCustomerMapper.selectCustomerById(id);
    }

    @Override
    public void updateCustomer(CustomerDTO dto) {
        adminCustomerMapper.updateCustomerByAdmin(dto);
    }
}
