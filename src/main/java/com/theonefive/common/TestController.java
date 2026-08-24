package com.theonefive.common;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {

    @GetMapping("/test/admin")
    public String adminTest(Model model) {

        model.addAttribute("pageTitle", "대시보드");
        model.addAttribute("pageDescription", "호텔 운영 현황을 한눈에 확인하세요.");
        model.addAttribute("today", "2026년 8월 21일");

        return "admin/dashboard";
    }

    @GetMapping("/test/customer")
    public String customerTest() {
        return "customer/main";
    }

    @GetMapping("/test/login")
    public String loginTest() {
        return "login";
    }

}