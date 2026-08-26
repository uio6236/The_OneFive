package com.theonefive.customer.common;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	@Bean	// 해당 메소드가 반환하는 객체(SecurityFilterChain)를 스프링 빈으로 등록
	public SecurityFilterChain filterChain(HttpSecurity http) {
		/*
		 * HttpSecurity : HTTP 요청에 대한 보안 설정을 체이닝 방식으로 구성하는 빌더 객체.
		 * 
		 * - CSRF (Cross-Site Request Forgery) : 사이트 간 요청 위조
		 * 		=> 세션 기반 인증 + fetch(REST API) 사용할 예정으로 비활성화
		 * - formLogin : 시큐리티 기본 로그인 폼
		 * - HTTP Basic 인증 : 인증 헤더에 ID/PW를 Base64로 인코딩해서 보내는 인증 방식
		 * - logout : 시큐리티 기본 로그아웃 처리
		 * -----> 비활성화 처리 (AbstractHttpConfigurer::disable)
		 * 						=> 각 보안 기능의 설정 클래스에 정의된 disable 메소드를 참조 
		 * 
		 * - authorizeHttpRequests : 인증 여부에 따른 접근 제어
		 */
		
		http.csrf(AbstractHttpConfigurer::disable)
			.formLogin(AbstractHttpConfigurer::disable)
			.httpBasic(AbstractHttpConfigurer::disable)
			.logout(AbstractHttpConfigurer::disable)
			.authorizeHttpRequests(auth -> auth.anyRequest().permitAll()); // 모든 요청 허용
		
		return http.build();
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
