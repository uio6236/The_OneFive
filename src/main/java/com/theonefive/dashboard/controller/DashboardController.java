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
        return "admin/dashboard";   // -> /WEB-INF/views/admin/dashboard.jsp
    }
	
	
}
