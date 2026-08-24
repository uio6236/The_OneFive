package com.theonefive.checkin.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.theonefive.checkin.model.dto.CheckinDTO;

@Mapper
public interface CheckinMapper {
	// 금일 체크인 예정
	List<CheckinDTO> selectTodayCheckinList();
	
	// 금일 체크아웃 예정
	List<CheckinDTO> selectTodayCheckoutList();
	
	// 체크인 상세
	CheckinDTO selectCheckinDetail(int reservationId);
	
	// 실제 체크인 기록 생성
	int insertCheckin(CheckinDTO checkin);
	
	// 체크아웃 처리
	int updateCheckout(CheckinDTO checkin);
	
	// 체크인 기록 조회
	CheckinDTO selectCheckinById(int checkinId);
}
