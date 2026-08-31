package com.theonefive.admin.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.theonefive.admin.model.dto.AdminCustomerSearchDTO;
import com.theonefive.customer.model.dto.CustomerDTO;

@Mapper
public interface AdminCustomerMapper {
	List<CustomerDTO> selectCustomerList(AdminCustomerSearchDTO search);
	
	int countCustomerList(AdminCustomerSearchDTO search);
	
	CustomerDTO selectCustomerById(@Param("id") Long id);
	
	int updateCustomerByAdmin(CustomerDTO dto);
}
