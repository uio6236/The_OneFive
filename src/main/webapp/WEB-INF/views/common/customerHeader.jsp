<%@ page contentType="text/html; charset=UTF-8" %>

<header class="customer-header">

    <a
        href="/customer/reservation/rooms"
        class="customer-logo"
    >

        <span class="customer-logo-icon" >
            <img src="${pageContext.request.contextPath}/images/common/hotel-icon.png" alt="The OneFive 로고">
        </span>

        <span>
            The OneFive
        </span>

    </a>


    <nav class="customer-nav">

        <a href="/customer/reservation/rooms">
            객실 예약
        </a>

        <a href="/mypage/index">
            마이페이지
        </a>

    </nav>


    <div class="customer-user-area">

        <span>
            ${customer.name} 고객님
        </span>


        <a href="/logout">
            로그아웃
        </a>

    </div>

</header>