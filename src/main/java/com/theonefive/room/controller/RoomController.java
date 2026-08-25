package com.theonefive.room.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
						Model model) {
		List<RoomDTO> allRoomList = roomService.getRoomList();
		List<RoomDTO> roomList;
		if (floor == 0) {roomList = roomService.getRoomList();} 
		else {roomList = roomService.getRoomByFloor(floor);}
		
		int availableCount = 0;
		int occupiedCount = 0;
		int cleaningCount = 0;
		int inspectionCount = 0;
		
		for (RoomDTO room : allRoomList) {
			if ("이용가능".equals(room.getStatus())) {availableCount++;} 
			else if ("투숙중".equals(room.getStatus())) {occupiedCount++;} 
			else if ("청소중".equals(room.getStatus())) {cleaningCount++;} 
			else if ("점검중".equals(room.getStatus())) {inspectionCount++;}
		}

		model.addAttribute("roomList", roomList);
		model.addAttribute("selectedFloor", floor);
		
		model.addAttribute("totalCount", allRoomList.size());
		model.addAttribute("availableCount", availableCount);
		model.addAttribute("occupiedCount", occupiedCount);
		model.addAttribute("cleaningCount", cleaningCount);
		model.addAttribute("inspectionCount", inspectionCount);
		
		int totalCount = availableCount + occupiedCount + cleaningCount + inspectionCount;
		int availableRate = 0;
		int occupiedRate = 0;
		int cleaningRate = 0;
		int inspectionRate = 0;

		if (totalCount > 0) {
		    availableRate = (int) Math.round(availableCount * 100.0 / totalCount);
		    occupiedRate = (int) Math.round(occupiedCount * 100.0 / totalCount);
		    cleaningRate = (int) Math.round(cleaningCount * 100.0 / totalCount);
		    inspectionRate = (int) Math.round(inspectionCount * 100.0 / totalCount);
		}

		model.addAttribute("availableRate", availableRate);
		model.addAttribute("occupiedRate", occupiedRate);
		model.addAttribute("cleaningRate", cleaningRate);
		model.addAttribute("inspectionRate", inspectionRate);
		
		model.addAttribute("pageTitle", "객실 현황");
		model.addAttribute("pageDescription", "호텔 전체 객실 상태 확인");
		
		return "admin/room/list";
	}
	
	// 객실 상세
	@GetMapping("/{roomId}")
	@ResponseBody
	public RoomDTO roomDetail(@PathVariable int roomId) {
		return roomService.getRoomDetail(roomId);
	}
}
