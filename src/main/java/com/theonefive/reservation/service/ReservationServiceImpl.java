package com.theonefive.reservation.service;

import com.theonefive.reservation.model.dto.ReservationDTO;
import com.theonefive.reservation.model.dto.ReservationViewDTO;
import com.theonefive.reservation.model.mapper.ReservationMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReservationServiceImpl implements ReservationService {

    private final ReservationMapper reservationMapper;

    public ReservationServiceImpl(ReservationMapper reservationMapper) {
        this.reservationMapper = reservationMapper;
    }

    @Override
    public List<ReservationDTO> findAll() {
        return reservationMapper.findAll();
    }

    @Override
    public ReservationDTO findById(Long id) {
        return reservationMapper.findById(id);
    }

}