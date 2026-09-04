package com.theonefive.checkin.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.theonefive.checkin.model.dto.CheckinDTO;

@Mapper
public interface CheckinMapper {
	// 금일 체크인 예정 예약 목록 조회
	List<CheckinDTO> selectTodayCheckinList();
	
	// 금일 체크아웃 예정 투숙객 목록 조회
	List<CheckinDTO> selectTodayCheckoutList();
	
	// 지난 미처리 체크인 예약 목록 조회
	List<CheckinDTO> selectPastCheckinList();

	// 지난 미처리 체크아웃 목록 조회
	List<CheckinDTO> selectPastCheckoutList();
	
	// 예약 ID를 기준으로 체크인 상세 정보 조회
	CheckinDTO selectCheckinDetail(int reservationId);
	
	// 체크인 상태 테이블에 체크인 정보 등록
	int insertCheckin(CheckinDTO checkin);
	
	// 체크인 기록에 실제 체크아웃 시간 등록
	int updateCheckout(CheckinDTO checkin);
}
