package com.theonefive.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.theonefive.common.AdminLoginInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	@Override
	public void addInterceptors(InterceptorRegistry registry) {

		registry.addInterceptor(new AdminLoginInterceptor())
			.addPathPatterns("/admin/**")
			.excludePathPatterns(
				"/admin/adminLogin",
				"/admin/adminSignup",
				"/admin/checkCode"
			);
	}
}