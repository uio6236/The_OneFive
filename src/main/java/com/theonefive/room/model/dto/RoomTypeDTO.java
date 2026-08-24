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
public class RoomTypeDTO {
	private int id; // 객실 타입 ID
	private String name; // 객실 타입명
	private int capacity; // 기준 인원
	private int maxCapacity; // 최대 인원
	private int price; // 기본 요금
	private int maxPrice; // 성수기 요금
	private String description; // 객실 설명
	private String imageUrl; // 객실 대표 이미지 경로
}
