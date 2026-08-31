package com.theonefive.reservation.service;

import java.util.List;

import com.theonefive.reservation.model.dto.ReservationDTO;
import com.theonefive.reservation.model.dto.ReservationSearchDTO;
import com.theonefive.reservation.model.dto.ReservationViewDTO;
import com.theonefive.reservation.model.dto.RoomSearchDTO;
import com.theonefive.reservation.model.dto.RoomTypeListDTO;

public interface ReservationService {

    List<ReservationDTO> findAll();

    ReservationDTO findById(Long id);
    
    void createReservation(ReservationDTO dto);

    void cancelReservation(Long id);

    List<ReservationViewDTO> findReservationList(ReservationSearchDTO condition);
    
    ReservationViewDTO findDetailById(Long id);
    
    List<ReservationViewDTO> findByGuestId(Long guestId);
    
    RoomTypeListDTO findRoomTypeDetail(Long roomTypeId);
    
    List<RoomTypeListDTO> findRoomTypeList(RoomSearchDTO condition);
    
    int countAvailableRooms(RoomSearchDTO condition);

}