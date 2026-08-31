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
	public List<RoomDTO> getRoomByFloor(int floor) {
		// 층별 조회
		return roomMapper.selectRoomByFloor(floor);
	}

	@Override
	public List<RoomDTO> getAvailableRooms(int roomTypeId) {
		// 체크인 가능 객실 조회
		return roomMapper.selectAvailableRooms(roomTypeId);
	}
}
