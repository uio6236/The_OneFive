package com.theonefive.inquiry.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.theonefive.customer.model.dto.CustomerDTO;
import com.theonefive.customer.service.CustomerService;
import com.theonefive.inquiry.model.dto.InquiryDTO;
import com.theonefive.inquiry.service.InquiryService;

import jakarta.servlet.http.HttpSession;
 
@Controller
public class InquiryController {
 
    @Autowired
    private InquiryService inquiryService;
 
    // 세션에는 로그인 아이디(loginId, 문자열)만 있어서 CustomerService로 실제 PK(숫자)를 조회해야 함
    @Autowired
    private CustomerService customerService;
 
    private static final int PAGE_SIZE = 10;
 
    // 세션에서 로그인한 고객의 ID(PK)를 꺼낸다. 로그인 안 된 상태면 null.
    private Long getLoginGuestId(HttpSession session) {
        String loginId = (String) session.getAttribute("loginId");
        if (loginId == null) {
            return null;
        }
        CustomerDTO customer = customerService.getCustomerByLoginId(loginId);
        return (customer != null) ? Long.valueOf(customer.getId()) : null;
    }
 
 
    // ===================== 관리자 =====================
 
    // 문의 목록 + 상세(우측 패널)를 한 화면에서 처리
    // id 파라미터가 없으면 목록의 첫 번째 문의를 기본 선택
    // keyword/status가 있으면 검색·필터가 적용된 목록만 좌측에 표시
    // page 파라미터로 페이지네이션 처리 (기본 1페이지)
    @GetMapping("/admin/inquiries")
    public String adminList(@RequestParam(required = false) Long id,
                             @RequestParam(required = false) String keyword,
                             @RequestParam(required = false) String status,
                             @RequestParam(defaultValue = "latest") String sortOrder,
                             @RequestParam(defaultValue = "1") int page,
                             Model model) {
 
        model.addAttribute("pageTitle", "문의 관리");
        model.addAttribute("pageDescription", "고객들이 남긴 웹 문의 및 피드백에 대해 신속하게 답변을 관리하는 제어 센터");
        model.addAttribute("today", todayString());
 
        // 검색/필터/정렬/페이지네이션이 적용된 목록 (좌측 패널용)
        List<InquiryDTO> inquiryList = inquiryService.getInquiryList(keyword, status, sortOrder, page, PAGE_SIZE);
        model.addAttribute("inquiryList", inquiryList);
        model.addAttribute("keyword", keyword);
        model.addAttribute("status", status);
        model.addAttribute("sortOrder", sortOrder);
 
        // 검색/필터 조건 기준 전체 건수 -> 총 페이지 수 계산
        int filteredCount = inquiryService.getInquiryCount(keyword, status);
        int totalPages = (int) Math.ceil(filteredCount / (double) PAGE_SIZE);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", Math.max(totalPages, 1));
        model.addAttribute("filteredCount", filteredCount);
 
        // 요약 카운트는 검색/필터와 무관하게 항상 전체 기준
        model.addAttribute("totalCount", inquiryService.getInquiryCount(null, null));
        model.addAttribute("pendingCount", inquiryService.getInquiryCount(null, "대기중"));
        model.addAttribute("completedCount", inquiryService.getInquiryCount(null, "답변완료"));
 
        Long targetId = (id != null) ? id
                : (inquiryList.isEmpty() ? null : inquiryList.get(0).getId());
 
        if (targetId != null) {
            model.addAttribute("selectedInquiry", inquiryService.getInquiryDetail(targetId));
        }
 
        return "admin/inquiry/list";   // -> /WEB-INF/views/admin/inquiry/list.jsp
    }
 
    // 답변 등록/수정 처리 후 같은 문의를 선택한 채로 목록으로 복귀
    @PostMapping("/admin/inquiries/answer")
    public String adminAnswer(InquiryDTO dto) {
        inquiryService.answerInquiry(dto);
        return "redirect:/admin/inquiries?id=" + dto.getId();
    }
 
 
    // ===================== 고객 =====================
 
    // 내 문의 목록
    @GetMapping("/customer/inquiries")
    public String customerList(HttpSession session, Model model) {
        Long guestId = getLoginGuestId(session);
        if (guestId == null) {
            return "redirect:/login";
        }
        model.addAttribute("myInquiries", inquiryService.getMyInquiryList(guestId));
        return "customer/inquiry/list";   // -> /WEB-INF/views/customer/inquiry/list.jsp
    }
 
    // 내 문의 상세
    @GetMapping("/customer/inquiries/detail/{id}")
    public String customerDetail(@PathVariable Long id, HttpSession session, Model model) {
        Long guestId = getLoginGuestId(session);
        if (guestId == null) {
            return "redirect:/login";
        }
        model.addAttribute("inquiry", inquiryService.getMyInquiryDetail(id, guestId));
        return "customer/inquiry/detail"; // -> /WEB-INF/views/customer/inquiry/detail.jsp
    }
 
    // 문의 작성 폼
    @GetMapping("/customer/inquiries/form")
    public String customerForm(HttpSession session) {
        if (getLoginGuestId(session) == null) {
            return "redirect:/login";
        }
        return "customer/inquiry/form";   // -> /WEB-INF/views/customer/inquiry/form.jsp
    }
 
    // 문의 등록 처리
    @PostMapping("/customer/inquiries")
    public String customerSubmit(InquiryDTO dto, HttpSession session) {
        Long guestId = getLoginGuestId(session);
        if (guestId == null) {
            return "redirect:/login";
        }
        dto.setGuestId(guestId);
        inquiryService.submitInquiry(dto);
        return "redirect:/customer/inquiries";
    }
 
    // "2026년 8월 28일 금요일" 형식의 오늘 날짜 문자열 생성 (상단 헤더용)
    private String todayString() {
        java.time.LocalDate today = java.time.LocalDate.now();
        String[] weekdays = {"월", "화", "수", "목", "금", "토", "일"};
        return today.getYear() + "년 " + today.getMonthValue() + "월 " + today.getDayOfMonth() + "일 "
                + weekdays[today.getDayOfWeek().getValue() - 1] + "요일";
    }
}