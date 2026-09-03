<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

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
            <h1>예약 및 결제 진행</h1>
            <p>선택하신 객실 예약 정보를 확인하고 안전하게 결제를 진행하세요.</p>
        </div>

        <div class="payment-layout">

            <!-- 왼쪽 : 예약 정보 -->
            <section class="payment-summary-card">

                <h2>선택한 객실 정보</h2>

                <div class="selected-room">
                    <c:choose>
                        <c:when test="${not empty roomType.imageUrl}">
                            <img src="${roomType.imageUrl}" alt="${roomType.typeName}">
                        </c:when>
                        <c:otherwise>
                            <img src="/images/room/default.jpg" alt="${roomType.typeName}">
                        </c:otherwise>
                    </c:choose>
                    <div>
                        <span class="room-type-label">${roomType.typeName}</span>
                        <h3>${roomType.typeName}</h3>
                        <p>${roomType.description}</p>
                    </div>
                </div>

                <div class="payment-info-list">

                    <div>
                        <span>체크인 날짜</span>
                        <strong>${checkinDate}</strong>
                    </div>

                    <div>
                        <span>체크아웃 날짜</span>
                        <strong>${checkoutDate}</strong>
                    </div>

                    <div>
                        <span>총 투숙 기간</span>
                        <strong class="highlight-text">${nights}박</strong>
                    </div>

                    <div>
                        <span>이용 투숙객 인원</span>
                        <strong>성인 ${adultCount}명 / 유아 ${childCount}명</strong>
                    </div>

                </div>

                <div class="payment-price-area">

                    <div>
                        <span>객실 요금 (1박 <fmt:formatNumber value="${roomType.price}" pattern="#,###"/>원 × ${nights}박)</span>
                        <strong><fmt:formatNumber value="${roomAmount}" pattern="#,###"/>원</strong>
                    </div>

                    <c:if test="${isVip}">
                        <div>
                            <span>멤버십 특별 할인 (5%)</span>
                            <strong class="discount-text">-<fmt:formatNumber value="${discountAmount}" pattern="#,###"/>원</strong>
                        </div>
                    </c:if>

                    <div class="payment-total">
                        <span>최종 결제 금액</span>
                        <strong><fmt:formatNumber value="${totalAmount}" pattern="#,###"/>원</strong>
                    </div>

                </div>

				<div class="form-group">
				    <label for="request" class="form-label">요청 사항 (선택)</label>
				    <textarea id="request" name="request" form="paymentForm" class="form-control" rows="3"
				              placeholder="예: 수건 두 장 추가로 주세요, 높은 층 객실 부탁드립니다 등"></textarea>
				</div>
            </section>

            <!-- 오른쪽 : 결제 -->
            <section class="payment-form-card">

                <h2>결제자 및 결제 정보 입력</h2>

                <form id="paymentForm" action="${pageContext.request.contextPath}/customer/reservation/complete" method="post">

                    <div class="payment-section-title">1. 예약자 대표 정보</div>

                    <div class="form-group">
                        <label for="customerName" class="form-label">예약자 성함</label>
                        <input type="text" id="customerName" name="guestName" class="form-control" placeholder="홍길동" required>
                    </div>

                    <div class="payment-contact-row">

                        <div class="form-group">
                            <label for="phone" class="form-label">연락처</label>
                            <input type="tel" id="phone" name="guestPhone" class="form-control" placeholder="010-1234-5678" required>
                        </div>

                        <div class="form-group">
                            <label for="email" class="form-label">이메일 주소</label>
                            <input type="email" id="email" name="email" class="form-control" placeholder="example@gmail.com" required>
                        </div>

                    </div>


                    <hr class="form-divider">

                    <div class="payment-section-title">2. 결제 수단 선택</div>

					<div class="payment-method-tabs">

					    <label class="payment-method active" data-method="CARD">
					        <input type="radio" id="methodCard" name="paymentMethod" value="CARD" checked>
					        신용 / 체크카드
					    </label>

					    <label class="payment-method" data-method="ACCOUNT">
					        <input type="radio" id="methodAccount" name="paymentMethod" value="ACCOUNT">
					        실시간 계좌이체
					    </label>

					</div>

					<div id="cardFields">
					    <div class="form-group">
					        <label for="cardNumber" class="form-label">카드 번호</label>
					        <input type="text" id="cardNumber" name="cardNumber" class="form-control"
					               placeholder="0000 - 0000 - 0000 - 0000"
					               required pattern="\d{4} - \d{4} - \d{4} - \d{4}"
					               title="카드번호 16자리를 입력해 주세요.">
					    </div>

					    <div class="payment-contact-row">
					        <div class="form-group">
					            <label for="expiry" class="form-label">유효 기간</label>
					            <input type="text" id="expiry" name="expiry" class="form-control"
					                   placeholder="MM / YY"
					                   required pattern="(0[1-9]|1[0-2]) / \d{2}"
					                   title="MM / YY 형식으로 입력해 주세요.">
					        </div>
					        <div class="form-group">
					            <label for="cvc" class="form-label">CVC 번호</label>
					            <input type="password" id="cvc" name="cvc" class="form-control"
					                   placeholder="카드 뒤 3자리 숫자"
					                   required pattern="\d{3}"
					                   title="숫자 3자리를 입력해 주세요.">
					        </div>
					    </div>
					</div>

                    <div id="accountFields" style="display:none;">
                        <div class="form-group">
                            <label for="bankName" class="form-label">입금 은행</label>
                            <select id="bankName" name="bankName" class="form-control">
                                <option value="KB국민">KB국민은행</option>
                                <option value="신한">신한은행</option>
                                <option value="우리">우리은행</option>
                                <option value="하나">하나은행</option>
                            </select>
                        </div>
                        <p class="payment-policy">선택하신 은행으로 가상계좌가 발급되며, 입금 확인 후 예약이 확정됩니다. (시뮬레이션)</p>
                    </div>

                    <!-- ReservationDTO 필드명과 정확히 일치시킴 (checkinDate X, checkin O) -->
                    <input type="hidden" name="roomTypeId" value="${roomType.typeId}">
                    <input type="hidden" name="checkin" value="${checkinDate}">
                    <input type="hidden" name="checkout" value="${checkoutDate}">
                    <input type="hidden" name="guestCount" value="${adultCount + childCount}">
                    <input type="hidden" name="roomAmount" value="${roomAmount}">
                    <input type="hidden" name="discountAmount" value="${discountAmount}">
                    <input type="hidden" name="totalAmount" value="${totalAmount}">

                    <button type="submit" class="btn btn-primary payment-submit">안전 결제 및 예약 완료하기</button>

                    <p class="payment-policy">본 예약은 The OneFive 환불 규정에 따라 체크인 1일 전까지 무료 취소가 가능합니다.</p>

                </form>

            </section>

        </div>

    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</div>
	<script src="/js/reservation.js"></script>
</body>
</html>