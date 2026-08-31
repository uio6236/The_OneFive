package com.theonefive.customer.common;

import com.theonefive.customer.model.dto.CustomerDTO;
import com.theonefive.customer.service.CustomerService;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalCustomerAdvice {

    private final CustomerService customerService;

    public GlobalCustomerAdvice(CustomerService customerService) {
        this.customerService = customerService;
    }

    @ModelAttribute("customer")
    public CustomerDTO addLoginCustomer(HttpSession session) {
        String loginId = (String) session.getAttribute("loginId");
        if (loginId == null) {
            return null;
        }
        return customerService.getCustomerByLoginId(loginId);
    }
}