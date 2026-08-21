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
	private Long id;
    private Long reservationId;
    private Long guestId;
    private Long roomId;
    
    private LocalDateTime checkin;
    private LocalDateTime checkout;
    private String keyType;
    private Long checkinEmployee;
    private Long checkoutEmployee;
    
    private String memo;
}
