package com.theonefive.reservation.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// 고객 객실조회(rooms.jsp) 화면 전용. ROOM_TYPE + 그 타입의 예약가능 객실 수를 담는다.
@Getter
@Setter
@NoArgsConstructor
@ToString
public class RoomTypeListDTO {

    private Long typeId;
    private String typeName;
    private String description;
    private Integer capacity;
    private Integer maxCapacity;
    private Integer price;
    private Integer maxPrice;
    private String imageUrl;
    private Integer availableRoomCount;   // 지금 이용가능 상태인 객실 개수
}