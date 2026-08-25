package com.theonefive.dashboard.model.dto;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
 
@Getter
@Setter
@NoArgsConstructor
public class DashboardDTO {
 
    // 상단 요약 카드
    private int todayCheckinCount;
    private int todayCheckoutCount;
    private double occupancyRate;
    private int roomsNeedCleaning;
 
    // 객실 상태 현황
    private int roomAvailable;
    private int roomOccupied;
    private int roomCleaning;
    private int roomInspection;
 
    // 하우스키핑 진행 현황
    private int hkWaiting;
    private int hkInProgress;
    private int hkCompleted;
    private int hkInspected;
 
    // 오늘 도착 예정 투숙객 / 최근 활동은 별도 리스트로 조회
    private List<ArrivalDTO> todayArrivals;
    private List<ActivityDTO> recentActivities;
}