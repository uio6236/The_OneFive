package com.theonefive.checkin.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.theonefive.checkin.model.dto.CheckinDTO;
import com.theonefive.checkin.model.mapper.CheckinMapper;
import com.theonefive.room.model.mapper.RoomMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CheckinServiceImpl implements CheckinService {
	private final CheckinMapper checkinMapper;
	private final RoomMapper roomMapper;
	// private final HousekeepingMapper housekeepingMapper;
	
	@Override
	public List<CheckinDTO> getTodayCheckinList() {
		// 금일 체크인 예정
		return checkinMapper.selectTodayCheckinList();
	}
	@Override
	public List<CheckinDTO> getTodayCheckoutList() {
		// 금일 체크아웃 예정
		return checkinMapper.selectTodayCheckoutList();
	}
	@Override
	public CheckinDTO getCheckinDetail(int reservationId) {
		// 체크인 상세
		return checkinMapper.selectCheckinDetail(reservationId);
	}
	@Transactional
	@Override
	public boolean checkin(CheckinDTO checkin) {
		// 체크인 처리
		int result = checkinMapper.insertCheckin(checkin);
		roomMapper.updateRoomStatus(checkin.getRoomId(), "투숙중");
		return result > 0;
	}
	@Transactional
	@Override
	public boolean checkout(CheckinDTO checkin) {
		// 체크아웃 처리
		int result = checkinMapper.updateCheckout(checkin);
		roomMapper.updateRoomStatus(checkin.getRoomId(), "청소중");
		// housekeepingMapper.updateStatus(checkin.getRoomId(), "청소대기");
		return result > 0;
	}
}
