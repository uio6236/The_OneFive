package com.theonefive.checkin.model.dto;

import java.time.LocalDateTime;

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
public class CheckinDTO {
	private int id; // 체크인 ID
    private int reservationId; // 연결된 예약 ID
    private int guestId; // 고객 ID
    private int roomId; // 실제 투숙 객실 ID
    private int roomTypeId; // 객실 타입 ID
    
    private LocalDateTime checkinTime; // 실제 체크인 시간
    private LocalDateTime checkoutTime; // 실제 체크아웃 시간
    private String keyType; // 키 발급 유형
    
    private String memo; // 투숙 메모
    
    private String guestName; // 고객명
    private String guestNameR; // 예약자명
    private String reservationCode; // 예약 번호
    private String roomNum; // 객실 번호
    private String roomTypeName; // 객실 타입명
    private int guestCount; // 객실 이용 인원(고객 인원)
    private String roomStatus; // 객실 상태
}
