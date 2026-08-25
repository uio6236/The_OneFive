package com.theonefive.room.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.theonefive.room.model.dto.RoomDTO;

@Mapper
public interface RoomMapper {
	// 전체 객실 조회
	List<RoomDTO> selectRoomList();
	
	// 객실 상세 조회
	RoomDTO selectRoomById(int roomId);
	
	// 층별 조회
	List<RoomDTO> selectRoomByFloor(int floor);
	
	// 체크인 가능 객실 조회
	List<RoomDTO> selectAvailableRooms(int roomTypeId);
	
	// 객실 상태 변경
	int updateRoomStatus(@Param("roomId") int roomId, @Param("status") String status);
}
