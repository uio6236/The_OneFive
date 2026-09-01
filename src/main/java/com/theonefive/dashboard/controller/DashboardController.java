package com.theonefive.dashboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.theonefive.dashboard.service.DashboardService;

@Controller
@RequestMapping("/admin/dashboard")
public class DashboardController {

	@Autowired
    private DashboardService dashboardService;
 
    @GetMapping
    public String dashboard(Model model) {
        model.addAttribute("dashboard", dashboardService.getDashboard());
		model.addAttribute("pageTitle", "대시보드");
		model.addAttribute("pageDescription", "금일 호텔 운영 주요 지표 및 투숙 현황 종합 제어 센터");
        return "admin/dashboard";   // -> /WEB-INF/views/admin/dashboard.jsp
    }
	
	
}
