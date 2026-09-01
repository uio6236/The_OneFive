package com.theonefive.inquiry.model.dto;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString

public class InquiryDTO {


    private Long id;
    private String inquiryNo;      // 문의번호 (예: INQ-20260812-01)
    private Long guestId;          // 고객 ID (FK -> CUSTOMER.ID)
    private String title;          // 문의 제목
    private String content;        // 문의 내용
    private String status;         // 대기중 / 답변완료
    private String answer;         // 관리자 답변
    private Long answeredBy;       // 답변한 관리자 ID (FK -> EMPLOYEE.ID)
    private Date answeredAt;
    private Date createdAt;
 
    // 화면 표시용으로 조인해서 채울 필드 (테이블엔 없지만 자주 필요함)
    private String guestName;      // CUSTOMER.NAME 조인
    private String guestEmail;     // CUSTOMER.EMAIL 조인
}
