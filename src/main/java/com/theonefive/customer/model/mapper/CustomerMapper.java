package com.theonefive.customer.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.theonefive.customer.model.dto.CustomerDTO;
/* SQL문의 행의 개수를 반환하기 때문에 int 사용 */
@Mapper
public interface CustomerMapper {
	// 동일한 로그인 ID의 존재 여부 조회
	int countByLoginId(String loginId);
	
	// 동일한 로그인 ID의 존재 여부 조회
	CustomerDTO selectCustomerByLoginId(String loginId);
	
	// 신규 고객 정보 등록
	int insertCustomer(CustomerDTO customer);
	
	// 고객 기본 정보 수정
	int updateCustomer(CustomerDTO customer);
	
	// 고객 비밀번호 변경
	int updatePassword(CustomerDTO customer);
	
	// 체크아웃 고객의 방문 횟수를 증가시키고 조건 충족 시 등급 승급
	int increaseVisitCountAndPromote(int checkinId);
}
