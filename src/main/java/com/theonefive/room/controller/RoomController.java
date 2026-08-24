package com.theonefive.room.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.theonefive.room.service.RoomService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin/room")
@RequiredArgsConstructor
public class RoomController {
	private final RoomService roomService;
	
	
}
