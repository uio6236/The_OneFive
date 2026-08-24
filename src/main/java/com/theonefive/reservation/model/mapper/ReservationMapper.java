package com.theonefive.reservation.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.theonefive.reservation.model.dto.ReservationDTO;

@Mapper
public interface ReservationMapper {
	List<ReservationDTO> findAll();
	
	ReservationDTO findById(Long id);
}
