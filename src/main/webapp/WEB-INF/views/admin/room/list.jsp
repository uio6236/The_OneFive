<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 객실 현황</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/admin.css">
    <link rel="stylesheet" href="/css/room.css">
</head>

<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>

    <main class="admin-content">

        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>

        <section class="admin-main">

            <!-- 상태 요약 -->
            <section class="room-status-overview">

                <div class="room-overview-card">

                    <span>
                        전체 객실
                    </span>

                    <strong>
                        130
                    </strong>

                </div>


                <div class="room-overview-card">

                    <span>
                        이용 가능
                    </span>

                    <strong>
                        32
                    </strong>

                </div>


                <div class="room-overview-card">

                    <span>
                        투숙 중
                    </span>

                    <strong>
                        89
                    </strong>

                </div>


                <div class="room-overview-card">

                    <span>
                        청소 중
                    </span>

                    <strong>
                        7
                    </strong>

                </div>


                <div class="room-overview-card danger">

                    <span>
                        점검 중
                    </span>

                    <strong>
                        2
                    </strong>

                </div>

            </section>


            <!-- 검색 -->
            <div class="filter-bar room-filter-bar">

                <select class="form-control room-filter-select">

                    <option>
                        전체 층
                    </option>

                    <option>
                        3층
                    </option>

                    <option>
                        4층
                    </option>

                    <option>
                        5층
                    </option>

                </select>


                <select class="form-control room-filter-select">

                    <option>
                        전체 상태
                    </option>

                    <option>
                        이용 가능
                    </option>

                    <option>
                        투숙 중
                    </option>

                    <option>
                        청소 중
                    </option>

                    <option>
                        점검 중
                    </option>

                </select>


                <div class="search-box">

                    <input
                        type="text"
                        class="form-control"
                        placeholder="객실 번호 검색"
                    >

                </div>


                <button class="btn btn-dark">
                    조회
                </button>

            </div>


            <!-- 층 -->
            <section class="room-floor-section">

                <div class="room-floor-title">

                    <div>
                        <h2>
                            5층
                        </h2>

                        <span>
                            총 10개 객실
                        </span>
                    </div>

                </div>


                <div class="admin-room-grid">

                    <article class="admin-room-card room-available-card">

                        <div class="room-card-top">

                            <span class="room-number">
                                501
                            </span>

                            <span class="room-state">
                                이용 가능
                            </span>

                        </div>


                        <strong class="room-type-name">
                            디럭스 더블
                        </strong>


                        <span class="room-current-guest">
                            현재 투숙객 없음
                        </span>


                        <div class="room-card-actions">

                            <a
                                href="/admin/rooms/501"
                                class="room-action-link"
                            >
                                세부 정보
                            </a>

                        </div>

                    </article>


                    <article class="admin-room-card room-occupied-card">

                        <div class="room-card-top">

                            <span class="room-number">
                                502
                            </span>

                            <span class="room-state">
                                투숙 중
                            </span>

                        </div>


                        <strong class="room-type-name">
                            디럭스 트윈
                        </strong>


                        <span class="room-current-guest">
                            이준혁
                        </span>


                        <div class="room-card-actions">

                            <a
                                href="/admin/rooms/502"
                                class="room-action-link"
                            >
                                세부 정보
                            </a>

                        </div>

                    </article>


                    <article class="admin-room-card room-cleaning-card">

                        <div class="room-card-top">

                            <span class="room-number">
                                503
                            </span>

                            <span class="room-state">
                                청소 중
                            </span>

                        </div>


                        <strong class="room-type-name">
                            프리미어 킹
                        </strong>


                        <span class="room-current-guest">
                            담당자 김민지
                        </span>


                        <div class="room-card-actions">

                            <a
                                href="/admin/rooms/503"
                                class="room-action-link"
                            >
                                세부 정보
                            </a>

                        </div>

                    </article>


                    <article class="admin-room-card room-inspection-card">

                        <div class="room-card-top">

                            <span class="room-number">
                                504
                            </span>

                            <span class="room-state">
                                점검 중
                            </span>

                        </div>


                        <strong class="room-type-name">
                            디럭스 더블
                        </strong>


                        <span class="room-current-guest">
                            시설 점검
                        </span>


                        <div class="room-card-actions">

                            <a
                                href="/admin/rooms/504"
                                class="room-action-link danger"
                            >
                                세부 정보
                            </a>

                        </div>

                    </article>


                    <article class="admin-room-card room-available-card">

                        <div class="room-card-top">

                            <span class="room-number">
                                505
                            </span>

                            <span class="room-state">
                                이용 가능
                            </span>

                        </div>


                        <strong class="room-type-name">
                            디럭스 더블
                        </strong>


                        <span class="room-current-guest">
                            현재 투숙객 없음
                        </span>


                        <div class="room-card-actions">

                            <a
                                href="/admin/rooms/505"
                                class="room-action-link"
                            >
                                세부 정보
                            </a>

                        </div>

                    </article>

                </div>

            </section>


            <!-- 4층 -->
            <section class="room-floor-section">

                <div class="room-floor-title">

                    <div>
                        <h2>
                            4층
                        </h2>

                        <span>
                            총 10개 객실
                        </span>
                    </div>

                </div>


                <div class="admin-room-grid">

                    <article class="admin-room-card room-occupied-card">

                        <div class="room-card-top">

                            <span class="room-number">
                                401
                            </span>

                            <span class="room-state">
                                투숙 중
                            </span>

                        </div>

                        <strong class="room-type-name">
                            디럭스 트윈
                        </strong>

                        <span class="room-current-guest">
                            박서연
                        </span>

                        <div class="room-card-actions">

                            <a
                                href="/admin/rooms/401"
                                class="room-action-link"
                            >
                                세부 정보
                            </a>

                        </div>

                    </article>


                    <article class="admin-room-card room-available-card">

                        <div class="room-card-top">

                            <span class="room-number">
                                402
                            </span>

                            <span class="room-state">
                                이용 가능
                            </span>

                        </div>

                        <strong class="room-type-name">
                            디럭스 더블
                        </strong>

                        <span class="room-current-guest">
                            현재 투숙객 없음
                        </span>

                        <div class="room-card-actions">

                            <a
                                href="/admin/rooms/402"
                                class="room-action-link"
                            >
                                세부 정보
                            </a>

                        </div>

                    </article>


                    <article class="admin-room-card room-occupied-card">

                        <div class="room-card-top">

                            <span class="room-number">
                                405
                            </span>

                            <span class="room-state">
                                투숙 중
                            </span>

                        </div>

                        <strong class="room-type-name">
                            디럭스 더블
                        </strong>

                        <span class="room-current-guest">
                            김우현
                        </span>

                        <div class="room-card-actions">

                            <a
                                href="/admin/rooms/405"
                                class="room-action-link"
                            >
                                세부 정보
                            </a>

                        </div>

                    </article>

                </div>

            </section>

        </section>

    </main>

</div>

</body>
</html>