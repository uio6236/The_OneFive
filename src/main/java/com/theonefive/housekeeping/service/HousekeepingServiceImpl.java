package com.theonefive.housekeeping.service;

import com.theonefive.housekeeping.model.mapper.HousekeepingMapper;
import com.theonefive.housekeeping.model.dto.EmployeeDTO;
import com.theonefive.housekeeping.model.dto.HousekeepingDTO;
import com.theonefive.housekeeping.model.dto.HousekeepingSearchConditionDTO;
import com.theonefive.housekeeping.model.dto.StatusCountDTO;
import com.theonefive.housekeeping.model.mapper.EmployeeMapper;
import com.theonefive.housekeeping.model.mapper.RoomMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class HousekeepingServiceImpl implements HousekeepingService {

    private final HousekeepingMapper housekeepingMapper;
    private final RoomMapper roomMapper;
    private final EmployeeMapper employeeMapper;

    @Override
    public List<HousekeepingDTO> getList(HousekeepingSearchConditionDTO condition) {
        return housekeepingMapper.selectList(condition);
    }

    @Override
    public HousekeepingDTO getDetail(Long id) {
        return housekeepingMapper.selectById(id);
    }

    @Override
    public List<StatusCountDTO> getStatusCount() {
        // 상태별 건수 카드 3개(청소대기/청소중/점검완료)를 항상 이 순서로 고정
        // GROUP BY는 0건인 상태를 결과에서 아예 빼버리므로, 화면에 "0개 객실"이라고
        // 보여주기 위해 빈 상태는 여기서 0으로 직접 채워 넣는다
        List<String> order = List.of("청소대기", "청소중", "점검완료");
        List<StatusCountDTO> raw = housekeepingMapper.selectStatusCount();

        Map<String, Integer> countMap = new HashMap<>();
        for (StatusCountDTO s : raw) countMap.put(s.getStatus(), s.getCount());

        List<StatusCountDTO> result = new ArrayList<>();
        for (String status : order) {
            StatusCountDTO dto = new StatusCountDTO();
            dto.setStatus(status);
            dto.setCount(countMap.getOrDefault(status, 0));  // 없으면 0건
            result.add(dto);
        }
        return result;
    }

    @Override
    public List<Long> assignEmployee(List<Long> ids, Long employeeId) {
        // 여러 건을 한 번에 배정하되, 하나가 실패해도 나머지는 계속 처리
        // (전체 중단 대신 성공한 id만 모아서 반환)
        List<Long> success = new ArrayList<>();
        for (Long id : ids) {
            HousekeepingDTO target = housekeepingMapper.selectById(id);
            if (target == null) continue;   // 존재하지 않는 id는 건너뜀

            // 점검까지 끝난 건은 담당자 재배정 불가
            if ("점검완료".equals(target.getStatus())) continue;

            HousekeepingDTO dto = new HousekeepingDTO();
            dto.setId(id);
            dto.setEmployeeId(employeeId);
            housekeepingMapper.assignEmployee(dto);
            success.add(id);
        }
        return success;
    }

    @Override
    public List<Long> startCleaning(List<Long> ids) {
        List<Long> success = new ArrayList<>();
        for (Long id : ids) {
            HousekeepingDTO target = housekeepingMapper.selectById(id);
            if (target == null) continue;

            // 청소대기 상태일 때만 시작 가능 (이미 진행 중인 건 재시작 방지)
            if (!"청소대기".equals(target.getStatus())) continue;
            housekeepingMapper.startCleaning(id);

            // [Room 연동 예정] 청소 시작 시 객실 상태도 함께 "청소중"으로 갱신.
            // 지금은 RoomMapper를 직접 호출하지만, room 도메인이 따로 생기면
            // 이 한 줄을 그쪽 Service의 메소드 호출로 바꾸는 걸 고려할 것.
            roomMapper.updateRoomStatus(target.getRoomId().intValue(), "청소중");
            success.add(id);
        }
        return success;
    }

    @Override
    public List<Long> completeCleaning(List<Long> ids) {
        List<Long> success = new ArrayList<>();
        for (Long id : ids) {
            HousekeepingDTO target = housekeepingMapper.selectById(id);
            if (target == null) continue;

            // STATUS가 '청소중'이면서 COMPLETED_AT이 아직 없을 때만 처리
            // (HOUSEKEEPING.STATUS는 청소대기/청소중/점검완료 세 값만 허용하므로,
            //  '청소 완료' 상태는 STATUS 대신 COMPLETED_AT 기록 여부로 표현한다)
            if (!"청소중".equals(target.getStatus())) continue;
            if (target.getCompletedAt() != null) continue;
            housekeepingMapper.completeCleaning(id);

            // [Room 연동 예정] 청소가 끝나면 객실은 점검 대기 상태로 전환
            roomMapper.updateRoomStatus(target.getRoomId().intValue(), "점검중");
            success.add(id);
        }
        return success;
    }

    @Override
    public List<Long> inspect(List<Long> ids) {
        List<Long> success = new ArrayList<>();
        for (Long id : ids) {
            HousekeepingDTO target = housekeepingMapper.selectById(id);
            if (target == null) continue;

            // 청소가 끝나고 점검을 기다리는 건(STATUS='청소중' && COMPLETED_AT 존재)만 처리
            if (!"청소중".equals(target.getStatus()) || target.getCompletedAt() == null) continue;
            housekeepingMapper.inspect(id);

            // [Room 연동 예정] 점검까지 끝나면 객실을 다시 예약 가능한 상태로 전환.
            // 이 시점에 "객실 현황" 화면이 있다면 그 목록도 자동으로 갱신돼야 함
            // (지금은 하우스키핑 폴링만 갱신되고, room 쪽 화면이 따로 있다면
            //  그 화면도 폴링하든 새로고침하든 별도로 최신화 방법이 필요함).
            roomMapper.updateRoomStatus(target.getRoomId().intValue(), "이용가능");
            success.add(id);
        }
        return success;
    }

    @Override
    public void updateNote(Long id, String note) {
        housekeepingMapper.updateNote(id, note);
    }

    @Override
    public List<EmployeeDTO> getEmployees() {
        return employeeMapper.selectAll();
    }
}