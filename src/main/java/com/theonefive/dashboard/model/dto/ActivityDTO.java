package com.theonefive.dashboard.model.dto;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ActivityDTO {
	    private Date eventTime;
	    private String category;      // 체크인 / 체크아웃 / 객실 정비
	    private String description;   // "405호 고객 체크인 완료"
	    private String employeeName;
}
