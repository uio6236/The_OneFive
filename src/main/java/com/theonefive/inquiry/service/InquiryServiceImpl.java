package com.theonefive.inquiry.service;

import com.theonefive.inquiry.model.dto.InquiryDTO;
import com.theonefive.inquiry.model.mapper.InquiryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
 
import java.util.List;
 
@Service
public class InquiryServiceImpl implements InquiryService {
 
   
 
    @Autowired
    private InquiryMapper inquiryMapper;
 
    // ===== 관리자 =====
 
    @Override
    public List<InquiryDTO> getInquiryList(String keyword, String status, String sortOrder, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return inquiryMapper.selectInquiryList(keyword, status, sortOrder, offset, pageSize);
    }
 
    @Override
    public int getInquiryCount(String keyword, String status) {
        return inquiryMapper.selectInquiryCount(keyword, status);
    }
 
    @Override
    public InquiryDTO getInquiryDetail(Long id) {
        return inquiryMapper.selectInquiryById(id);
    }
 
    @Override
    public void answerInquiry(InquiryDTO dto) {
        inquiryMapper.updateAnswer(dto);
    }
 
    // ===== 고객 =====
 
    @Override
    public List<InquiryDTO> getMyInquiryList(Long guestId) {
        return inquiryMapper.selectInquiryListByGuest(guestId);
    }
 
    @Override
    public InquiryDTO getMyInquiryDetail(Long id, Long guestId) {
        return inquiryMapper.selectInquiryByIdForGuest(id, guestId);
    }
 
    @Override
    public void submitInquiry(InquiryDTO dto) {
        inquiryMapper.insertInquiry(dto);
    }
}