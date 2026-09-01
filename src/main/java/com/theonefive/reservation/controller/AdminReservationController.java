package com.theonefive.reservation.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.theonefive.reservation.model.dto.ReservationDTO;
import com.theonefive.reservation.model.dto.ReservationSearchDTO;
import com.theonefive.reservation.model.dto.ReservationViewDTO;
import com.theonefive.reservation.service.ReservationService;

/*
 * 관리자 예약 관리 화면 이동, 등록/취소 처리를 담당할 컨트롤러
 */
@Controller
@RequestMapping("/admin/reservations")
public class AdminReservationController {

    // ReservationService를 DI 처리 (생성자 주입방식)
    private final ReservationService service;

    public AdminReservationController(ReservationService service) {
        this.service = service;
    }

    // 화면 이동 요청
    // URL : [GET] /admin/reservations
    @GetMapping
    public String list(@ModelAttribute ReservationSearchDTO condition, Model model) {
        List<ReservationViewDTO> reservationList = service.findReservationList(condition);
        model.addAttribute("reservationList", reservationList);
        model.addAttribute("condition", condition);   // 검색값 유지용
        
		
		model.addAttribute("pageTitle", "예약 관리");
		model.addAttribute("pageDescription", "전체 예약 현황 분석");
		model.addAttribute("today", new SimpleDateFormat("yyyy년 M월 d일 EEEE", Locale.KOREAN).format(new Date()));
        return "admin/reservation/list";
    }

    // ------------------

	 // 우측 상세패널용 데이터 조회 (화면 이동 없음, JSON으로 응답)
	 // URL : [GET] /admin/reservations/{id}
	 @GetMapping("/{id}")
	 @ResponseBody
	 public ReservationViewDTO detail(@PathVariable Long id) {
	     return service.findDetailById(id);
	 }


    // 예약 취소 처리
    // URL : [POST] /admin/reservations/{id}/cancel
    @PostMapping("/{id}/cancel")
    public String cancel(@PathVariable Long id, RedirectAttributes redirectAttr) {
        try {
            service.cancelReservation(id);
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttr.addFlashAttribute("error", "예약 취소에 실패했습니다.");
            return "redirect:/admin/reservations";
        }

        redirectAttr.addFlashAttribute("success", "예약이 취소되었습니다.");
        return "redirect:/admin/reservations";
    }
}