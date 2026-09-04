package com.theonefive.room.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.theonefive.room.model.dto.RoomDTO;

@Mapper
public interface RoomMapper {
	// 전체 객실 정보 조회
	List<RoomDTO> selectRoomList();
	
	// 객실 ID를 기준으로 객실 상세 정보 조회
	RoomDTO selectRoomById(int roomId);
	
	// 층을 기준으로 객실 목록 조회
	List<RoomDTO> selectRoomByFloor(int floor);
	
	// 객실 타입에 해당하는 이용 가능한 객실 조회
	List<RoomDTO> selectAvailableRooms(int roomTypeId);
	
	// 객실 타입에 해당하는 이용 가능한 객실 조회
	int updateRoomStatus(@Param("roomId") int roomId, @Param("status") String status);
}
