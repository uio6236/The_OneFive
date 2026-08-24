package com.theonefive.room.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.theonefive.room.model.dto.RoomDTO;
import com.theonefive.room.service.RoomService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin/room")
@RequiredArgsConstructor
public class RoomController {
	private final RoomService roomService;
	
	// 객실 현황
	@GetMapping
	public String roomList(@RequestParam(defaultValue = "0") int floor,
						@RequestParam(required = false) String status,
						Model model) {
		List<RoomDTO> roomList = roomService.searchRooms(floor, status);
		
		model.addAttribute("roomList", roomList);
		return "admin/room/list";
	}
	
	// 객실 상세
	@GetMapping("/{roomId}")
	public String roomListDetail(@PathVariable int roomId,
								Model model) {
		RoomDTO room = roomService.getRoomDetail(roomId);
		model.addAttribute("room", room);
		return "admin/room/detail";
	}
}
