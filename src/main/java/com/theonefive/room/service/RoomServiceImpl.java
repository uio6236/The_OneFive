package com.theonefive.room.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.theonefive.room.model.dto.RoomDTO;
import com.theonefive.room.model.mapper.RoomMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RoomServiceImpl implements RoomService{
	private final RoomMapper roomMapper;
	
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
	public List<RoomDTO> searchRooms(int floor, String status) {
		// 층/상태 조건 조회
		return roomMapper.selectRoomByFilter(floor, status);
	}

	@Override
	public List<RoomDTO> getAvailableRooms(int roomTypeId) {
		// 체크인 가능 객실 조회
		return roomMapper.selectAvailableRooms(roomTypeId);
	}

	@Override
	public boolean changeroomStatus(int roomId, String status) {
		// 객실 상태 변경
		return roomMapper.updateRoomStatus(roomId, status) > 0;
	}

}
