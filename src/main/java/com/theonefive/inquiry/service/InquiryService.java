package com.theonefive.inquiry.service;
import com.theonefive.inquiry.model.dto.InquiryDTO;
import java.util.List;

import com.theonefive.inquiry.model.dto.InquiryDTO;

public interface InquiryService {
	 
    // 관리자
    List<InquiryDTO> getInquiryList(String keyword, String status, String sortOrder, int page, int pageSize);
    int getInquiryCount(String keyword, String status);
    InquiryDTO getInquiryDetail(Long id);
    void answerInquiry(InquiryDTO dto);
 
    // 고객
    List<InquiryDTO> getMyInquiryList(Long guestId, int page, int pageSize);
    int getMyInquiryCount(Long guestId);
    InquiryDTO getMyInquiryDetail(Long id, Long guestId);
    void submitInquiry(InquiryDTO dto);
 
    // 고객 마이페이지 등에서 참조 - 본인 문의 중 아직 답변 안 된(대기중) 건수
    // 파라미터를 long(기본형)으로 둬서, CustomerDTO.getId()가 int를 리턴해도
    // 호출하는 쪽에서 별도 형변환 없이 그대로 넘길 수 있게 함
    int countUnansweredInquiry(long guestId);
}
 