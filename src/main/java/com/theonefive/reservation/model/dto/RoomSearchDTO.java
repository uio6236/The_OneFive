package com.theonefive.reservation.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// 고객 객실조회 검색조건 전용 
@Getter
@Setter
@NoArgsConstructor
@ToString
public class RoomSearchDTO {
    private String checkinDate;
    private String checkoutDate;
    private Integer guestCount;
    private Long roomTypeId;
}