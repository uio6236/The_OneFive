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


@Controller
public class EmployeeController {

   @Autowired
   private EmployeeService employeeService;

   // TODO: 임광희님 로그인 기능 완성되면 세션에서 실제 employeeId를 꺼내오는 걸로 교체
   // 예: Long employeeId = (Long) session.getAttribute("loginEmployeeId");
   private static final Long TEMP_EMPLOYEE_ID = 8L;

   // 관리자 마이페이지 조회
   @GetMapping("/admin/mypage")
   public String mypage(Model model) {
       model.addAttribute("employee", employeeService.getEmployee(TEMP_EMPLOYEE_ID));

       model.addAttribute("pageTitle", "관리자 마이페이지");
       model.addAttribute("pageDescription", "관리자 개인 프로필 설정, 정보 수정 및 계정 보안 설정을 종합 제어하는 관리 정보 센터");

       LocalDate today = LocalDate.now();
       String[] weekdays = {"월", "화", "수", "목", "금", "토", "일"};
       String todayStr = today.getYear() + "년 " + today.getMonthValue() + "월 " + today.getDayOfMonth() + "일 "
               + weekdays[today.getDayOfWeek().getValue() - 1] + "요일";
       model.addAttribute("today", todayStr);

       return "admin/mypage/index";   // -> /WEB-INF/views/admin/mypage/index.jsp
   }

   // 기본정보 수정 + (입력했다면) 비밀번호 변경
   @PostMapping("/admin/mypage/update")
   public String update(EmployeeDTO dto, RedirectAttributes redirectAttributes) {

       dto.setId(TEMP_EMPLOYEE_ID);
       employeeService.updateEmployeeInfo(dto);

       boolean passwordOk = employeeService.changePassword(
               TEMP_EMPLOYEE_ID, dto.getCurrentPassword(), dto.getNewPassword(), dto.getNewPasswordCheck());

       if (passwordOk) {
           redirectAttributes.addFlashAttribute("message", "변경사항이 저장되었습니다.");
       } else {
           redirectAttributes.addFlashAttribute("error",
                   "기본정보는 저장되었지만, 비밀번호 변경에 실패했습니다. 현재 비밀번호를 확인해주세요.");
       }

       return "redirect:/admin/mypage";
   }
}
