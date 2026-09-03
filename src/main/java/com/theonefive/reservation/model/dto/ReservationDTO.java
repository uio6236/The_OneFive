package com.theonefive.reservation.model.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// RESERVATION 테이블 컬럼과 1:1 CRUD용

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ReservationDTO {

    private Long id;
    private String code;          
    private Long guestId;
    private Long roomTypeId;
    private Long roomId;           
    @DateTimeFormat(pattern = "yyyy-MM-dd")   // ← checkin, checkout 필드 위에 각각 추가
    private Date checkin;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date checkout;         
    private Integer guestCount;
    private String status;        
    private Integer roomAmount;      
    private Integer discountAmount;  
    private Integer totalAmount;    
    private String paymentMethod;
    private String request;       
    private Long createdBy;       
    private Date createdAt;
    
    private String guestName;
    private String guestPhone;
}