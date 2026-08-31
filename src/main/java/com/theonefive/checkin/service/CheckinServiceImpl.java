package com.theonefive.checkin.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.theonefive.checkin.model.dto.CheckinDTO;
import com.theonefive.checkin.model.mapper.CheckinMapper;
import com.theonefive.housekeeping.model.dto.HousekeepingDTO;
import com.theonefive.housekeeping.model.mapper.HousekeepingMapper;
import com.theonefive.room.model.mapper.RoomMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CheckinServiceImpl implements CheckinService {
	private final CheckinMapper checkinMapper;
	private final RoomMapper roomMapper;
	private final HousekeepingMapper housekeepingMapper;
	// private final ReservationMapper reservationMapper;
	
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
		int roomResult = roomMapper.updateRoomStatus(checkin.getRoomId(), "투숙중");
		return result > 0 && roomResult > 0;
	}
	@Transactional
	@Override
	public boolean checkout(CheckinDTO checkin) {
		// 체크아웃 처리
		int result = checkinMapper.updateCheckout(checkin);
		int roomResult =  roomMapper.updateRoomStatus(checkin.getRoomId(), "청소중");
		HousekeepingDTO housekeeping = new HousekeepingDTO();
		housekeeping.setRoomId((long) checkin.getRoomId());
		housekeeping.setNote("체크아웃 후 청소 요청");

		int housekeepingResult = housekeepingMapper.insertCleaningRequest(housekeeping);

		return result > 0 && roomResult > 0 && housekeepingResult > 0;
		// int reservationResult = reservationMapper.updateReservationStatus(checkin.getReservationId(), "이용완료");
	}
	@Override
	public List<CheckinDTO> getPastCheckinList() {
		return checkinMapper.selectPastCheckinList();
	}
	@Override
	public List<CheckinDTO> getPastCheckoutList() {
		return checkinMapper.selectPastCheckoutList();
	}
}
