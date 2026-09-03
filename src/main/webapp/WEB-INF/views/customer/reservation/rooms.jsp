<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 객실 예약</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/customer.css">
    <link rel="stylesheet" href="/css/reservation.css">
</head>

<body>

<div class="customer-page">

    <jsp:include page="/WEB-INF/views/common/customerHeader.jsp"/>

    <main class="customer-main">

        <!-- 프로모션 배너 (지금은 화면만, 고정 문구) -->
        <div class="promo-banner">
            <span class="promo-badge">WELCOME</span>
            <h2>The OneFive 호텔에 오신 걸 환영합니다.</h2>
            <p>정성으로 준비한 객실에서, 편안하고 특별한 시간을 보내세요.</p>
        </div>


        <!-- 날짜/인원 검색 -->
        <form method="get" action="${pageContext.request.contextPath}/customer/reservation/rooms" class="room-search-bar">

            <div class="form-group">
                <label>체크인 날짜</label>
                <input type="date" name="checkinDate" id="checkinDate" class="form-control" value="${condition.checkinDate}" min="${todayStr}" required>
            </div>

            <div class="form-group">
                <label>체크아웃 날짜</label>
                <input type="date" name="checkoutDate" id="checkoutDate" class="form-control" value="${condition.checkoutDate}" min="${tomorrowStr}" required>
            </div>

            <div class="form-group">
                <label>인원</label>
                <input type="number" name="guestCount" class="form-control" value="${condition.guestCount}" min="1" required>
            </div>

            <button type="submit" class="btn btn-primary">검색</button>

        </form>


        <div class="reservation-page-title">
            <h1>예약 가능한 객실</h1>
            <p>금일 입실 가능하도록 전문 청소 및 위생 관리가 완료된 최고의 객실 리스트를 확인하세요.</p>
        </div>


        <!-- 객실 카드 목록 -->
        <div class="room-card-grid">

            <c:forEach var="rt" items="${roomTypeList}">

                <div class="room-card">

                    <div class="room-card-image">

                        <c:choose>
                            <c:when test="${not empty rt.imageUrl}">
                                <img src="${rt.imageUrl}" alt="${rt.typeName}">
                            </c:when>
                            <c:otherwise>
                                <img src="/images/room/default.jpg" alt="${rt.typeName}">
                            </c:otherwise>
                        </c:choose>

                        <c:choose>
                            <c:when test="${rt.availableRoomCount > 0}">
                                <span class="room-available">예약 가능</span>
                            </c:when>
                            <c:otherwise>
                                <span class="room-soldout">예약 마감</span>
                            </c:otherwise>
                        </c:choose>

                    </div>

                    <div class="room-card-content">

                        <h3>${rt.typeName}</h3>

                        <p class="room-card-description">
                                ${rt.description}
                        </p>

                        <div class="room-card-meta">
                            <span>기준 ${rt.capacity}인 / 최대 ${rt.maxCapacity}인</span>
                            <span>무료 초고속 Wi-Fi</span>
                        </div>

                        <div class="room-card-bottom">

                            <div class="room-card-price">
                                <span>1박 요금</span>
                                <strong><fmt:formatNumber value="${rt.price}" pattern="#,###"/>원</strong>
                            </div>

                            <c:choose>
                                <c:when test="${rt.availableRoomCount > 0}">
                                    <a href="${pageContext.request.contextPath}/customer/reservation/detail?roomTypeId=${rt.typeId}&checkinDate=${condition.checkinDate}&checkoutDate=${condition.checkoutDate}&guestCount=${condition.guestCount}"
                                       class="btn btn-primary">
                                        상세보기 및 예약
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-outline" disabled>상세보기 및 예약</button>
                                </c:otherwise>
                            </c:choose>

                        </div>

                    </div>

                </div>

            </c:forEach>

            <c:if test="${empty roomTypeList}">
                <p>등록된 객실 타입이 없습니다.</p>
            </c:if>

        </div>

    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</div>
<script src="/js/reservation.js"></script>

<c:if test="${paymentSuccess}">
    <script>
        alert('결제가 완료되었습니다. 예약이 확정되었습니다.');
    </script>
</c:if>
</body>
</html>