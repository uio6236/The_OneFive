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
		// TODO Auto-generated method stub
		return roomMapper.selectRoomList();
	}

	@Override
	public RoomDTO getRoomDetail(int roomId) {
		// TODO Auto-generated method stub
		return roomMapper.selectRoomById(roomId);
	}

	@Override
	public List<RoomDTO> searchRooms(Integer floor, String status) {
		// TODO Auto-generated method stub
		return roomMapper.selectRoomByFilter(floor, status);
	}

	@Override
	public List<RoomDTO> getAvailableRooms(int roomTypeId) {
		// TODO Auto-generated method stub
		return roomMapper.selectAvailableRooms(roomTypeId);
	}

	@Override
	public boolean changeroomStatus(int roomId, String status) {
		// TODO Auto-generated method stub
		return roomMapper.updateRoomStatus(roomId, status) > 0;
	}

}
