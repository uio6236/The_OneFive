package com.theonefive.customer.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class CustomerDTO {
	private Integer id;
	private String loginId;
	private String password;
	private String newPassword;
	private String name;
	private String phone;
	private String email;
	private String membershipGrade;
	private Integer totalVisitCount;
	private String memo;
	

}
