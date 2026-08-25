package com.theonefive.reservation.controller;

import com.theonefive.reservation.model.dto.RoomTypeListDTO;
import com.theonefive.reservation.service.ReservationService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

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

    // URL : [GET] /customer/reservation/rooms
    @GetMapping("/rooms")
    public String rooms(Model model) {
        List<RoomTypeListDTO> roomTypeList = service.findRoomTypeList();
        model.addAttribute("roomTypeList", roomTypeList);
        return "customer/reservation/rooms";
    }
}