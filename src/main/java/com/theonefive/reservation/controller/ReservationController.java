package com.theonefive.reservation.controller;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.theonefive.customer.model.dto.CustomerDTO;
import com.theonefive.customer.service.CustomerService;
import com.theonefive.reservation.model.dto.ReservationDTO;
import com.theonefive.reservation.model.dto.RoomSearchDTO;
import com.theonefive.reservation.model.dto.RoomTypeListDTO;
import com.theonefive.reservation.service.ReservationService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

/*
 * 고객용 예약(객실조회 ~ 결제) 화면 이동을 담당할 컨트롤러
 */
@Controller
@RequestMapping("/customer/reservation")
@RequiredArgsConstructor
public class ReservationController {

    private final ReservationService service;
    private final CustomerService service1;


    
 // ReservationController.detail()
    @GetMapping("/detail")
    public String detail(@RequestParam Long roomTypeId,
                          @RequestParam(required = false) String checkinDate,
                          @RequestParam(required = false) String checkoutDate,
                          @RequestParam(required = false) Integer guestCount,
                          Model model) {

        RoomTypeListDTO roomType = service.findRoomTypeDetail(roomTypeId);
        model.addAttribute("roomType", roomType);

        // rooms에서 넘어온 값이 있으면 그대로, 없으면 기본값
        model.addAttribute("checkinDate", checkinDate != null ? checkinDate : LocalDate.now().toString());
        model.addAttribute("checkoutDate", checkoutDate != null ? checkoutDate : LocalDate.now().plusDays(1).toString());
        model.addAttribute("guestCount", guestCount != null ? guestCount : 2);

        return "customer/reservation/detail";
    }
    
    @GetMapping("/rooms")
    public String rooms(@ModelAttribute RoomSearchDTO condition, Model model) {

        if (condition.getCheckinDate() == null || condition.getCheckinDate().isEmpty()) {
            condition.setCheckinDate(LocalDate.now().toString());
        }
        if (condition.getCheckoutDate() == null || condition.getCheckoutDate().isEmpty()) {
            condition.setCheckoutDate(LocalDate.now().plusDays(1).toString());
        }
        if (condition.getGuestCount() == null) {
            condition.setGuestCount(2);
        }

        List<RoomTypeListDTO> roomTypeList = service.findRoomTypeList(condition);
        model.addAttribute("roomTypeList", roomTypeList);
        model.addAttribute("condition", condition);
        
        model.addAttribute("todayStr", LocalDate.now().toString());
        model.addAttribute("tomorrowStr", LocalDate.now().plusDays(1).toString());
        return "customer/reservation/rooms";
    }
    
    @GetMapping("/availability")
    @ResponseBody
    public int checkAvailability(@ModelAttribute RoomSearchDTO condition) {
        return service.countAvailableRooms(condition);
    }
    
    
    //---------------------------------------결제
    // URL : [GET] /customer/reservation/payment
    @GetMapping("/payment")
    public String payment(@RequestParam Long roomTypeId,
                           @RequestParam String checkinDate,
                           @RequestParam String checkoutDate,
                           @RequestParam Integer adultCount,
                           @RequestParam(required = false, defaultValue = "0") Integer childCount,
                           HttpSession session,
                           Model model) {

        RoomTypeListDTO roomType = service.findRoomTypeDetail(roomTypeId);

        long nights = ChronoUnit.DAYS.between(
                LocalDate.parse(checkinDate),
                LocalDate.parse(checkoutDate));

        int baseCapacity = roomType.getCapacity();
        int extraAdults = Math.max(0, adultCount - baseCapacity);
        int remaining = Math.max(0, baseCapacity - Math.min(adultCount, baseCapacity));
        int extraChildren = Math.max(0, childCount - remaining);
        int extraFeePerNight = (extraAdults * 10000) + (extraChildren * 5000);

        int roomAmount = roomType.getPrice() * (int) nights + (extraFeePerNight * (int) nights);

        String loginId = (String) session.getAttribute("loginId");
        boolean isVip = false;
        if (loginId != null) {
            CustomerDTO customer = service1.getCustomerByLoginId(loginId);
            isVip = "VIP".equals(customer.getMembershipGrade());
        }

        int discountAmount = isVip ? (int) (roomAmount * 0.05) : 0;
        int totalAmount = roomAmount - discountAmount;

        model.addAttribute("roomType", roomType);
        model.addAttribute("checkinDate", checkinDate);
        model.addAttribute("checkoutDate", checkoutDate);
        model.addAttribute("nights", nights);
        model.addAttribute("adultCount", adultCount);
        model.addAttribute("childCount", childCount);
        model.addAttribute("roomAmount", roomAmount);
        model.addAttribute("discountAmount", discountAmount);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("isVip", isVip);

        return "customer/reservation/payment";
    }
    @PostMapping("/complete")
    public String complete(@ModelAttribute ReservationDTO dto,
                            HttpSession session,
                            RedirectAttributes redirectAttr) {

        // 로그인 확인
        String loginId = (String) session.getAttribute("loginId");
        if (loginId == null) {
            return "redirect:/login";
        }
        CustomerDTO customer = service1.getCustomerByLoginId(loginId);

        // 결제 직전 최종 재고 검증
        RoomSearchDTO condition = new RoomSearchDTO();
        condition.setRoomTypeId(dto.getRoomTypeId());
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
        condition.setCheckinDate(sdf.format(dto.getCheckin()));
        condition.setCheckoutDate(sdf.format(dto.getCheckout()));

        int available = service.countAvailableRooms(condition);
        if (available <= 0) {
            redirectAttr.addFlashAttribute("error", "죄송합니다, 방금 마지막 객실이 예약되었습니다.");
            return "redirect:/customer/reservation/detail?roomTypeId=" + dto.getRoomTypeId();
        }

        dto.setGuestId(customer.getId()); 
        service.createReservation(dto);

        redirectAttr.addFlashAttribute("paymentSuccess", true);
        return "redirect:/customer/reservation/rooms";
    }
    @PostMapping("/{id}/cancel")
    public String cancel(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttr) {
        Long guestId = (Long) session.getAttribute("loginGuestId");
        if (guestId == null) {
            return "redirect:/login";
        }

        ReservationDTO reservation = service.findById(id);
        if (reservation == null || !guestId.equals(reservation.getGuestId())) {
            redirectAttr.addFlashAttribute("error", "본인의 예약만 취소할 수 있습니다.");
            return "redirect:/mypage/index";
        }

        try {
            service.cancelReservation(id);
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttr.addFlashAttribute("error", "예약 취소에 실패했습니다.");
            return "redirect:/mypage/index";
        }

        redirectAttr.addFlashAttribute("success", "예약이 취소되었습니다.");
        return "redirect:/mypage/index";
    }
}