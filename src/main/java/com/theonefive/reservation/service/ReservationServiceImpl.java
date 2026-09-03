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
    	// 전체 예약 목록 조회
        return reservationMapper.findAll();
    }

    @Override
    public ReservationDTO findById(Long id) {
        // 예약 ID를 기준으로 예약 정보 조회
        return reservationMapper.findById(id);
    }

	@Override
	public void createReservation(ReservationDTO dto) {
	    // 예약 정보의 유효성을 확인하고 새로운 예약 등록
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
	    // 예약 상태를 예약취소로 변경
	    int affectedRows = reservationMapper.cancelReservation(id);

	    // 매퍼의 UPDATE는 STATUS='예약확정'인 건만 반영되도록 조건이 걸려있음.
	    // 0건이면 이미 취소/이용완료된 예약이거나 존재하지 않는 id라는 뜻이므로 실패로 처리.
	    if (affectedRows == 0) {
	        throw new IllegalStateException("이미 취소되었거나 이용완료된 예약이거나, 존재하지 않는 예약입니다. id=" + id);
	    }
	}

	@Override
	public List<ReservationViewDTO> findReservationList(ReservationSearchDTO condition) {
	    // 관리자 검색 조건에 맞는 예약 목록 조회
	    return reservationMapper.findReservationList(condition);
	}
	
	@Override
	public List<ReservationViewDTO> findByGuestId(Long guestId) {
	    // 고객 ID에 해당하는 예약 내역 조회
		return reservationMapper.findByGuestId(guestId);
	}

	@Override
	public ReservationViewDTO findDetailById(Long id) {
	    // 관리자용 예약 상세 정보 조회
		return reservationMapper.findDetailById(id);
	}
	
	@Override
	public RoomTypeListDTO findRoomTypeDetail(Long roomTypeId) {
	    // 객실 타입의 상세 정보 조회
	    return reservationMapper.findRoomTypeDetail(roomTypeId);
	}
	
	@Override
	public List<RoomTypeListDTO> findRoomTypeList(RoomSearchDTO condition) {
	    // 예약 조건에 맞는 객실 타입 목록 조회
	    return reservationMapper.findRoomTypeList(condition);
	}
	
	@Override
	public int countAvailableRooms(RoomSearchDTO condition) {
	    // 예약 조건에 맞는 이용 가능 객실 수 조회
	    return reservationMapper.countAvailableRooms(condition);
	}
}