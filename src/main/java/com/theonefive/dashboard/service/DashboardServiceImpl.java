package com.theonefive.dashboard.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.theonefive.dashboard.model.dto.DashboardDTO;
import com.theonefive.dashboard.model.mapper.DashboardMapper;

@Service 
public class DashboardServiceImpl implements DashboardService {
	
	@Autowired
    private DashboardMapper dashboardMapper;
 
    @Override
    public DashboardDTO getDashboard() {
        DashboardDTO dto = dashboardMapper.selectSummary();
        dto.setTodayArrivals(dashboardMapper.selectTodayArrivals());
        dto.setRecentActivities(dashboardMapper.selectRecentActivities());
        return dto;
    }

}


