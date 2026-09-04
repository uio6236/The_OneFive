package com.theonefive.reservation.service;

import java.util.List;

import com.theonefive.reservation.model.dto.ReservationDTO;
import com.theonefive.reservation.model.dto.ReservationSearchDTO;
import com.theonefive.reservation.model.dto.ReservationViewDTO;
import com.theonefive.reservation.model.dto.RoomSearchDTO;
import com.theonefive.reservation.model.dto.RoomTypeListDTO;

public interface ReservationService {
	// 전체 예약 목록 조회
    List<ReservationDTO> findAll();
    
    // 예약 ID를 기준으로 예약 정보 조회
    ReservationDTO findById(Long id);

    // 예약 정보의 유효성을 확인하고 새로운 예약 등록
    void createReservation(ReservationDTO dto);
    
    // 예약 상태를 예약취소로 변경
    void cancelReservation(Long id);

    // 관리자 검색 조건에 맞는 예약 목록 조회
    List<ReservationViewDTO> findReservationList(ReservationSearchDTO condition);
    
    // 관리자용 예약 상세 정보 조회
    ReservationViewDTO findDetailById(Long id);
    
    // 고객 ID에 해당하는 예약 내역 조회
    List<ReservationViewDTO> findByGuestId(Long guestId);
    
    // 객실 타입의 상세 정보 조회
    RoomTypeListDTO findRoomTypeDetail(Long roomTypeId);
    
    // 예약 조건에 맞는 객실 타입 목록 조회
    List<RoomTypeListDTO> findRoomTypeList(RoomSearchDTO condition);
    
    // 예약 조건에 맞는 이용 가능 객실 수 조회
    int countAvailableRooms(RoomSearchDTO condition);
}