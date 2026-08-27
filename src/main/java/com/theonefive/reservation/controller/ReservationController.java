package com.theonefive.reservation.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.theonefive.reservation.model.dto.RoomSearchDTO;
import com.theonefive.reservation.model.dto.RoomTypeListDTO;
import com.theonefive.reservation.service.ReservationService;

/*
 * 고객용 예약(객실조회 ~ 결제) 화면 이동을 담당할 컨트롤러
 */
@Controller
@RequestMapping("/customer/reservation")
public class ReservationController {

    private final ReservationService service;

    public ReservationController(ReservationService service) {
        this.service = service;
    }


    
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
   }