<%@ page contentType="text/html; charset=UTF-8" %>

<aside class="admin-sidebar">

    <div class="admin-logo">
        <div class="admin-logo-icon">
            ▣
        </div>

        <div>
            <div class="admin-logo-title">
                The OneFive
            </div>

            <div class="admin-logo-subtitle">
                HOTEL PMS
            </div>
        </div>
    </div>


    <ul class="admin-menu">

        <li class="admin-menu-item">
            <a href="/admin/dashboard">
                <span class="admin-menu-icon">▦</span>
                대시보드
            </a>
        </li>

        <li class="admin-menu-item">
            <a href="/admin/reservations">
                <span class="admin-menu-icon">□</span>
                예약 관리
            </a>
        </li>

        <li class="admin-menu-item">
            <a href="/admin/rooms">
                <span class="admin-menu-icon">⚿</span>
                객실 현황
            </a>
        </li>

        <li class="admin-menu-item">
            <a href="/admin/checkin">
                <span class="admin-menu-icon">↔</span>
                체크인/아웃
            </a>
        </li>

        <li class="admin-menu-item">
            <a href="/admin/customers">
                <span class="admin-menu-icon">♙</span>
                투숙객 목록
            </a>
        </li>

        <li class="admin-menu-item">
            <a href="/admin/housekeeping">
                <span class="admin-menu-icon">⌁</span>
                하우스키핑
            </a>
        </li>

        <li class="admin-menu-item">
            <a href="/admin/inquiries">
                <span class="admin-menu-icon">□</span>
                문의 관리
            </a>
        </li>

        <li class="admin-menu-item">
            <a href="/admin/mypage">
                <span class="admin-menu-icon">♙</span>
                마이페이지
            </a>
        </li>

    </ul>


    <div class="admin-profile">

        <img
            src="/images/common/admin-profile.png"
            alt="관리자 프로필"
            class="admin-profile-image"
        >

        <div>
            <div class="admin-profile-name">
                ${sessionScope.loginEmployee.employeeName}
            </div>

            <div class="admin-profile-role">
                프론트 데스크 팀
            </div>
        </div>

    </div>

</aside>