package com.theonefive.employee.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class EmployeeDTO {
 
    private Long id;
    private String code;       // 사원번호 (예: EP1002)
    private String name;
    private String password;
    private String position;   // 직책 (예: FRONT DESK) -- 마이페이지의 "소속 부서" 표시에 사용
    private String phone;
    private String email;
 
    // 비밀번호 변경 폼에서만 쓰는 값 (테이블 컬럼 아님)
    private String currentPassword;
    private String newPassword;
    private String newPasswordCheck;
}