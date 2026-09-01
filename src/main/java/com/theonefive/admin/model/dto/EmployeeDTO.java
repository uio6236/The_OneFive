package com.theonefive.admin.model.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Alias("AdminEmployeeDTO")
@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EmployeeDTO {
	private int id;
	private String code;
	private String name;
	private String password;
	private String position;
	private String phone;
	private String email;
}
