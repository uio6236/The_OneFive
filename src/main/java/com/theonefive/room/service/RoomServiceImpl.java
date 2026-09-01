package com.theonefive.room.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.theonefive.housekeeping.model.dto.HousekeepingDTO;
import com.theonefive.housekeeping.model.mapper.HousekeepingMapper;
import com.theonefive.room.model.dto.RoomDTO;
import com.theonefive.room.model.mapper.RoomMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RoomServiceImpl implements RoomService{
	private final RoomMapper roomMapper;
	private final HousekeepingMapper housekeepingMapper;
	
	@Override
	public List<RoomDTO> getRoomList() {
		// 전체 객실 조회
		return roomMapper.selectRoomList();
	}

	@Override
	public RoomDTO getRoomDetail(int roomId) {
		// 객실 상세 조회
		return roomMapper.selectRoomById(roomId);
	}

	@Override
	public List<RoomDTO> getRoomByFloor(int floor) {
		// 층별 조회
		return roomMapper.selectRoomByFloor(floor);
	}

	@Override
	public List<RoomDTO> getAvailableRooms(int roomTypeId) {
		// 체크인 가능 객실 조회
		return roomMapper.selectAvailableRooms(roomTypeId);
	}

	@Transactional
	@Override
	public boolean requestMaintenance(int roomId, String note) {
		int roomResult = roomMapper.updateRoomStatus(roomId, "청소중");

		HousekeepingDTO housekeeping = new HousekeepingDTO();
		housekeeping.setRoomId((long) roomId);
		housekeeping.setNote(note);

		int housekeepingResult =
			housekeepingMapper.insertCleaningRequest(housekeeping);

		return roomResult > 0 && housekeepingResult > 0;
	}
}
