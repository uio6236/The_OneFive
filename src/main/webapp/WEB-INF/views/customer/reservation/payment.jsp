<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 예약 및 결제</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/customer.css">
    <link rel="stylesheet" href="/css/reservation.css">
</head>

<body>

<div class="customer-page">

    <jsp:include page="/WEB-INF/views/common/customerHeader.jsp"/>


    <main class="customer-main">

        <div class="reservation-page-title">

            <h1>
                예약 및 결제 진행
            </h1>

            <p>
                선택하신 객실 예약 정보를 확인하고
                안전하게 결제를 진행하세요.
            </p>

        </div>


        <div class="payment-layout">

            <!-- 왼쪽 : 예약 정보 -->
            <section class="payment-summary-card">

                <h2>
                    선택한 객실 정보
                </h2>


                <div class="selected-room">

                    <img
                        src="/images/room/deluxe-double.jpg"
                        alt="디럭스 더블 룸"
                    >


                    <div>

                        <span class="room-type-label">
                            디럭스 룸
                        </span>

                        <h3>
                            디럭스 더블 룸
                        </h3>

                        <p>
                            킹 사이즈 베드 1개 /
                            마운틴 뷰 /
                            대리석 욕실
                        </p>

                    </div>

                </div>


                <div class="payment-info-list">

                    <div>

                        <span>
                            체크인 날짜
                        </span>

                        <strong>
                            2026.08.15 (금) 15:00
                        </strong>

                    </div>


                    <div>

                        <span>
                            체크아웃 날짜
                        </span>

                        <strong>
                            2026.08.17 (일) 11:00
                        </strong>

                    </div>


                    <div>

                        <span>
                            총 투숙 기간
                        </span>

                        <strong class="highlight-text">
                            2박 3일
                        </strong>

                    </div>


                    <div>

                        <span>
                            이용 투숙객 인원
                        </span>

                        <strong>
                            성인 2명 / 유아 0명
                        </strong>

                    </div>

                </div>


                <div class="payment-price-area">

                    <div>

                        <span>
                            객실 요금
                            (1박 ₩180,000 × 2박)
                        </span>

                        <strong>
                            ₩360,000
                        </strong>

                    </div>


                    <div>

                        <span>
                            멤버십 특별 할인 (5%)
                        </span>

                        <strong class="discount-text">
                            -₩18,000
                        </strong>

                    </div>


                    <div class="payment-total">

                        <span>
                            최종 결제 금액
                        </span>

                        <strong>
                            ₩342,000
                        </strong>

                    </div>

                </div>

            </section>


            <!-- 오른쪽 : 결제 -->
            <section class="payment-form-card">

                <h2>
                    결제자 및 결제 정보 입력
                </h2>


                <form
                    action="/customer/reservation/complete"
                    method="post"
                >

                    <div class="payment-section-title">
                        1. 예약자 대표 정보
                    </div>


                    <div class="form-group">

                        <label
                            for="customerName"
                            class="form-label"
                        >
                            예약자 성함
                        </label>

                        <input
                            type="text"
                            id="customerName"
                            name="customerName"
                            value="홍길동"
                            class="form-control"
                            required
                        >

                    </div>


                    <div class="payment-contact-row">

                        <div class="form-group">

                            <label
                                for="phone"
                                class="form-label"
                            >
                                연락처
                            </label>

                            <input
                                type="tel"
                                id="phone"
                                name="phone"
                                value="010-1234-5678"
                                class="form-control"
                                required
                            >

                        </div>


                        <div class="form-group">

                            <label
                                for="email"
                                class="form-label"
                            >
                                이메일 주소
                            </label>

                            <input
                                type="email"
                                id="email"
                                name="email"
                                value="gildong@gmail.com"
                                class="form-control"
                                required
                            >

                        </div>

                    </div>


                    <hr class="form-divider">


                    <div class="payment-section-title">
                        2. 결제 수단 선택
                    </div>


                    <div class="payment-method-tabs">

                        <label class="payment-method active">

                            <input
                                type="radio"
                                name="paymentMethod"
                                value="CARD"
                                checked
                            >

                            신용 / 체크카드

                        </label>


                        <label class="payment-method">

                            <input
                                type="radio"
                                name="paymentMethod"
                                value="ACCOUNT"
                            >

                            실시간 계좌이체

                        </label>

                    </div>


                    <div class="form-group">

                        <label
                            for="cardNumber"
                            class="form-label"
                        >
                            카드 번호
                        </label>

                        <input
                            type="text"
                            id="cardNumber"
                            name="cardNumber"
                            class="form-control"
                            placeholder="0000 - 0000 - 0000 - 0000"
                        >

                    </div>


                    <div class="payment-contact-row">

                        <div class="form-group">

                            <label
                                for="expiry"
                                class="form-label"
                            >
                                유효 기간
                            </label>

                            <input
                                type="text"
                                id="expiry"
                                name="expiry"
                                class="form-control"
                                placeholder="MM / YY"
                            >

                        </div>


                        <div class="form-group">

                            <label
                                for="cvc"
                                class="form-label"
                            >
                                CVC 번호
                            </label>

                            <input
                                type="password"
                                id="cvc"
                                name="cvc"
                                class="form-control"
                                placeholder="카드 뒤 3자리 숫자"
                            >

                        </div>

                    </div>


                    <input
                        type="hidden"
                        name="roomTypeCode"
                        value="DELUXE_DOUBLE"
                    >


                    <button
                        type="submit"
                        class="btn btn-primary payment-submit"
                    >
                        안전 결제 및 예약 완료하기
                    </button>


                    <p class="payment-policy">
                        본 예약은 The OneFive 환불 규정에 따라
                        체크인 1일 전까지 무료 취소가 가능합니다.
                    </p>

                </form>

            </section>

        </div>

    </main>


    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</div>

</body>
</html>