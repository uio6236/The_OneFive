package com.theonefive.checkin.service;

import java.util.List;

import com.theonefive.checkin.model.dto.CheckinDTO;

public interface CheckinService {
	// 금일 체크인 예정
	List<CheckinDTO> getTodayCheckinList();
		
	// 금일 체크아웃 예정
	List<CheckinDTO> getTodayCheckoutList();
	
	// 체크인 상세
	CheckinDTO getCheckinDetail(int reservationId);
		
	// 체크인 처리
	boolean checkin(CheckinDTO checkin);
	
	// 체크아웃 처리
	boolean checkout(CheckinDTO checkin);
}
