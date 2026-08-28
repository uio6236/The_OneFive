package com.theonefive.inquiry.controller;


import com.theonefive.inquiry.model.dto.InquiryDTO;
import com.theonefive.inquiry.service.InquiryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
 
import java.util.List;
 
@Controller
public class InquiryController {
 
	 @Autowired
	    private InquiryService inquiryService;
	 
	    // TODO: 임광희님 로그인 기능 완성되면 세션에서 실제 guestId를 꺼내오는 걸로 교체
	    // 예: Long guestId = (Long) session.getAttribute("loginGuestId");
	    private static final Long TEMP_GUEST_ID = 16L;
	 
	 
	    // ===================== 관리자 =====================
	 
	    private static final int PAGE_SIZE = 10;
	 
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
	    public String customerList(Model model) {
	        model.addAttribute("myInquiries", inquiryService.getMyInquiryList(TEMP_GUEST_ID));
	        return "customer/inquiry/list";   // -> /WEB-INF/views/customer/inquiry/list.jsp
	    }
	 
	    // 내 문의 상세
	    @GetMapping("/customer/inquiries/detail/{id}")
	    public String customerDetail(@PathVariable Long id, Model model) {
	        model.addAttribute("inquiry", inquiryService.getMyInquiryDetail(id, TEMP_GUEST_ID));
	        return "customer/inquiry/detail"; // -> /WEB-INF/views/customer/inquiry/detail.jsp
	    }
	 
	    // 문의 작성 폼
	    @GetMapping("/customer/inquiries/form")
	    public String customerForm() {
	        return "customer/inquiry/form";   // -> /WEB-INF/views/customer/inquiry/form.jsp
	    }
	 
	    // 문의 등록 처리
	    @PostMapping("/customer/inquiries")
	    public String customerSubmit(InquiryDTO dto) {
	        dto.setGuestId(TEMP_GUEST_ID);
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