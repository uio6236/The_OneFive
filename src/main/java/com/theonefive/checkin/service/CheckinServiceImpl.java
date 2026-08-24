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
	
	@Override
	public List<CheckinDTO> getTodayCheckinList() {
		// TODO Auto-generated method stub
		return checkinMapper.selectTodayCheckinList();
	}
	@Override
	public List<CheckinDTO> getTodayCheckoutList() {
		// TODO Auto-generated method stub
		return checkinMapper.selectTodayCheckoutList();
	}
	@Override
	public CheckinDTO getCheckinDatail(int reservationId) {
		// TODO Auto-generated method stub
		return checkinMapper.selectCheckinDetail(reservationId);
	}
	@Transactional
	@Override
	public boolean checkin(CheckinDTO checkin) {
		// TODO Auto-generated method stub
		return false;
	}
	@Transactional
	@Override
	public boolean checkout(CheckinDTO checkin) {
		// TODO Auto-generated method stub
		return false;
	}
}
