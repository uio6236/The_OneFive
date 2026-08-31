package com.theonefive.housekeeping.model.dto;

import lombok.Getter;
import lombok.Setter;

// 비고/전달사항 저장 요청 바디
@Getter
@Setter
public class NoteDTO {
    private Long id;      // 비고를 저장할 HOUSEKEEPING id
    private String note;  // 저장할 비고/전달사항 텍스트
}