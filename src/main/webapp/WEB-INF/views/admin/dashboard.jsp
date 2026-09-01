<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 관리자 대시보드</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/admin.css">
    <link rel="stylesheet" href="/css/dashboard.css">
</head>

<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>

    <main class="admin-content">

        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>

        <section class="admin-main">

            <!-- 요약 카드 -->
            <section class="dashboard-summary-grid">

                <article class="dashboard-summary-card">
                    <div>
                        <span class="dashboard-summary-title">오늘 체크인</span>
                        <strong class="dashboard-summary-value">${dashboard.todayCheckinCount}건 예정</strong>
                    </div>
                    <div class="dashboard-icon">&#128100;</div>
                </article>

                <article class="dashboard-summary-card">
                    <div>
                        <span class="dashboard-summary-title">오늘 체크아웃</span>
                        <strong class="dashboard-summary-value">${dashboard.todayCheckoutCount}건 예정</strong>
                    </div>
                    <div class="dashboard-icon">&#8644;</div>
                </article>

                <article class="dashboard-summary-card">
                    <div>
                        <span class="dashboard-summary-title">객실 가동률</span>
                        <strong class="dashboard-summary-value">${dashboard.occupancyRate}%</strong>
                    </div>
                    <div class="dashboard-icon">&#9638;</div>
                </article>

                <article class="dashboard-summary-card">
                    <div>
                        <span class="dashboard-summary-title">오늘 매출</span>
                        <strong class="dashboard-summary-value">&#8361;<fmt:formatNumber value="${dashboard.todayRevenue}" pattern="#,##0"/></strong>
                    </div>
                    <div class="dashboard-icon">&#128200;</div>
                </article>

            </section>


            <!-- 객실 상태 -->
            <section class="dashboard-section">

                <div class="dashboard-section-header">
                    <h2>실시간 객실 현황 요약</h2>
                </div>

                <c:set var="roomTotal"
                       value="${dashboard.roomAvailable + dashboard.roomOccupied + dashboard.roomCleaning + dashboard.roomInspection}"/>

                <div class="room-status-summary-grid">

                    <div class="room-summary-item room-summary-available">
                        <span>이용가능 (Clean)</span>
                        <strong>${dashboard.roomAvailable}객실</strong>
                        <c:if test="${roomTotal > 0}">
                            <em><fmt:formatNumber value="${dashboard.roomAvailable * 100.0 / roomTotal}" pattern="#0"/>%</em>
                        </c:if>
                    </div>

                    <div class="room-summary-item room-summary-occupied">
                        <span>투숙중 (Occupied)</span>
                        <strong>${dashboard.roomOccupied}객실</strong>
                        <c:if test="${roomTotal > 0}">
                            <em><fmt:formatNumber value="${dashboard.roomOccupied * 100.0 / roomTotal}" pattern="#0"/>%</em>
                        </c:if>
                    </div>

                    <div class="room-summary-item room-summary-cleaning">
                        <span>청소중 (Dirty)</span>
                        <strong>${dashboard.roomCleaning}객실</strong>
                        <c:if test="${roomTotal > 0}">
                            <em><fmt:formatNumber value="${dashboard.roomCleaning * 100.0 / roomTotal}" pattern="#0"/>%</em>
                        </c:if>
                    </div>

                    <div class="room-summary-item room-summary-inspection">
                        <span>점검중 (Out of Order)</span>
                        <strong>${dashboard.roomInspection}객실</strong>
                        <c:if test="${roomTotal > 0}">
                            <em><fmt:formatNumber value="${dashboard.roomInspection * 100.0 / roomTotal}" pattern="#0"/>%</em>
                        </c:if>
                    </div>

                </div>

            </section>


            <!-- 중단 -->
            <section class="dashboard-middle-grid">

                <!-- 당일 도착 예정 -->
                <div class="dashboard-panel">

                    <div class="dashboard-section-header">
                        <h2>오늘 체크인 예정 투숙객</h2>
                        <a href="/admin/checkin" class="dashboard-more-link">신속 체크인 대기</a>
                    </div>

                    <table class="dashboard-arrival-table">
                        <thead>
                            <tr>
                                <th>객실</th>
                                <th>고객명</th>
                                <th>예약번호</th>
                                <th>인원</th>
                                <th>객실상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${dashboard.todayArrivals}" var="guest">
                                <tr>
                                    <td>
                                        <c:choose>
                                            <c:when test="${empty guest.roomNum}">배정 대기</c:when>
                                            <c:otherwise>${guest.roomNum}호</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${guest.guestName}</td>
                                    <td>${guest.reservationCode}</td>
                                    <td>${guest.guestCount}명</td>
                                    <td>
                                        <span class="badge-room-status">${guest.roomStatus}</span>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty dashboard.todayArrivals}">
                                <tr>
                                    <td colspan="5" class="inquiry-empty">오늘 도착 예정인 투숙객이 없습니다.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>

                </div>


                <!-- 하우스키핑 -->
                <div class="dashboard-panel">

                    <div class="dashboard-section-header">
                        <h2>하우스키핑 현황</h2>
                        <c:set var="hkTotal"
                               value="${dashboard.hkWaiting + dashboard.hkInProgress + dashboard.hkInspected}"/>
                        <a href="/admin/housekeeping" class="dashboard-more-link">전체 ${hkTotal}개 정비 대상</a>
                    </div>

                    <div class="housekeeping-overall">
                        <div class="progress-title-row">
                            <span>실시간 정비 완료율</span>
                            <strong>
                                <c:choose>
                                    <c:when test="${hkTotal > 0}">
                                        <fmt:formatNumber value="${dashboard.hkInspected * 100.0 / hkTotal}" pattern="#0"/>% 완료
                                    </c:when>
                                    <c:otherwise>0% 완료</c:otherwise>
                                </c:choose>
                            </strong>
                        </div>
                        <div class="progress-bar">
                            <div class="progress-value"
                                 style="width: ${hkTotal > 0 ? (dashboard.hkInspected * 100 / hkTotal) : 0}%;"></div>
                        </div>
                    </div>

                    <div class="housekeeping-status-list">

                        <div class="housekeeping-status-row">
                            <span>점검 완료 (인수 가능)</span>
                            <strong>${dashboard.hkInspected}개 객실</strong>
                        </div>

                        <div class="housekeeping-status-row">
                            <span>청소 중</span>
                            <strong>${dashboard.hkInProgress}개 객실</strong>
                        </div>

                        <div class="housekeeping-status-row housekeeping-status-warning">
                            <span>청소 대기 (미정비)</span>
                            <strong>${dashboard.hkWaiting}개 객실</strong>
                        </div>

                    </div>

                </div>

            </section>

        </section>

    </main>

</div>

</body>
</html>
