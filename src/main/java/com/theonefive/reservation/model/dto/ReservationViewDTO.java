package com.theonefive.reservation.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;


// RESERVATION + CUSTOMER + ROOM_TYPE + ROOM을 join한 결과를 담는다.

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ReservationViewDTO {

    private Long reservationId;
    private String code;
    private String status;
    private String guestName;
    private String guestPhone;
    private String typeName;
    private String roomNum;   // 배정 전이면 null
    private Date checkin;
    private Date checkout;
    private Integer guestCount;
    private Integer totalAmount;
}