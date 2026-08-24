package com.theonefive.room.model.dto;

import java.time.LocalDateTime;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class RoomDTO {
	private int id; // 객실 ID
	private String roomNum; // 객실 번호
	private int typeId; // 객실 타입 ID
	private int floor; // 객실 층
	private String status; // 객실 상태
	private String memo; // 객실 관련 메모
	
	private String typeName; // 객실 타입명
}
