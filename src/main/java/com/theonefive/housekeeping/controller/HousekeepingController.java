package com.theonefive.housekeeping.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.theonefive.common.dto.ApiResponse;
import com.theonefive.housekeeping.model.dto.AssignEmployeeDTO;
import com.theonefive.housekeeping.model.dto.EmployeeDTO;
import com.theonefive.housekeeping.model.dto.HousekeepingDTO;
import com.theonefive.housekeeping.model.dto.HousekeepingListResponseDTO;
import com.theonefive.housekeeping.model.dto.HousekeepingSearchConditionDTO;
import com.theonefive.housekeeping.model.dto.NoteDTO;
import com.theonefive.housekeeping.model.dto.StatusChangeDTO;
import com.theonefive.housekeeping.service.HousekeepingService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HousekeepingController {

    private final HousekeepingService housekeepingService;

    // 하우스키핑 현황 페이지 진입 시 목록 + 상태별 카드 + 필터를 한 번에 조회
    @GetMapping("/admin/housekeeping")
    public String list(@RequestParam(required = false) Integer floor,
                        @RequestParam(required = false) String status,
                        @RequestParam(required = false) String employeeName,
                        Model model) {

        // 필터값(층/상태/담당자)을 조건 객체 하나로 묶음
        HousekeepingSearchConditionDTO condition = new HousekeepingSearchConditionDTO();
        condition.setFloor(floor);
        condition.setStatus(status);
        condition.setEmployeeName(employeeName);

        // 필터 조건에 맞는 목록 조회
        model.addAttribute("list", housekeepingService.getList(condition));
        // 상태별(청소대기/청소중/점검완료) 건수 집계
        model.addAttribute("statusCounts", housekeepingService.getStatusCount());
        // 조회 후 필터값이 그대로 선택돼 있도록 유지
        model.addAttribute("selectedFloor", floor);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedEmployeeName", employeeName);
        
        model.addAttribute("pageTitle", "하우스키핑 관리");
        model.addAttribute("pageDescription", "실시간 객실 청소 지시 및 진행 현황 통제");
        
        model.addAttribute("today", new SimpleDateFormat("yyyy년 M월 d일 EEEE", Locale.KOREAN).format(new Date()));
        

        return "admin/housekeeping/list";
    }

    // 행 클릭 시 상세패널에 표시할 단건 정보 조회
    @GetMapping("/api/housekeeping/detail")
    @ResponseBody
    public ResponseEntity<ApiResponse<HousekeepingDTO>> detail(@RequestParam Long id) {
        HousekeepingDTO dto = housekeepingService.getDetail(id);
        if (dto == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(ApiResponse.fail("존재하지 않는 작업입니다."));
        }
        return ResponseEntity.ok(ApiResponse.success(dto));
    }

    // 선택한 하우스키핑 작업에 담당 직원을 배정
    @PostMapping("/api/housekeeping/assign")
    @ResponseBody
    public ResponseEntity<ApiResponse<List<Long>>> assign(@RequestBody AssignEmployeeDTO request) {
        List<Long> success = housekeepingService.assignEmployee(request.getIds(), request.getEmployeeId());
        if (success.isEmpty()) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(ApiResponse.fail("배정 가능한 작업이 없습니다."));
        }
        return ResponseEntity.ok(ApiResponse.success(success.size() + "건 배정 완료", success));
    }

    // 선택한 객실의 청소 작업을 시작 처리
    @PostMapping("/api/housekeeping/start")
    @ResponseBody
    public ResponseEntity<ApiResponse<List<Long>>> start(@RequestBody StatusChangeDTO request) {
        List<Long> success = housekeepingService.startCleaning(request.getIds());
        if (success.isEmpty()) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(ApiResponse.fail("청소대기 상태인 작업이 없습니다."));
        }
        return ResponseEntity.ok(ApiResponse.success(success.size() + "건 청소를 시작합니다.", success));
    }

    // 선택한 객실의 청소 완료 처리
    @PostMapping("/api/housekeeping/complete")
    @ResponseBody
    public ResponseEntity<ApiResponse<List<Long>>> complete(@RequestBody StatusChangeDTO request) {
        List<Long> success = housekeepingService.completeCleaning(request.getIds());
        if (success.isEmpty()) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(ApiResponse.fail("청소중 상태인 작업이 없습니다."));
        }
        return ResponseEntity.ok(ApiResponse.success(success.size() + "건 청소를 완료했습니다.", success));
    }

    // 객실 점검을 완료하고 객실을 이용가능 상태로 변경
    @PostMapping("/api/housekeeping/inspect")
    @ResponseBody
    public ResponseEntity<ApiResponse<List<Long>>> inspect(@RequestBody StatusChangeDTO request) {
        List<Long> success = housekeepingService.inspect(request.getIds());
        if (success.isEmpty()) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(ApiResponse.fail("청소완료 상태인 작업이 없습니다."));
        }
        return ResponseEntity.ok(ApiResponse.success(success.size() + "건 점검을 완료했습니다.", success));
    }

    // 하우스키핑 작업의 메모 내용 저장
    @PostMapping("/api/housekeeping/note")
    @ResponseBody
    public ResponseEntity<ApiResponse<Long>> saveNote(@RequestBody NoteDTO request) {
        housekeepingService.updateNote(request.getId(), request.getNote());
        return ResponseEntity.ok(ApiResponse.success("비고가 저장되었습니다.", request.getId()));
    }

    // 화면 새로고침 없이 표/카드만 갱신하기 위한 폴링용 API (기존 조회 로직 재사용, JSON만 반환)
    @GetMapping("/api/housekeeping/list")
    @ResponseBody
    public ResponseEntity<ApiResponse<HousekeepingListResponseDTO>> listJson(
            @RequestParam(required = false) Integer floor,
            @RequestParam(required = false) String status) {

        HousekeepingSearchConditionDTO condition = new HousekeepingSearchConditionDTO();
        condition.setFloor(floor);
        condition.setStatus(status);

        HousekeepingListResponseDTO response = new HousekeepingListResponseDTO(
                housekeepingService.getList(condition),
                housekeepingService.getStatusCount()
        );
        return ResponseEntity.ok(ApiResponse.success(response));
    }

    // 하우스키핑 담당자로 배정할 수 있는 직원 목록 조회
    @GetMapping("/api/employees")
    @ResponseBody
    public ResponseEntity<ApiResponse<List<EmployeeDTO>>> employees() {
        return ResponseEntity.ok(ApiResponse.success(housekeepingService.getEmployees()));
    }
   }
