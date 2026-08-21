package com.theonefive.checkin.service;

import com.theonefive.checkin.model.dto.CheckinDTO;

public interface CheckinService {
	// 체크인 목록 조회
	
	// 체크인 추가
	Long addCheckin(CheckinDTO checkin);
	// 체크인 수정
	CheckinDTO updateCheckin(Long id);
	// 체크인 삭제
	void deleteCheckin(Long id);
}
