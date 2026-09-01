package com.theonefive.housekeeping.model.mapper;

import com.theonefive.housekeeping.model.dto.HousekeepingDTO;
import com.theonefive.housekeeping.model.dto.HousekeepingSearchConditionDTO;
import com.theonefive.housekeeping.model.dto.StatusCountDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface HousekeepingMapper {

    // 층/상태/담당자 필터가 적용된 하우스키핑 목록 조회
    List<HousekeepingDTO> selectList(HousekeepingSearchConditionDTO condition);

    // id 단건 조회
    HousekeepingDTO selectById(Long id);

    // 담당자(EMPLOYEE_ID) 변경
    int assignEmployee(HousekeepingDTO dto);

    // 청소 시작: STATUS='청소중', STARTED_AT 기록
    int startCleaning(Long id);

    // 청소 완료: STATUS는 그대로 두고 COMPLETED_AT만 기록
    int completeCleaning(Long id);

    // 점검 완료: STATUS='점검완료', INSPECTED_AT 기록
    int inspect(Long id);

    // 비고(NOTE) 저장
    int updateNote(@Param("id") Long id, @Param("note") String note);

    // 상태별(STATUS) 건수 집계
    List<StatusCountDTO> selectStatusCount();
    
    // 청소대기 작업 생성
    // 객실 정비 요청 생성
    //int insertCleaningRequest(HousekeepingDTO dto);
    
    // 해당 방의 최신 하우스키핑 이력 기준 체크인 가능 여부 조회
    //boolean isRoomReady(int roomId); 
}