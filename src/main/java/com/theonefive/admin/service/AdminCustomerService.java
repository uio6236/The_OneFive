package com.theonefive.admin.service;

import java.util.List;

import com.theonefive.admin.model.dto.AdminCustomerSearchDTO;
import com.theonefive.customer.model.dto.CustomerDTO;

public interface AdminCustomerService {
	List<CustomerDTO> getCustomerList(AdminCustomerSearchDTO search);
	
	int getCustomerTotalCount(AdminCustomerSearchDTO search);
	
	CustomerDTO getCustomerById(Long id);
	
	void updateCustomer(CustomerDTO dto);
}
