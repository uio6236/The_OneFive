package com.theonefive.reservation.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.theonefive.reservation.model.dto.ReservationDTO;
import com.theonefive.reservation.model.dto.ReservationSearchDTO;
import com.theonefive.reservation.model.dto.ReservationViewDTO;
import com.theonefive.reservation.model.dto.RoomTypeListDTO;
import com.theonefive.reservation.model.mapper.ReservationMapper;

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

	@Override
	public void createReservation(ReservationDTO dto) {
		 if (dto.getStatus() == null) {
	            dto.setStatus("예약확정");
	        }
	        if (dto.getDiscountAmount() == null) {
	            dto.setDiscountAmount(0);
	        }
	        if (dto.getTotalAmount() == null && dto.getRoomAmount() != null) {
	            dto.setTotalAmount(dto.getRoomAmount() - dto.getDiscountAmount());
	        }

	        reservationMapper.insertReservation(dto);
		
	}

	@Override
	public void cancelReservation(Long id) {
		 reservationMapper.cancelReservation(id);
		
	}

	@Override
	public List<ReservationViewDTO> findReservationList(ReservationSearchDTO condition) {
	    return reservationMapper.findReservationList(condition);
	}
	@Override
	public List<ReservationViewDTO> findByGuestId(Long guestId) {
		return reservationMapper.findByGuestId(guestId);
	}

	@Override
	public ReservationViewDTO findDetailById(Long id) {
		return reservationMapper.findDetailById(id);
	}
	
	@Override
	public List<RoomTypeListDTO> findRoomTypeList() {
	    return reservationMapper.findRoomTypeList();
	}

}