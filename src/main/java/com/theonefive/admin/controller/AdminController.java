package com.theonefive.admin.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.theonefive.admin.model.dto.EmployeeDTO;
import com.theonefive.admin.service.AdminService;
import com.theonefive.common.dto.ApiResponse;


import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller // 이 클래스가 요청을 받아 화면(JSP)을 연결해 주는 컨트롤러임을 선언
@RequestMapping("/admin") // URL에 기본적으로 /customer가 붙도록 설정
@RequiredArgsConstructor // final로 선언된 customerService를 자동으로 주입(DI)
public class AdminController {

    private final AdminService adminService;

    // ==========================================
    // 1. 회원가입 기능
    // ==========================================

    // 회원가입 페이지 보여주기 (GET 요청: http://localhost:8080/admin/adminSignup)
    @GetMapping("/adminSignup")
    public String signupForm() {
        // /WEB-INF/views/admin/adminSignup.jsp 파일 연결
        return "admin/adminSignup";
    }

    // 회원가입 버튼 클릭 시 처리 (POST 요청: Form 태그 데이터 전송)
    @PostMapping("/adminSignup")
    public String signup(EmployeeDTO employee, Model model) throws IOException {
        // JSP Form의 name값들이 EmployeeDTO 필드명과 일치하므로 자동으로 employee 객체에 담김
        try {
            adminService.signup(employee); // 회원가입 로직 실행 (중복검사 + 암호화 + DB저장)
            return "redirect:/login"; // 가입 성공 시 로그인 페이지로 자동 이동
        } catch (IllegalStateException e) {
            // 아이디 중복 등으로 Service에서 예외(throw)가 발생한 경우
            model.addAttribute("errorMessage", e.getMessage()); // 에러 메시지를 JSP로 전송
            return "admin/adminSignup"; // 다시 회원가입 페이지로 돌아가 에러 메시지 출력
        }
    }

    // 아이디 중복 체크 (AJAX 요청용, 화면 페이지가 아닌 true/false 값만 반환)
    @ResponseBody
    @GetMapping("/checkCode")
    public ApiResponse<Boolean> checkCode(@RequestParam("code")String code) {
    	
    	boolean isDuplicate = adminService.isCodeCheck(code);
    	
    	String message = isDuplicate ? "이미 사용 중인 사번입니다." : "사용 가능한 사번 입니다.";
    	
        return ApiResponse.success(message, isDuplicate); // true면 중복된 아이디
    }

    // ==========================================
    // 2. 로그인 기능
    // ==========================================

    // 로그인 페이지 보여주기 (GET 요청: http://localhost:8080/customer/login)
    @GetMapping("/adminLogin")
    public String loginForm() {
        // /WEB-INF/views/customer/login.jsp 파일 연결
        return "admin/adminLogin";
    }

    // 로그인 버튼 클릭 시 처리 (POST 요청)
    @PostMapping("/adminLogin")
    public String login(@RequestParam("code") String code, 
                        @RequestParam("password") String password, 
                        HttpSession session, 
                        Model model) {
        try {
            // 아이디와 비밀번호로 로그인 검증 실행
            EmployeeDTO loginAdmin = adminService.code(code, password);
            
            // 로그인 성공 시 세션(Session)에 회원 정보 저장 (로그인 상태 유지)
            session.setAttribute("loginAdmin", loginAdmin);
            
            return "redirect:/mypage/index"; // 로그인 성공 후 메인 페이지로 이동
        } catch (IllegalStateException e) {
            // 로그인 실패 시 (아이디 불일치 or 비밀번호 틀림)
            model.addAttribute("errorMessage", e.getMessage());
            return "admin/adminLogin"; // 다시 로그인 페이지로 돌아감
        }
    }

    // ==========================================
    // 3. 로그아웃 & 메인페이지
    // ==========================================

    // 메인 페이지
    @GetMapping("/main")
    public String mainPage() {
        return "customer/main"; // /WEB-INF/views/customer/main.jsp 연결
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 정보 삭제 (로그아웃 처리)
        return "redirect:/admin/adminLogin"; // 로그인 페이지로 이동
    }
    
    // ==========================================
    // 3.마이페이지 테스트 
    // ==========================================
    
    @GetMapping("/test/login")
    public String loginTest() {
        return "customer/mypage/index";
    }
}
