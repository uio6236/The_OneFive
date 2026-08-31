package com.theonefive.admin.service;

import java.io.IOException;

import com.theonefive.admin.model.dto.EmployeeDTO;

public interface AdminService {

	void signup(EmployeeDTO employee) throws IOException;

	EmployeeDTO code(String code, String password);
	
	boolean isCodeCheck(String code);
}
