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
		// 전체 객실 목록 조회
		return roomMapper.selectRoomList();
	}

	@Override
	public RoomDTO getRoomDetail(int roomId) {
		// 객실 ID를 기준으로 상세 정보 조회
		return roomMapper.selectRoomById(roomId);
	}

	@Override
	public List<RoomDTO> getRoomByFloor(int floor) {
		// 선택한 층의 객실 목록 조회
		return roomMapper.selectRoomByFloor(floor);
	}

	@Override
	public List<RoomDTO> getAvailableRooms(int roomTypeId) {
		// 객실 타입에 맞는 이용 가능한 객실 목록 조회
		return roomMapper.selectAvailableRooms(roomTypeId);
	}

	@Transactional
	@Override
	public boolean requestMaintenance(int roomId, String note) {
		// 이용 가능한 객실의 상태를 변경하고 하우스키핑 정비 요청을 생성
		RoomDTO room = roomMapper.selectRoomById(roomId);
		if (room == null) {throw new IllegalStateException("객실 정보를 찾을 수 없습니다.");}
		if (!"이용가능".equals(room.getStatus())) {throw new IllegalStateException("이용 가능한 객실만 정비 요청을 할 수 있습니다.");}
		int activeCount = housekeepingMapper.countActiveCleaningRequest((long) roomId);
		if (activeCount > 0) {throw new IllegalStateException("이미 진행 중인 객실 정비 요청이 있습니다.");}
		
		int roomResult = roomMapper.updateRoomStatus(roomId, "청소중");
		if (roomResult == 0) {throw new IllegalStateException("객실 상태 변경에 실패했습니다.");}
		
		HousekeepingDTO housekeeping = new HousekeepingDTO();
		housekeeping.setRoomId((long) roomId);
		housekeeping.setNote(note);

		int housekeepingResult = housekeepingMapper.insertCleaningRequest(housekeeping);

		if (housekeepingResult == 0) {
			throw new IllegalStateException(
					"객실 정비 요청 등록에 실패했습니다.");
		}

		return true;
	}
}
