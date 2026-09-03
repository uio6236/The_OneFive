package com.theonefive.inquiry.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.theonefive.inquiry.model.dto.InquiryDTO;

@Mapper
public interface InquiryMapper {
 
    // ===== 관리자 =====
 
    // 검색/필터/페이지네이션이 적용된 문의 목록 (고객명 조인 포함)
    // keyword, status가 null이면 조건 없이 전체 대상
    // sortOrder: "latest"(최신순, 기본) 또는 "oldest"(오래된순)
    List<InquiryDTO> selectInquiryList(@Param("keyword") String keyword,
                                        @Param("status") String status,
                                        @Param("sortOrder") String sortOrder,
                                        @Param("offset") int offset,
                                        @Param("pageSize") int pageSize);
 
    // 같은 검색/필터 조건에서 전체 건수 (페이지네이션 계산용)
    int selectInquiryCount(@Param("keyword") String keyword,
                            @Param("status") String status);
 
    // 문의 상세 조회
    InquiryDTO selectInquiryById(Long id);
 
    // 관리자 답변 등록/수정 + 상태 변경
    int updateAnswer(InquiryDTO dto);
 
    // ===== 고객 =====
 
    // 로그인한 고객 본인의 문의 목록만 조회 (페이지네이션 적용)
    List<InquiryDTO> selectInquiryListByGuest(@Param("guestId") Long guestId,
                                               @Param("offset") int offset,
                                               @Param("pageSize") int pageSize);
 
    // 본인 문의 전체 건수 (페이지네이션 계산용)
    int selectInquiryCountByGuest(@Param("guestId") Long guestId);
 
    // 본인 문의 중 아직 답변 안 된(대기중) 건수
    int selectUnansweredCountByGuest(@Param("guestId") long guestId);
 
    // 본인 문의인지 확인하며 상세 조회 (다른 사람 문의 열람 방지)
    InquiryDTO selectInquiryByIdForGuest(Long id, Long guestId);
 
    // 고객 문의 등록
    int insertInquiry(InquiryDTO dto);
}
 