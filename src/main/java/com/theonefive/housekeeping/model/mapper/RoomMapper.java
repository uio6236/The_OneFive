package com.theonefive.housekeeping.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/*
 * 하우스키핑 상태 전이 시 함께 갱신되는 객실 상태 변경용 Mapper.
 *
 * [Room 연동 예정]
 * 현재는 하우스키핑 패키지 안에 "객실 상태만 바꾸는" 최소 기능으로 들어있음.
 * 이후 "객실 현황" 기능(방 목록/객실별 상세 등)을 별도 도메인(room 패키지)으로
 * 만들게 되면, 이 Mapper는 두 가지 방향 중 하나로 정리해야 함.
 *   ① room 패키지에 RoomMapper를 새로 만들고, 이 파일은 삭제 후
 *      housekeeping.service에서 room 패키지의 RoomMapper를 대신 주입받는다.
 *   ② 이 Mapper를 그대로 두고, room 패키지의 Service가 이 클래스를 가져다 쓴다.
 * 어느 쪽이든 ROOM 테이블 자체는 하나뿐이므로, 두 도메인이 같은 테이블을
 * 바라볼 때 상태값 종류("청소중"/"점검중"/"이용가능"/객실 자체의 다른 상태 등)가
 * 서로 어긋나지 않는지 반드시 맞춰봐야 함.
 */
@Mapper
public interface RoomMapper {

    // 객실 상태(ROOM.STATUS) 변경
    int updateRoomStatus(@Param("roomId") int roomId, @Param("status") String status);

    /*
     * [Room 연동 예시 - 아직 사용되지 않음]
     * "객실 현황" 페이지가 만들어지면 이 Mapper에 추가로 필요해질 것으로 예상되는 메소드들.
     * 지금 당장 쓰이는 곳이 없어서 실제 메소드로 만들지 않고, 형태만 참고용으로 남겨둠.
     *
     * // 객실 단건 상세 조회 (객실 현황 페이지의 상세 정보용)
     * RoomDTO selectById(int roomId);
     *
     * // 객실 전체 목록 조회 (객실 현황 페이지의 표용, 필터 조건 DTO 필요)
     * List<RoomDTO> selectAll(RoomSearchConditionDTO condition);
     *
     * 실제로 만들 때 이 Mapper에 그대로 추가해도 되고,
     * 위 [Room 연동 예정] 설명처럼 room 패키지의 별도 Mapper로 옮겨도 됨.
     */
}