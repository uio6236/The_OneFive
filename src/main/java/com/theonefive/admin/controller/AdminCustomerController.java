package com.theonefive.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.theonefive.admin.model.dto.AdminCustomerSearchDTO;
import com.theonefive.admin.service.AdminCustomerService;
import com.theonefive.customer.model.dto.CustomerDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor // final로 선언된 adminCustomerService를 생성자로 자동 주입(DI)
@RequestMapping("/admin/customers")
public class AdminCustomerController {
    private final AdminCustomerService adminCustomerService;
    
    // 검색 조건에 맞는 고객 목록과 총 고객 수 조회
    // 목록 + 검색 + 페이징 화면
    @GetMapping
    public String list(AdminCustomerSearchDTO search, Model model) {
        // 파라미터 이름 생략형: URL 쿼리스트링(keyword, membershipGrade, page)이
        // AdminCustomerSearchDTO 필드에 스프링이 알아서 바인딩해줌
        int totalCount = adminCustomerService.getCustomerTotalCount(search);

        model.addAttribute("customerList", adminCustomerService.getCustomerList(search));
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("search", search); // 검색어/필터 값을 화면에 다시 채워주기 위해 전달
        model.addAttribute("totalPages", (int) Math.ceil((double) totalCount / search.getSize())); // 총 페이지 수
        
		model.addAttribute("pageTitle", "고객 관리");
		model.addAttribute("pageDescription", "호텔 멤버십 회원 및 역대 투숙객 통합 조회 및 기록 관리");
		model.addAttribute("today", new SimpleDateFormat("yyyy년 M월 d일 EEEE", Locale.KOREAN).format(new Date()));
        return "admin/customer/list"; // /WEB-INF/views/admin/customer/list.jsp
    }

    // 고객 수정 처리
    @PostMapping("/{id}")
    public String update(
            @PathVariable Long id,
            CustomerDTO dto) {
        dto.setId(id);
        adminCustomerService.updateCustomer(dto);

        return "redirect:/admin/customers";
    }
    
    // 선택한 고객의 상세 정보 조회
    @GetMapping("/{id}")
    @ResponseBody
    public CustomerDTO getCustomer(@PathVariable Long id) {
        return adminCustomerService.getCustomerById(id);
    }
}