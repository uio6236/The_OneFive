package com.theonefive.common;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/*
 * 관리자 로그인 여부를 확인하는 인터셉터
 * /admin/** 요청이 Controller에 도착하기 전에 실행된다.
 */
public class AdminLoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(
			HttpServletRequest request,
			HttpServletResponse response,
			Object handler) throws Exception {

		// 기존 세션이 있을 때만 가져온다.
		HttpSession session = request.getSession(false);

		// 관리자 로그인 여부 확인
		boolean isLoggedIn =
				session != null
				&& session.getAttribute("loginAdmin") != null;

		// 로그인 상태라면 Controller로 진행
		if (isLoggedIn) {
			return true;
		}

		// 로그인하지 않았다면 관리자 로그인 페이지로 이동
		response.sendRedirect("/admin/adminLogin");

		// Controller 실행 중단
		return false;
	}
}