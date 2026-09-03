package com.theonefive.checkin.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.theonefive.checkin.model.dto.CheckinDTO;

@Mapper
public interface CheckinMapper {
	// 금일 체크인 예정 목록 조회
	List<CheckinDTO> selectTodayCheckinList();
	
	// 금일 체크아웃 예정 목록 조회
	List<CheckinDTO> selectTodayCheckoutList();
	
	// 지난 체크인 미처리 목록 조회
	List<CheckinDTO> selectPastCheckinList();

	// 지난 체크아웃 미처리 목록 조회
	List<CheckinDTO> selectPastCheckoutList();
	
	// 체크인 상세 정보 조회
	CheckinDTO selectCheckinDetail(int reservationId);
	
	// 체크인 처리(실제 체크인 기록 생성)
	int insertCheckin(CheckinDTO checkin);
	
	// 체크아웃 처리
	int updateCheckout(CheckinDTO checkin);
}
