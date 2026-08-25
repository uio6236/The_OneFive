package com.theonefive.reservation.service;

import com.theonefive.reservation.model.dto.ReservationDTO;
import com.theonefive.reservation.model.dto.ReservationViewDTO;

import java.util.List;

public interface ReservationService {

    List<ReservationDTO> findAll();

    ReservationDTO findById(Long id);
    
    void createReservation(ReservationDTO dto);

    void cancelReservation(Long id);

    List<ReservationViewDTO> findReservationList();
    
    ReservationViewDTO findDetailById(Long id);
    
    List<ReservationViewDTO> findByGuestId(Long guestId);

}