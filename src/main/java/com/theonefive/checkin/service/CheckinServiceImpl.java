package com.theonefive.checkin.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.theonefive.checkin.model.dto.CheckinDTO;
import com.theonefive.checkin.model.mapper.CheckinMapper;
import com.theonefive.customer.model.mapper.CustomerMapper;
import com.theonefive.housekeeping.model.dto.HousekeepingDTO;
import com.theonefive.housekeeping.model.mapper.HousekeepingMapper;
import com.theonefive.reservation.model.mapper.ReservationMapper;
import com.theonefive.room.model.mapper.RoomMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CheckinServiceImpl implements CheckinService {
	private final CheckinMapper checkinMapper;
	private final RoomMapper roomMapper;
	private final HousekeepingMapper housekeepingMapper;
	private final CustomerMapper customerMapper;
	private final ReservationMapper reservationMapper;
	
	@Override
	public List<CheckinDTO> getTodayCheckinList() {
		// 금일 체크인 예정 목록 조회
		return checkinMapper.selectTodayCheckinList();
	}
	@Override
	public List<CheckinDTO> getTodayCheckoutList() {
		// 금일 체크아웃 예정 목록 조회
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
		// 체크인 처리(실제 체크인 기록 생성)
		int checkinResult = checkinMapper.insertCheckin(checkin);
		int roomResult = roomMapper.updateRoomStatus(checkin.getRoomId(), "투숙중");
	    if (checkinResult == 0 || roomResult == 0) {throw new IllegalStateException("체크인 연동 처리에 실패했습니다.");}
	    
	    return true;
	}
	@Transactional
	@Override
	public boolean checkout(CheckinDTO checkin) {
		// 체크아웃 처리
		int checkoutResult = checkinMapper.updateCheckout(checkin);
		if (checkoutResult == 0) {throw new IllegalStateException("이미 체크아웃되었거나 존재하지 않는 체크인 기록입니다.");}
		
	    int reservationResult = reservationMapper.completeReservationByCheckinId(checkin.getId());
	    
		int roomResult =  roomMapper.updateRoomStatus(checkin.getRoomId(), "청소중");
		
		HousekeepingDTO housekeeping = new HousekeepingDTO();
		housekeeping.setRoomId((long) checkin.getRoomId());
		housekeeping.setNote("체크아웃 후 청소 요청");
		int housekeepingResult = housekeepingMapper.insertCleaningRequest(housekeeping);
		
		int customerResult = customerMapper.increaseVisitCountAndPromote(checkin.getId());
		if (reservationResult == 0 || roomResult == 0 || housekeepingResult == 0 || customerResult == 0) {
	        throw new IllegalStateException("체크아웃 연동 처리에 실패했습니다.");
	    }

	    return true;
	}
	@Override
	public List<CheckinDTO> getPastCheckinList() {
		// 지난 체크인 미처리 목록 조회
		return checkinMapper.selectPastCheckinList();
	}
	@Override
	public List<CheckinDTO> getPastCheckoutList() {
		// 지난 체크아웃 미처리 목록 조회
		return checkinMapper.selectPastCheckoutList();
	}
}
