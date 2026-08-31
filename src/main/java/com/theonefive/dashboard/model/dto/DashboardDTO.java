package com.theonefive.dashboard.model.dto;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
 
@Getter
@Setter
@NoArgsConstructor
public class DashboardDTO {
 
	   private int todayCheckinCount;
	    private int todayCheckoutCount;
	    private double occupancyRate;
	    private int roomsNeedCleaning;
	    private java.math.BigDecimal todayRevenue;
	 
	    // 객실 상태 현황
	    private int roomAvailable;
	    private int roomOccupied;
	    private int roomCleaning;
	    private int roomInspection;
	 
	    // 하우스키핑 진행 현황
	    private int hkWaiting;
	    private int hkInProgress;
	    private int hkInspected;
	 
	    // 오늘 도착 예정 투숙객은 별도 리스트로 조회
	    private List<ArrivalDTO> todayArrivals;
}
 