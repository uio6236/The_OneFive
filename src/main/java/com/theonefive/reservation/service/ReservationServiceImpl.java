package com.theonefive.reservation.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.theonefive.reservation.model.dto.ReservationDTO;
import com.theonefive.reservation.model.dto.ReservationSearchDTO;
import com.theonefive.reservation.model.dto.ReservationViewDTO;
import com.theonefive.reservation.model.dto.RoomSearchDTO;
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
	    int affectedRows = reservationMapper.cancelReservation(id);

	    // 매퍼의 UPDATE는 STATUS='예약확정'인 건만 반영되도록 조건이 걸려있음.
	    // 0건이면 이미 취소/이용완료된 예약이거나 존재하지 않는 id라는 뜻이므로 실패로 처리.
	    if (affectedRows == 0) {
	        throw new IllegalStateException("이미 취소되었거나 이용완료된 예약이거나, 존재하지 않는 예약입니다. id=" + id);
	    }
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
	public RoomTypeListDTO findRoomTypeDetail(Long roomTypeId) {
	    return reservationMapper.findRoomTypeDetail(roomTypeId);
	}
	
	@Override
	public List<RoomTypeListDTO> findRoomTypeList(RoomSearchDTO condition) {
	    return reservationMapper.findRoomTypeList(condition);
	}
	
	@Override
	public int countAvailableRooms(RoomSearchDTO condition) {
	    return reservationMapper.countAvailableRooms(condition);
	}
}