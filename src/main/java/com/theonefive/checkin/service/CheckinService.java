package com.theonefive.checkin.service;

import java.util.List;

import com.theonefive.checkin.model.dto.CheckinDTO;

public interface CheckinService {
	// 금일 체크인 예정 고객 목록 조회
	List<CheckinDTO> getTodayCheckinList();

	// 체크인 예정일이 지났지만 아직 체크인하지 않은 고객 목록 조회
	List<CheckinDTO> getPastCheckinList();

	// 금일 체크아웃 예정 고객 목록 조회
	List<CheckinDTO> getTodayCheckoutList();

	// 체크아웃 예정일이 지났지만 아직 체크아웃하지 않은 고객 목록 조회
	List<CheckinDTO> getPastCheckoutList();
	
	// 예약번호를 기준으로 체크인 상세 정보 조회
	CheckinDTO getCheckinDetail(int reservationId);
		
	// 체크인 정보를 등록하고 해당 객실을 투숙중 상태로 변경
	boolean checkin(CheckinDTO checkin);
	
	// 체크아웃 처리와 관련 테이블의 후속 업무를 하나의 트랜잭션으로 처리
	boolean checkout(CheckinDTO checkin);
}