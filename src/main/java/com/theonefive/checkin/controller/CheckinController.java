package com.theonefive.checkin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
		
		model.addAttribute("pageTitle", "체크인 / 체크아웃");
		model.addAttribute("pageDescription", "금일 객실 입퇴실 처리 및 신속 체크인을 지원합니다");
		
		return "admin/checkin/list";
	}
	
	// 체크인 상세
	@GetMapping("/detail")
	@ResponseBody
	public CheckinDTO checkinDetail(@RequestParam int reservationId) {
		return checkinService.getCheckinDetail(reservationId);
	}
	
	// 체크인 가능 객실 조회
	@GetMapping("/available-rooms")
	@ResponseBody
	public List<RoomDTO> availableRooms(@RequestParam int roomTypeId) {
		return roomService.getAvailableRooms(roomTypeId);
	}
	
	// 체크인
	@PostMapping
	public String checkin(CheckinDTO checkin) {
		checkinService.checkin(checkin);
		return "redirect:/admin/checkin";
	}
	
	// 체크아웃
	@PostMapping("/checkout")
	public String checkout(CheckinDTO checkin) {
		checkinService.checkout(checkin);
		return "redirect:/admin/checkin";
	}
}
