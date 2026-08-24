package com.theonefive.room.service;

import java.util.List;

import com.theonefive.room.model.dto.RoomDTO;

public interface RoomService {
	// 전체 객실 조회
	List<RoomDTO> getRoomList();
	
	// 객실 상세 조회
	RoomDTO getRoomDetail(int roomId);

	// 층/상태 조건 조회
	List<RoomDTO> searchRooms(int floor, String status);
	
	// 체크인 가능 객실 조회
	List<RoomDTO> getAvailableRooms(int roomTypeId);
	
	// 객실 상태 변경
	boolean changeroomStatus(int roomId, String Status);
}
