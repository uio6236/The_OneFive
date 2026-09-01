<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>The OneFive - 객실 예약</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/customer.css">
</head>
<body>
<div class="customer-page">
    <!-- 고객 Header -->
    <jsp:include page="/WEB-INF/views/common/customerHeader.jsp"/>
    <main class="customer-main">
        <!-- 프로모션 -->
        <section class="promotion-banner">
            <div class="promotion-overlay">
                <span class="promotion-label">
                    PROMOTION OF THE MONTH
                </span>
                <h2>
                    The OneFive 특별 멤버십 오픈 기념
                    15% 할인 혜택
                </h2>
                <p>
                    공식 홈페이지에서 예약 시 모든 디럭스 및
                    스위트 룸 객실에 한하여 조식 2인 무료 패키지가
                    기본 제공됩니다.
                </p>
            </div>
        </section>

        <!-- 객실 제목 -->
        <section class="room-section">
            <div class="section-title-area">
                <h2>예약 가능한 객실</h2>
                <p>
                    금일 입실 가능하도록 전문 청소 및 위생 관리가
                    완료된 최고의 객실 리스트를 확인하세요.
                </p>
            </div>

            <!-- 객실 목록 -->
            <div class="customer-room-grid">
                <!-- 디럭스 더블 -->
                <article class="customer-room-card">
                    <div class="room-image-wrapper">
                        <img src="/images/room/deluxe-double.jpg" alt="디럭스 더블 룸">
                        <span class="room-available">
                            예약 가능
                        </span>
                    </div>

                    <div class="room-card-content">
                        <h3>디럭스 더블 룸</h3>
                        <p class="room-description">
                            도심 속 정원 전망을 바라보며
                            시몬스 프리미엄 뷰티레스트 매트리스에서
                            품격 있는 휴식을 경험할 수 있습니다.
                        </p>
                        <div class="room-meta">
                            <span>
                                ♙ 기준 2인 / 최대 2인
                            </span>
                            <span>
                                ⌁ 무료 초고속 Wi-Fi
                            </span>
                        </div>
                        <div class="room-card-bottom">
                            <div>
                                <span class="price-label">
                                    1박 요금
                                </span>
                                <strong>
                                    ₩180,000
                                </strong>
                            </div>
                            <a href="/customer/reservation/detail?roomType=DELUXE_DOUBLE"
                                class="btn btn-primary">
                                상세보기 및 예약
                            </a>
                        </div>
                    </div>
                </article>

                <!-- 디럭스 트윈 -->
                <article class="customer-room-card">
                    <div class="room-image-wrapper">
                        <img src="/images/room/deluxe-twin.jpg" alt="디럭스 트윈 룸">
                        <span class="room-available">
                            예약 가능
                        </span>
                    </div>

                    <div class="room-card-content">
                        <h3>디럭스 트윈 룸</h3>
                        <p class="room-description">
                            가족 및 비즈니스 출장 고객에게
                            최적화된 넓은 트윈 룸으로
                            편안한 휴식을 제공합니다.
                        </p>
                        <div class="room-meta">
                            <span>
                                ♙ 기준 2인 / 최대 3인
                            </span>
                            <span>
                                ⌁ 무료 초고속 Wi-Fi
                            </span>
                        </div>
                        <div class="room-card-bottom">
                            <div>
                                <span class="price-label">
                                    1박 요금
                                </span>
                                <strong>
                                    ₩195,000
                                </strong>
                            </div>
                            <a href="/customer/reservation/detail?roomType=DELUXE_TWIN"
                                class="btn btn-primary">
                                상세보기 및 예약
                            </a>
                        </div>
                    </div>
                </article>


                <!-- 프리미어 킹 -->
                <article class="customer-room-card">
                    <div class="room-image-wrapper">
                        <img src="/images/room/premium-king.jpg" alt="프리미어 킹 룸">
                        <span class="room-available">
                            예약 가능
                        </span>
                    </div>
                    <div class="room-card-content">
                        <h3>프리미어 킹 룸</h3>
                        <p class="room-description">
                            고급스러운 컬러 라인과
                            이탈리아 대리석 욕조가 조화를 이루는
                            프리미엄 객실입니다.
                        </p>
                        <div class="room-meta">
                            <span>
                                ♙ 기준 2인 / 최대 2인
                            </span>
                            <span>
                                ⌁ 무료 초고속 Wi-Fi
                            </span>
                        </div>
                        <div class="room-card-bottom">
                            <div>
                                <span class="price-label">
                                    1박 요금
                                </span>
                                <strong>
                                    ₩260,000
                                </strong>
                            </div>
                            <a href="/customer/reservation/detail?roomType=PREMIUM_KING"
                                class="btn btn-primary">
                                상세보기 및 예약
                            </a>
                        </div>
                    </div>
                </article>

                <!-- 패밀리 -->
                <article class="customer-room-card">
                    <div class="room-image-wrapper">
                        <img src="/images/room/family-suite.jpg" alt="슈페리어 패밀리 룸">
                        <span class="room-available">
                            예약 가능
                        </span>
                    </div>
                    <div class="room-card-content">
                        <h3>슈페리어 패밀리 룸</h3>
                        <p class="room-description">
                            어린이 동반 가족 고객을 위한
                            패밀리 객실로 가족 여행에 적합합니다.
                        </p>
                        <div class="room-meta">
                            <span>
                                ♙ 기준 3인 / 최대 4인
                            </span>
                            <span>
                                ⌁ 무료 초고속 Wi-Fi
                            </span>
                        </div>
                        <div class="room-card-bottom">
                            <div>
                                <span class="price-label">
                                    1박 요금
                                </span>
                                <strong>
                                    ₩220,000
                                </strong>
                            </div>
                            <a href="/customer/reservation/detail?roomType=FAMILY"
                                class="btn btn-primary">
                                상세보기 및 예약
                            </a>
                        </div>
                    </div>
                </article>

                <!-- 주니어 스위트 -->
                <article class="customer-room-card">
                    <div class="room-image-wrapper">
                        <img src="/images/room/grand-junior-suite.jpg"
                            alt="그랜드 주니어 스위트">
                        <span class="room-available">
                            예약 가능
                        </span>
                    </div>
                    <div class="room-card-content">
                        <h3>그랜드 주니어 스위트</h3>
                        <p class="room-description">
                            파노라마 오션뷰와 독립된 다이닝 공간으로
                            높은 수준의 휴식을 제공합니다.
                        </p>
                        <div class="room-meta">
                            <span>
                                ♙ 기준 2인 / 최대 4인
                            </span>
                            <span>
                                ⌁ 무료 초고속 Wi-Fi
                            </span>
                        </div>
                        <div class="room-card-bottom">
                            <div>
                                <span class="price-label">
                                    1박 요금
                                </span>
                                <strong>
                                    ₩380,000
                                </strong>
                            </div>
                            <a href="/customer/reservation/detail?roomType=JUNIOR_SUITE"
                                class="btn btn-primary">
                                상세보기 및 예약
                            </a>
                        </div>
                    </div>
                </article>

                <!-- 이그제큐티브 -->
                <article class="customer-room-card sold-out">
                    <div class="room-image-wrapper">
                        <img src="/images/room/executive-suite.jpg"
                            alt="이그제큐티브 스위트">
                        <span class="room-unavailable">
                            예약 마감
                        </span>
                    </div>
                    <div class="room-card-content">
                        <h3>이그제큐티브 스위트</h3>
                        <p class="room-description">
                            전용 라운지와 전문 버틀러 서비스를
                            이용할 수 있는 최고급 객실입니다.
                        </p>
                        <div class="room-meta">
                            <span>
                                ♙ 기준 2인 / 최대 2인
                            </span>
                            <span>
                                ⌁ 무료 초고속 Wi-Fi
                            </span>
                        </div>
                        <div class="room-card-bottom">
                            <div>
                                <span class="price-label">
                                    1박 요금
                                </span>
                                <strong>
                                    ₩540,000
                                </strong>
                            </div>
                            <button
                                type="button"
                                class="btn room-disabled-btn"
                                disabled>
                                상세보기 및 예약
                            </button>
                        </div>
                    </div>
                </article>

            </div>
            <!-- pagination -->
            <div class="room-pagination-area">
                <span>
                    전체 24개 중 1-8 표시
                </span>
                <div class="pagination">
                    <a href="#">‹</a>
                    <a href="#" class="active">
                        1
                    </a>
                    <a href="#">
                        2
                    </a>
                    <a href="#">
                        3
                    </a>
                    <a href="#">
                        ›
                    </a>
                </div>
            </div>
        </section>
    </main>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>