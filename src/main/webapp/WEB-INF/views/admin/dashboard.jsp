<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 관리자 대시보드</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/admin.css">
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
                        <span class="dashboard-summary-title">
                            오늘 체크인
                        </span>

                        <strong class="dashboard-summary-value">
                            12건
                        </strong>

                        <span class="dashboard-summary-sub">
                            예정 고객
                        </span>
                    </div>

                    <div class="dashboard-icon">
                        ↘
                    </div>

                </article>


                <article class="dashboard-summary-card">

                    <div>
                        <span class="dashboard-summary-title">
                            오늘 체크아웃
                        </span>

                        <strong class="dashboard-summary-value">
                            8건
                        </strong>

                        <span class="dashboard-summary-sub">
                            예정 고객
                        </span>
                    </div>

                    <div class="dashboard-icon">
                        ↗
                    </div>

                </article>


                <article class="dashboard-summary-card">

                    <div>
                        <span class="dashboard-summary-title">
                            객실 가동률
                        </span>

                        <strong class="dashboard-summary-value">
                            78.4%
                        </strong>

                        <span class="dashboard-summary-sub">
                            현재 기준
                        </span>
                    </div>

                    <div class="dashboard-icon">
                        %
                    </div>

                </article>


                <article class="dashboard-summary-card">

                    <div>
                        <span class="dashboard-summary-title">
                            청소 필요 객실
                        </span>

                        <strong class="dashboard-summary-value">
                            7실
                        </strong>

                        <span class="dashboard-summary-sub">
                            정비 대기
                        </span>
                    </div>

                    <div class="dashboard-icon">
                        ⌁
                    </div>

                </article>

            </section>


            <!-- 객실 상태 -->
            <section class="dashboard-section">

                <div class="dashboard-section-header">

                    <div>
                        <h2>객실 상태 현황</h2>

                        <p>
                            전체 객실의 현재 운영 상태를 확인합니다.
                        </p>
                    </div>

                    <a href="/admin/rooms" class="dashboard-more-link">
                        전체 객실 보기
                    </a>

                </div>


                <div class="room-status-summary-grid">

                    <div class="room-summary-item room-summary-available">

                        <span>
                            이용 가능
                        </span>

                        <strong>
                            32
                        </strong>

                    </div>


                    <div class="room-summary-item room-summary-occupied">

                        <span>
                            투숙 중
                        </span>

                        <strong>
                            89
                        </strong>

                    </div>


                    <div class="room-summary-item room-summary-cleaning">

                        <span>
                            청소 중
                        </span>

                        <strong>
                            7
                        </strong>

                    </div>


                    <div class="room-summary-item room-summary-inspection">

                        <span>
                            점검 중
                        </span>

                        <strong>
                            2
                        </strong>

                    </div>

                </div>

            </section>


            <!-- 중단 -->
            <section class="dashboard-middle-grid">

                <!-- 당일 도착 예정 -->
                <div class="dashboard-panel">

                    <div class="dashboard-section-header">

                        <div>
                            <h2>
                                오늘 도착 예정 투숙객
                            </h2>

                            <p>
                                체크인 예정 고객의 예약정보입니다.
                            </p>
                        </div>

                        <a
                            href="/admin/checkin"
                            class="dashboard-more-link"
                        >
                            전체보기
                        </a>

                    </div>


                    <div class="dashboard-guest-list">

                        <div class="dashboard-guest-item">

                            <div class="guest-avatar">
                                김
                            </div>

                            <div class="guest-info">
                                <strong>
                                    김우현
                                </strong>

                                <span>
                                    디럭스 더블 · 405호
                                </span>
                            </div>

                            <div class="guest-time">
                                15:00
                            </div>

                        </div>


                        <div class="dashboard-guest-item">

                            <div class="guest-avatar">
                                박
                            </div>

                            <div class="guest-info">
                                <strong>
                                    박서연
                                </strong>

                                <span>
                                    프리미어 킹 · 배정 대기
                                </span>
                            </div>

                            <div class="guest-time">
                                15:30
                            </div>

                        </div>


                        <div class="dashboard-guest-item">

                            <div class="guest-avatar">
                                이
                            </div>

                            <div class="guest-info">
                                <strong>
                                    이준혁
                                </strong>

                                <span>
                                    디럭스 트윈 · 507호
                                </span>
                            </div>

                            <div class="guest-time">
                                16:00
                            </div>

                        </div>

                    </div>

                </div>


                <!-- 하우스키핑 -->
                <div class="dashboard-panel">

                    <div class="dashboard-section-header">

                        <div>
                            <h2>
                                하우스키핑 진행 현황
                            </h2>

                            <p>
                                금일 객실 정비 진행 상태입니다.
                            </p>
                        </div>

                        <a
                            href="/admin/housekeeping"
                            class="dashboard-more-link"
                        >
                            전체보기
                        </a>

                    </div>


                    <div class="housekeeping-progress-list">

                        <div class="housekeeping-progress-item">

                            <div class="progress-title-row">
                                <span>청소 대기</span>
                                <strong>5실</strong>
                            </div>

                            <div class="progress-bar">
                                <div
                                    class="progress-value"
                                    style="width: 25%;"
                                ></div>
                            </div>

                        </div>


                        <div class="housekeeping-progress-item">

                            <div class="progress-title-row">
                                <span>청소 중</span>
                                <strong>7실</strong>
                            </div>

                            <div class="progress-bar">
                                <div
                                    class="progress-value"
                                    style="width: 45%;"
                                ></div>
                            </div>

                        </div>


                        <div class="housekeeping-progress-item">

                            <div class="progress-title-row">
                                <span>청소 완료</span>
                                <strong>18실</strong>
                            </div>

                            <div class="progress-bar">
                                <div
                                    class="progress-value"
                                    style="width: 75%;"
                                ></div>
                            </div>

                        </div>


                        <div class="housekeeping-progress-item">

                            <div class="progress-title-row">
                                <span>점검 완료</span>
                                <strong>12실</strong>
                            </div>

                            <div class="progress-bar">
                                <div
                                    class="progress-value"
                                    style="width: 90%;"
                                ></div>
                            </div>

                        </div>

                    </div>

                </div>

            </section>


            <!-- 최근 활동 -->
            <section class="dashboard-section">

                <div class="dashboard-section-header">

                    <div>
                        <h2>
                            최근 현장 활동 기록
                        </h2>

                        <p>
                            체크인·체크아웃 및 객실 정비 처리 내역입니다.
                        </p>
                    </div>

                </div>


                <div class="activity-list">

                    <div class="activity-item">

                        <span class="activity-time">
                            14:15
                        </span>

                        <span class="activity-category">
                            객실 정비
                        </span>

                        <strong>
                            502호 객실 정비 완료
                        </strong>

                        <span class="activity-user">
                            김민지
                        </span>

                    </div>


                    <div class="activity-item">

                        <span class="activity-time">
                            14:02
                        </span>

                        <span class="activity-category">
                            체크인
                        </span>

                        <strong>
                            405호 고객 체크인 완료
                        </strong>

                        <span class="activity-user">
                            박지훈
                        </span>

                    </div>


                    <div class="activity-item">

                        <span class="activity-time">
                            13:45
                        </span>

                        <span class="activity-category">
                            체크아웃
                        </span>

                        <strong>
                            305호 퇴실 처리
                        </strong>

                        <span class="activity-user">
                            이수민
                        </span>

                    </div>

                </div>

            </section>

        </section>

    </main>

</div>

</body>
</html>