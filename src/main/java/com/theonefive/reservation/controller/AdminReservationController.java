package com.theonefive.reservation.controller;

import com.theonefive.reservation.model.dto.ReservationDTO;
import com.theonefive.reservation.model.dto.ReservationViewDTO;
import com.theonefive.reservation.service.ReservationService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

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
    public String list(Model model) {
        List<ReservationViewDTO> reservationList = service.findReservationList();
        model.addAttribute("reservationList", reservationList);
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
    // 새 예약 등록 (모달 폼 제출 처리)
    // URL : [POST] /admin/reservations
    @PostMapping
    public String create(@ModelAttribute ReservationDTO reservation,
                          RedirectAttributes redirectAttr) {
        try {
            service.createReservation(reservation);
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttr.addFlashAttribute("error", "예약 등록에 실패했습니다.");
            return "redirect:/admin/reservations";
        }

        redirectAttr.addFlashAttribute("success", "예약이 등록되었습니다.");
        return "redirect:/admin/reservations";
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