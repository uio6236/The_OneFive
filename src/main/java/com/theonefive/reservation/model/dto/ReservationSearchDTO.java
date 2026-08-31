package com.theonefive.reservation.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 예약 목록 검색조건 전용 DTO. RESERVATION 테이블과 무관하고
// 화면의 검색폼 입력값만 담는다.
@Getter
@Setter
@NoArgsConstructor
public class ReservationSearchDTO {

    private String keyword;
    private String status;
    private String checkinDate;
}