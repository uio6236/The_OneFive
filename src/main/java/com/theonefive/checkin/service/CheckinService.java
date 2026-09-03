package com.theonefive.checkin.service;

import java.util.List;

import com.theonefive.checkin.model.dto.CheckinDTO;

public interface CheckinService {
	// 금일 체크인 예정 목록 조회
	List<CheckinDTO> getTodayCheckinList();

	// 지난 체크인 미처리 목록 조회
	List<CheckinDTO> getPastCheckinList();

	// 금일 체크아웃 예정 목록 조회
	List<CheckinDTO> getTodayCheckoutList();

	// 지난 체크아웃 미처리 목록 조회
	List<CheckinDTO> getPastCheckoutList();
	
	// 체크인 상세 정보 조회
	CheckinDTO getCheckinDetail(int reservationId);
		
	// 체크인 처리(실제 체크인 기록 생성)
	boolean checkin(CheckinDTO checkin);
	
	// 체크아웃 처리
	boolean checkout(CheckinDTO checkin);
}