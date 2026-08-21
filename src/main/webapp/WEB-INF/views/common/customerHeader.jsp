<%@ page contentType="text/html; charset=UTF-8" %>

<header class="customer-header">

    <a
        href="/customer/main"
        class="customer-logo"
    >

        <span class="customer-logo-icon">
            ▣
        </span>

        <span>
            The OneFive
        </span>

    </a>


    <nav class="customer-nav">

        <a href="/customer/main">
            객실 예약
        </a>

        <a href="/customer/reservation/payment">
            예약 결제
        </a>

        <a href="/customer/mypage">
            마이페이지
        </a>

    </nav>


    <div class="customer-user-area">

        <span>
            ${sessionScope.loginCustomer.customerName} 고객님
        </span>

        <img
            src="/images/common/customer-profile.png"
            alt="고객 프로필"
            class="customer-user-image"
        >

        <a href="/logout">
            로그아웃
        </a>

    </div>

</header>