package com.theonefive.room.service;

import java.util.List;

import com.theonefive.room.model.dto.RoomDTO;

public interface RoomService {
	// 선택한 객실의 정비 요청을 등록
	List<RoomDTO> getRoomList();
	
	// 객실 ID를 기준으로 상세 정보 조회
	RoomDTO getRoomDetail(int roomId);

	// 선택한 층의 객실 목록 조회
	List<RoomDTO> getRoomByFloor(int floor);
	
	// 객실 타입에 맞는 이용 가능한 객실 목록 조회
	List<RoomDTO> getAvailableRooms(int roomTypeId);
	
	// 이용 가능한 객실의 상태를 변경하고 하우스키핑 정비 요청을 생성
	boolean requestMaintenance(int roomId, String note);
}
