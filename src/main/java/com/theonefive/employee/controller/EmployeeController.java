package com.theonefive.employee.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.theonefive.employee.model.dto.EmployeeDTO;
import com.theonefive.employee.service.EmployeeService;

import jakarta.servlet.http.HttpSession;
 
@Controller
public class EmployeeController {
 
    @Autowired
    private EmployeeService employeeService;
 
    // 세션에 저장된 로그인 관리자 정보(admin 패키지의 EmployeeDTO)에서 ID만 꺼내온다.
    // 로그인 안 된 상태면 null.
    private Long getLoginEmployeeId(HttpSession session) {
        com.theonefive.admin.model.dto.EmployeeDTO loginAdmin =
                (com.theonefive.admin.model.dto.EmployeeDTO) session.getAttribute("loginAdmin");
        return (loginAdmin != null) ? (long) loginAdmin.getId() : null;
    }
 
    // 관리자 마이페이지 조회
    @GetMapping("/admin/mypage")
    public String mypage(HttpSession session, Model model) {
 
        Long employeeId = getLoginEmployeeId(session);
        if (employeeId == null) {
            return "redirect:/admin/adminLogin";
        }
 
        model.addAttribute("employee", employeeService.getEmployee(employeeId));
 
        model.addAttribute("pageTitle", "관리자 마이페이지");
        model.addAttribute("pageDescription", "관리자 개인 프로필 설정, 정보 수정 및 계정 보안 설정을 종합 제어하는 관리 정보 센터");
 
        LocalDate today = LocalDate.now();
        String[] weekdays = {"월", "화", "수", "목", "금", "토", "일"};
        String todayStr = today.getYear() + "년 " + today.getMonthValue() + "월 " + today.getDayOfMonth() + "일 "
                + weekdays[today.getDayOfWeek().getValue() - 1] + "요일";
        model.addAttribute("today", todayStr);
 
        return "admin/mypage/index";   // -> /WEB-INF/views/admin/mypage/index.jsp
    }
 
    // 개인 기본정보(이름/이메일/연락처) 수정 - "정보 수정" 버튼
    @PostMapping("/admin/mypage/update-info")
    public String updateInfo(EmployeeDTO dto, HttpSession session, RedirectAttributes redirectAttributes) {
 
        Long employeeId = getLoginEmployeeId(session);
        if (employeeId == null) {
            return "redirect:/admin/adminLogin";
        }
 
        dto.setId(employeeId);
        String errorMessage = employeeService.updateEmployeeInfo(dto);
 
        if (errorMessage == null) {
            redirectAttributes.addFlashAttribute("message", "기본정보가 저장되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", errorMessage);
        }
 
        return "redirect:/admin/mypage";
    }
 
    // 비밀번호 변경 - "비밀번호 변경 적용" 버튼
    @PostMapping("/admin/mypage/update-password")
    public String updatePassword(EmployeeDTO dto, HttpSession session, RedirectAttributes redirectAttributes) {
 
        Long employeeId = getLoginEmployeeId(session);
        if (employeeId == null) {
            return "redirect:/admin/adminLogin";
        }
 
        String errorMessage = employeeService.changePassword(
                employeeId, dto.getCurrentPassword(), dto.getNewPassword(), dto.getNewPasswordCheck());
 
        if (errorMessage == null) {
            redirectAttributes.addFlashAttribute("message", "비밀번호가 변경되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", errorMessage);
        }
 
        return "redirect:/admin/mypage";
    }
}