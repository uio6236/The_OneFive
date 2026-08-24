package com.theonefive.checkin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.theonefive.checkin.model.dto.CheckinDTO;
import com.theonefive.checkin.service.CheckinService;
import com.theonefive.room.model.dto.RoomDTO;
import com.theonefive.room.service.RoomService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin/checkin")
@RequiredArgsConstructor
public class CheckinController {
	private final CheckinService checkinService;
	private final RoomService roomService;
	
	// 체크인 체크아웃 화면
	@GetMapping
	public String checkinlist(Model model) {
		List<CheckinDTO> checkinList = checkinService.getTodayCheckinList();
		List<CheckinDTO> checkoutList = checkinService.getTodayCheckoutList();
		model.addAttribute("checkinList", checkinList);
		model.addAttribute("checkoutList", checkoutList);
		
		return "admin/checkin/list";
	}
	
	// 체크인 상세
	@GetMapping("/detail")
	public String checkinDetail(@RequestParam int reservationId,
								Model model) {
		CheckinDTO checkin = checkinService.getCheckinDetail(reservationId);
		List<RoomDTO> roomList = roomService.getAvailableRooms(1); //roomTypeId
		model.addAttribute("checkin", checkin);
		model.addAttribute("availableRoomList", roomList);
		
		return "admin/checkin/detail";
	}
	
	// 체크인
	@PostMapping
	public String checkin(CheckinDTO checkin) {
		checkinService.checkin(checkin);
		return "redirect:/admin/checkin";
	}
	
	// 체크아웃
	@PostMapping
	public String checkout(CheckinDTO checkin) {
		checkinService.checkout(checkin);
		return "redirect:/admin/checkin";
	}
}
