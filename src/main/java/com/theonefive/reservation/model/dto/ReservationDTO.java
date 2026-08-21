package com.theonefive.reservation.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

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
    private Date checkin;          
    private Date checkout;         
    private int guestCount;
    private String status;        
    private int roomAmount;      
    private int discountAmount;  
    private int totalAmount;    
    private String paymentMethod;
    private String request;       
    private Long createdBy;       
    private Date createdAt;
}