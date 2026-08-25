package com.theonefive.dashboard.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.theonefive.dashboard.model.dto.ActivityDTO;
import com.theonefive.dashboard.model.dto.ArrivalDTO;
import com.theonefive.dashboard.model.dto.DashboardDTO;

@Mapper
public interface  DashboardMapper {
	
	  // 상단 요약 + 객실상태 + 하우스키핑 카운트를 한 번에 (단일 row)
    DashboardDTO selectSummary();
 
    // 오늘 도착 예정 투숙객 목록
    List<ArrivalDTO> selectTodayArrivals();
 
    // 최근 현장 활동 (체크인/체크아웃/정비 통합, 최근 N건)
    List<ActivityDTO> selectRecentActivities();

}
