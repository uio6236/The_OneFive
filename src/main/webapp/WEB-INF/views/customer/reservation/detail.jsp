<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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

			        <c:choose>
			            <c:when test="${not empty roomType.imageUrl}">
			                <img src="${roomType.imageUrl}" alt="${roomType.typeName}">
			            </c:when>
			            <c:otherwise>
			                <img src="/images/room/default.jpg" alt="${roomType.typeName}">
			            </c:otherwise>
			        </c:choose>

			        <span id="availabilityBadge" class="room-available">예약 가능</span>

			    </div>


			    <div class="room-detail-content">

			        <span class="room-type-label">${roomType.typeName}</span>

			        <h2>${roomType.typeName}</h2>

			        <p class="room-detail-description">
			                ${roomType.description}
			        </p>


			        <div class="room-detail-info-grid">

			            <div>
			                <span>기준 인원</span>
			                <strong>성인 ${roomType.capacity}명</strong>
			            </div>

			            <div>
			                <span>최대 인원</span>
			                <strong>성인 ${roomType.maxCapacity}명</strong>
			            </div>

			            <div>
			                <span>베드 타입</span>
							<strong>
								<c:choose>
									<c:when test="${roomType.typeName == '스탠다드'}">더블 베드 1개</c:when>
									<c:when test="${roomType.typeName == '디럭스 더블'}">킹 사이즈 베드 1개</c:when>
									<c:when test="${roomType.typeName == '디럭스 트윈'}">싱글 베드 2개</c:when>
									<c:when test="${roomType.typeName == '슈페리어 패밀리'}">더블 베드 1개 + 싱글 베드 2개</c:when>
									<c:when test="${roomType.typeName == '주니어 스위트'}">킹 사이즈 베드 1개</c:when>
									<c:when test="${roomType.typeName == '이그제큐티브 스위트'}">킹 사이즈 베드 1개</c:when>
									<c:otherwise>-</c:otherwise>
								</c:choose>
							</strong>
			            </div>

						<div>
						    <span>객실 요금</span>
						    <strong><fmt:formatNumber value="${roomType.price}" pattern="#,###"/>원 / 1박</strong>
						</div>
						
			        </div>


			        <div class="room-facilities">
			            <h3>객실 주요 시설</h3>
			            <div class="facility-list">
			                <span>무료 Wi-Fi</span>
			                <span>스마트 TV</span>
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


				<form id="reservationForm" action="${pageContext.request.contextPath}/customer/reservation/payment" method="get">

				    <div class="form-group">
				        <label for="checkinDate" class="form-label">체크인 날짜</label>
						<input type="date" id="checkinDate" name="checkinDate" class="form-control"
						       value="${checkinDate}" required>
				    </div>

				    <div class="form-group">
				        <label for="checkoutDate" class="form-label">체크아웃 날짜</label>
						<input type="date" id="checkoutDate" name="checkoutDate" class="form-control"
						       value="${checkoutDate}" required>
				    </div>

				    <div class="guest-count-row">

				        <div class="form-group">
				            <label for="adultCount" class="form-label">성인</label>
				            <select id="adultCount" name="adultCount" class="form-control">
				                <c:forEach begin="1" end="${roomType.maxCapacity}" var="n">
				                    <option value="${n}" ${n == guestCount ? 'selected' : ''}>${n}명</option>
				                </c:forEach>
				            </select>
				        </div>

				        <div class="form-group">
				            <label for="childCount" class="form-label">유아</label>
				            <select id="childCount" name="childCount" class="form-control">
				                <option value="0" selected>0명</option>
				                <option value="1">1명</option>
				                <option value="2">2명</option>
				            </select>
				        </div>

				    </div>

				    <div class="reservation-price-summary">
				        <div>
				            <span>객실 요금</span>
				            <strong id="baseAmountText">₩0</strong>
				        </div>
				        <div>
				            <span>예상 숙박 기간</span>
				            <strong id="nightsText">0박</strong>
				        </div>
				        <div>
				            <span>추가 인원 요금</span>
				            <strong id="extraAmountText">₩0</strong>
				        </div>
				        <div class="reservation-total">
				            <span>예상 결제 금액</span>
				            <strong id="totalAmountText">₩0</strong>
				        </div>
				    </div>

					<input type="hidden" name="roomTypeId" value="${roomType.typeId}">
					<input type="hidden" id="basePrice" value="${roomType.price}">
					<input type="hidden" id="baseCapacity" value="${roomType.capacity}">
					<input type="hidden" id="maxCapacity" value="${roomType.maxCapacity}">

				    <button type="submit" id="submitBtn" class="btn btn-primary reservation-submit">예약 및 결제로 이동</button>

				</form>

            </aside>

        </section>

    </main>


    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</div>
<script src="/js/reservation.js"></script>
</body>
</html>