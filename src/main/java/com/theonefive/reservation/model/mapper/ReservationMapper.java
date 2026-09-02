package com.theonefive.reservation.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.theonefive.reservation.model.dto.ReservationDTO;
import com.theonefive.reservation.model.dto.ReservationSearchDTO;
import com.theonefive.reservation.model.dto.ReservationViewDTO;
import com.theonefive.reservation.model.dto.RoomSearchDTO;
import com.theonefive.reservation.model.dto.RoomTypeListDTO;

@Mapper
public interface ReservationMapper {

    // RESERVATION 테이블 전체 조회 
    List<ReservationDTO> findAll();

    // ID로 예약 1건 조회
    ReservationDTO findById(Long id);

    // 예약 등록 (insert 안에서 selectKey로 ID/CODE까지 같이 처리됨)
    int insertReservation(ReservationDTO dto);

    // 예약 취소 (STATUS만 변경, 삭제 아님)
    int cancelReservation(Long id);

    // 관리자 예약 목록 조회 (CUSTOMER, ROOM, ROOM_TYPE join)
    List<ReservationViewDTO> findReservationList(ReservationSearchDTO condition);

    // 예약 상세 1건 조회 (join 포함, 우측 패널용)
    ReservationViewDTO findDetailById(Long id);

    // 특정 고객 한 명의 예약 목록 조회 (마이페이지용)
    List<ReservationViewDTO> findByGuestId(Long guestId);
    
    // 방 정보
    List<RoomTypeListDTO> findRoomTypeList(RoomSearchDTO condition);
    
    RoomTypeListDTO findRoomTypeDetail(Long roomTypeId);
    
    int countAvailableRooms(RoomSearchDTO condition);
    
    // 체크아웃한 예약을 이용완료로 변경
    int completeReservationByCheckinId(int checkinId);
}