<%@ page contentType="text/html; charset=UTF-8" %>

<%--
  모든 관리자 페이지 상단에서 <jsp:include>로 재사용되는 공통 사이드바.
  각 메뉴는 href만으로 해당 Controller의 @GetMapping과 연결된다.
  새 관리자 페이지를 추가할 때는 ① Controller에 매핑 추가 ② 여기에 <li> 한 줄 추가, 이 두 가지만 하면 된다.
--%>

<aside class="admin-sidebar">

	<div class="admin-logo">
	      <div class="admin-logo-icon">
	          <img src="${pageContext.request.contextPath}/images/common/hotel-icon.png" alt="The OneFive 로고">
	      </div>
        <div>
            <div class="admin-logo-title">
                The OneFive
            </div>

            <div class="admin-logo-subtitle">
                HOTEL & RESORT
            </div>
        </div>
    </div>

	<%--
	      TODO: 현재 페이지가 어떤 메뉴인지에 따라 admin-menu-item에 "active" 클래스를
	      붙여주는 로직이 없음. admin.css의 .admin-menu-item.active 스타일은 이미
	      정의되어 있으므로, 이후 각 li에 EL로 현재 요청 URI와 비교해서
	      class="admin-menu-item ${pageContext.request.requestURI.contains('housekeeping') ? 'active' : ''}"
	      같은 방식을 붙이거나, Controller에서 model에 현재 메뉴명을 내려주는 방식으로 구현 예정.
	    --%>
		<ul class="admin-menu">

		    <li class="admin-menu-item">
		        <a href="/admin/dashboard">
		            <img src="${pageContext.request.contextPath}/images/common/dashboard.png" class="admin-menu-icon" alt="">
		            대시보드
		        </a>
		    </li>

		    <li class="admin-menu-item">
		        <a href="/admin/reservations">
		            <img src="${pageContext.request.contextPath}/images/common/reservation-icon.png" class="admin-menu-icon" alt="">
		            예약 관리
		        </a>
		    </li>

		    <li class="admin-menu-item">
		        <a href="/admin/room">
		            <img src="${pageContext.request.contextPath}/images/common/room-icon.png" class="admin-menu-icon" alt="">
		            객실 현황
		        </a>
		    </li>


		    <li class="admin-menu-item">
		        <a href="/admin/checkin">
		            <img src="${pageContext.request.contextPath}/images/common/checkin-icon.png" class="admin-menu-icon" alt="">
		            체크인/아웃
		        </a>
		    </li>

		    <li class="admin-menu-item">
		        <a href="/admin/customers">
		            <img src="${pageContext.request.contextPath}/images/common/customer-icon.png" class="admin-menu-icon" alt="">
		            투숙객 목록
		        </a>
		    </li>

		    <li class="admin-menu-item">
		        <a href="/admin/housekeeping">
		            <img src="${pageContext.request.contextPath}/images/common/housekeeping-icon.png" class="admin-menu-icon" alt="">
		            하우스키핑
		        </a>
		    </li>

		    <li class="admin-menu-item">
		        <a href="/admin/inquiries">
		            <img src="${pageContext.request.contextPath}/images/common/inquiry-icon.png" class="admin-menu-icon" alt="">
		            문의 관리
		        </a>
		    </li>

		    <li class="admin-menu-item">
		        <a href="/admin/mypage">
		            <img src="${pageContext.request.contextPath}/images/common/mypage-icon.png" class="admin-menu-icon" alt="">
		            마이페이지
		        </a>
		    </li>

		</ul>

	<%-- 로그인한 관리자 정보 표시 --%>
    <div class="admin-profile">
		<img
		        src="${pageContext.request.contextPath}/images/common/admin-profile.png"
		        alt="관리자 프로필"
		        class="admin-profile-image"
		    >

		    <div>
		        <div class="admin-profile-name">
		            ${sessionScope.loginEmployee.employeeName} 김민준지배인
		        </div>

		        <div class="admin-profile-role">
		            프론트 데스크 팀
		        </div>
		    </div>
			
    </div>

</aside>