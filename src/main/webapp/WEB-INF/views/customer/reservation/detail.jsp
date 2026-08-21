<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 객실 상세</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/customer.css">
    <link rel="stylesheet" href="/css/reservation.css">
</head>

<body>

<div class="customer-page">

    <jsp:include page="/WEB-INF/views/common/customerHeader.jsp"/>

    <main class="customer-main">

        <div class="reservation-page-title">
            <h1>객실 상세 및 예약</h1>
            <p>
                객실 정보를 확인하고 투숙 일정을 선택해 주세요.
            </p>
        </div>


        <section class="room-detail-layout">

            <!-- 객실 정보 -->
            <div class="room-detail-card">

                <div class="room-detail-image">

                    <img
                        src="/images/room/deluxe-double.jpg"
                        alt="디럭스 더블 룸"
                    >

                    <span class="room-available">
                        예약 가능
                    </span>

                </div>


                <div class="room-detail-content">

                    <span class="room-type-label">
                        디럭스 룸
                    </span>

                    <h2>
                        디럭스 더블 룸
                    </h2>

                    <p class="room-detail-description">
                        도심 속 정원 전망을 바라보며 편안한 휴식을
                        즐길 수 있는 객실입니다. 킹 사이즈 베드와
                        대리석 욕실을 갖추고 있습니다.
                    </p>


                    <div class="room-detail-info-grid">

                        <div>
                            <span>기준 인원</span>
                            <strong>성인 2명</strong>
                        </div>

                        <div>
                            <span>최대 인원</span>
                            <strong>성인 2명</strong>
                        </div>

                        <div>
                            <span>베드 타입</span>
                            <strong>킹 사이즈 베드 1개</strong>
                        </div>

                        <div>
                            <span>객실 요금</span>
                            <strong>₩180,000 / 1박</strong>
                        </div>

                    </div>


                    <div class="room-facilities">

                        <h3>객실 주요 시설</h3>

                        <div class="facility-list">

                            <span>무료 Wi-Fi</span>
                            <span>대리석 욕실</span>
                            <span>스마트 TV</span>
                            <span>냉장고</span>
                            <span>금고</span>
                            <span>에어컨</span>

                        </div>

                    </div>

                </div>

            </div>


            <!-- 예약 조건 -->
            <aside class="reservation-option-card">

                <h2>
                    예약 정보
                </h2>

                <p class="reservation-option-description">
                    체크인·체크아웃 날짜와 이용 인원을 선택해 주세요.
                </p>


                <form
                    action="/customer/reservation/payment"
                    method="get"
                >

                    <div class="form-group">

                        <label
                            for="checkinDate"
                            class="form-label"
                        >
                            체크인 날짜
                        </label>

                        <input
                            type="date"
                            id="checkinDate"
                            name="checkinDate"
                            class="form-control"
                            required
                        >

                    </div>


                    <div class="form-group">

                        <label
                            for="checkoutDate"
                            class="form-label"
                        >
                            체크아웃 날짜
                        </label>

                        <input
                            type="date"
                            id="checkoutDate"
                            name="checkoutDate"
                            class="form-control"
                            required
                        >

                    </div>


                    <div class="guest-count-row">

                        <div class="form-group">

                            <label
                                for="adultCount"
                                class="form-label"
                            >
                                성인
                            </label>

                            <select
                                id="adultCount"
                                name="adultCount"
                                class="form-control"
                            >
                                <option value="1">1명</option>
                                <option value="2" selected>2명</option>
                            </select>

                        </div>


                        <div class="form-group">

                            <label
                                for="childCount"
                                class="form-label"
                            >
                                유아
                            </label>

                            <select
                                id="childCount"
                                name="childCount"
                                class="form-control"
                            >
                                <option value="0">0명</option>
                                <option value="1">1명</option>
                            </select>

                        </div>

                    </div>


                    <div class="reservation-price-summary">

                        <div>
                            <span>
                                객실 요금
                            </span>

                            <strong>
                                ₩180,000
                            </strong>
                        </div>


                        <div>
                            <span>
                                예상 숙박 기간
                            </span>

                            <strong>
                                1박
                            </strong>
                        </div>


                        <div class="reservation-total">

                            <span>
                                예상 결제 금액
                            </span>

                            <strong>
                                ₩180,000
                            </strong>

                        </div>

                    </div>


                    <input
                        type="hidden"
                        name="roomTypeCode"
                        value="DELUXE_DOUBLE"
                    >


                    <button
                        type="submit"
                        class="btn btn-primary reservation-submit"
                    >
                        예약 및 결제로 이동
                    </button>

                </form>

            </aside>

        </section>

    </main>


    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</div>

</body>
</html>