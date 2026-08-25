<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 체크인/체크아웃</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/admin.css">
    <link rel="stylesheet" href="/css/checkin.css">
</head>

<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>

    <main class="admin-content">

        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>

        <section class="admin-main">

            <!-- 상태 요약 -->
            <section class="checkin-summary-grid">

                <div class="checkin-summary-card">

                    <span>
                        오늘 체크인 예정
                    </span>

                    <strong>
                        12건
                    </strong>

                </div>


                <div class="checkin-summary-card">

                    <span>
                        체크인 완료
                    </span>

                    <strong>
                        7건
                    </strong>

                </div>


                <div class="checkin-summary-card">

                    <span>
                        오늘 체크아웃 예정
                    </span>

                    <strong>
                        8건
                    </strong>

                </div>


                <div class="checkin-summary-card">

                    <span>
                        체크아웃 완료
                    </span>

                    <strong>
                        5건
                    </strong>

                </div>

            </section>


            <!-- 탭 -->
            <nav class="checkin-tabs">

                <button
                    type="button"
                    class="checkin-tab active"
                >
                    체크인 예정
                </button>

                <button
                    type="button"
                    class="checkin-tab"
                >
                    체크아웃 예정
                </button>

            </nav>


            <!-- 검색 -->
            <div class="filter-bar checkin-filter">

                <div class="search-box">

                    <input
                        type="text"
                        class="form-control"
                        placeholder="예약번호, 고객명 또는 객실번호 검색"
                    >

                </div>


                <input
                    type="date"
                    class="form-control checkin-date"
                >


                <button
                    type="button"
                    class="btn btn-dark"
                >
                    검색
                </button>

            </div>


            <!-- 체크인 대상 -->
            <section class="checkin-layout">

                <!-- 왼쪽 목록 -->
                <div class="checkin-list-panel">

                    <div class="checkin-panel-title">

                        <h2>
                            체크인 예정 고객
                        </h2>

                        <span>
                            총 12건
                        </span>

                    </div>


                    <div class="checkin-customer-list">

                        <button
                            type="button"
                            class="checkin-customer-item active"
                        >

                            <div>

                                <strong>
                                    김우현
                                </strong>

                                <span>
                                    RS-20260811-01
                                </span>

                            </div>

                            <div class="checkin-item-right">

                                <strong>
                                    15:00
                                </strong>

                                <span>
                                    디럭스 더블
                                </span>

                            </div>

                        </button>


                        <button
                            type="button"
                            class="checkin-customer-item"
                        >

                            <div>

                                <strong>
                                    박서연
                                </strong>

                                <span>
                                    RS-20260811-02
                                </span>

                            </div>

                            <div class="checkin-item-right">

                                <strong>
                                    15:30
                                </strong>

                                <span>
                                    프리미어 킹
                                </span>

                            </div>

                        </button>


                        <button
                            type="button"
                            class="checkin-customer-item"
                        >

                            <div>

                                <strong>
                                    이준혁
                                </strong>

                                <span>
                                    RS-20260811-03
                                </span>

                            </div>

                            <div class="checkin-item-right">

                                <strong>
                                    16:00
                                </strong>

                                <span>
                                    디럭스 트윈
                                </span>

                            </div>

                        </button>

                    </div>

                </div>


                <!-- 오른쪽 상세 -->
                <div class="checkin-detail-panel">

                    <div class="checkin-detail-header">

                        <div>

                            <span class="badge badge-blue">
                                예약 확정
                            </span>

                            <h2>
                                김우현
                            </h2>

                            <p>
                                예약번호 RS-20260811-01
                            </p>

                        </div>

                    </div>


                    <div class="checkin-info-grid">

                        <div>

                            <span>
                                객실 타입
                            </span>

                            <strong>
                                디럭스 더블
                            </strong>

                        </div>


                        <div>

                            <span>
                                숙박 기간
                            </span>

                            <strong>
                                2026.08.11 ~ 2026.08.14
                            </strong>

                        </div>


                        <div>

                            <span>
                                투숙 인원
                            </span>

                            <strong>
                                성인 2명
                            </strong>

                        </div>


                        <div>

                            <span>
                                요청사항
                            </span>

                            <strong>
                                고층 객실 희망
                            </strong>

                        </div>

                    </div>


                    <!-- 객실 배정 -->
                    <div class="room-assignment-section">

                        <div class="checkin-section-title">

                            <h3>
                                객실 배정
                            </h3>

                            <p>
                                현재 이용 가능한 동일 타입 객실입니다.
                            </p>

                        </div>


                        <div class="available-room-list">

                            <label class="available-room-item selected">

                                <input
                                    type="radio"
                                    name="roomId"
                                    value="405"
                                    checked
                                >

                                <strong>
                                    405호
                                </strong>

                                <span>
                                    디럭스 더블
                                </span>

                                <small>
                                    정비 완료
                                </small>

                            </label>


                            <label class="available-room-item">

                                <input
                                    type="radio"
                                    name="roomId"
                                    value="407"
                                >

                                <strong>
                                    407호
                                </strong>

                                <span>
                                    디럭스 더블
                                </span>

                                <small>
                                    정비 완료
                                </small>

                            </label>


                            <label class="available-room-item">

                                <input
                                    type="radio"
                                    name="roomId"
                                    value="409"
                                >

                                <strong>
                                    409호
                                </strong>

                                <span>
                                    디럭스 더블
                                </span>

                                <small>
                                    정비 완료
                                </small>

                            </label>

                        </div>

                    </div>


                    <!-- 키 발급 -->
                    <div class="key-section">

                        <div class="checkin-section-title">

                            <h3>
                                객실 키 발급
                            </h3>

                        </div>


                        <div class="key-type-grid">

                            <label class="key-type-card active">

                                <input
                                    type="radio"
                                    name="keyType"
                                    value="CARD"
                                    checked
                                >

                                <strong>
                                    실물 카드키
                                </strong>

                                <span>
                                    프런트에서 카드키 발급
                                </span>

                            </label>


                            <label class="key-type-card">

                                <input
                                    type="radio"
                                    name="keyType"
                                    value="MOBILE"
                                >

                                <strong>
                                    모바일 키
                                </strong>

                                <span>
                                    모바일 키 발급 처리
                                </span>

                            </label>

                        </div>

                    </div>


                    <!-- 버튼 -->
                    <div class="checkin-action-row">

                        <button
                            type="button"
                            class="btn btn-outline"
                        >
                            예약 상세보기
                        </button>

                        <button
                            type="button"
                            class="btn btn-primary"
                        >
                            체크인 완료 처리
                        </button>

                    </div>

                </div>

            </section>

        </section>

    </main>

</div>

</body>
</html>