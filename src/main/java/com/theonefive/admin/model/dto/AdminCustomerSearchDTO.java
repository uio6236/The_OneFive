package com.theonefive.admin.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class AdminCustomerSearchDTO {
	private String keyword;
	private String membershipGrade;
	
	private int page = 1;
	private int size = 8;
	
	public int getOffset() {return (page - 1) * size;}
}