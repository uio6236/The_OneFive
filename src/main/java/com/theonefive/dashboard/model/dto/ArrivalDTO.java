package com.theonefive.dashboard.model.dto;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ArrivalDTO {
    private String guestName;
    private String roomTypeName;
    private String roomNum;      // 미배정이면 null -> JSP에서 "배정 대기"로 표시
    private Date checkinTime;
    private String reservationCode;  // 예약번호
    private Integer guestCount;      // 인원
    private String roomStatus;       // 객실 현재 상태 (이용가능/청소중/점검중 등)
}
 