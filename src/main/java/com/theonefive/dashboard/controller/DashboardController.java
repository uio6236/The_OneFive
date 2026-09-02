package com.theonefive.dashboard.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.theonefive.dashboard.service.DashboardService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/dashboard")
public class DashboardController {
 
    @Autowired
    private DashboardService dashboardService;
 
    // 세션에서 로그인한 관리자의 ID를 꺼낸다. 로그인 안 된 상태면 null.
    private Long getLoginEmployeeId(HttpSession session) {
        com.theonefive.admin.model.dto.EmployeeDTO loginAdmin =
                (com.theonefive.admin.model.dto.EmployeeDTO) session.getAttribute("loginAdmin");
        return (loginAdmin != null) ? (long) loginAdmin.getId() : null;
    }
 
    @GetMapping
    public String dashboard(HttpSession session, Model model) {
 
        // 로그인한 관리자가 아니면 대시보드 자체를 볼 수 없게 차단
        if (getLoginEmployeeId(session) == null) {
            return "redirect:/admin/adminLogin";
        }
 
        model.addAttribute("dashboard", dashboardService.getDashboard());

		model.addAttribute("pageTitle", "대시보드");
		model.addAttribute("pageDescription", "금일 호텔 운영 주요 지표 및 투숙 현황 종합 제어 센터");
		model.addAttribute("today", new SimpleDateFormat("yyyy년 M월 d일 EEEE", Locale.KOREAN).format(new Date()));

        return "admin/dashboard";   // -> /WEB-INF/views/admin/dashboard.jsp
    }
}
 