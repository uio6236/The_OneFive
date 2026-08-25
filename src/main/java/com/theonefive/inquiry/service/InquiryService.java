package com.theonefive.inquiry.service;
import com.theonefive.inquiry.model.dto.InquiryDTO;
import java.util.List;

import com.theonefive.inquiry.model.dto.InquiryDTO;

public interface InquiryService {
	 // 관리자
    List<InquiryDTO> getInquiryList(String keyword, String status, int page, int pageSize);
    int getInquiryCount(String keyword, String status);
    InquiryDTO getInquiryDetail(Long id);
    void answerInquiry(InquiryDTO dto);
 
    // 고객
    List<InquiryDTO> getMyInquiryList(Long guestId);
    InquiryDTO getMyInquiryDetail(Long id, Long guestId);
    void submitInquiry(InquiryDTO dto);
}
