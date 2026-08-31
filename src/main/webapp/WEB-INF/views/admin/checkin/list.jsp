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
	<script src="/js/checkin.js"></script>
</head>
<body>
<div class="admin-layout">
    <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>
    <main class="admin-content">
        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>
        <section class="admin-main">
            <!-- 탭 -->
            <nav class="checkin-tabs">
                <button type="button" class="checkin-tab active" id="checkinTab">
                    금일 체크인 예정 ${checkinList.size()}건
                </button>
                <button type="button" class="checkin-tab" id="checkoutTab">
                    금일 체크아웃 예정 ${checkoutList.size()}건
                </button>
            </nav>


            <!-- 체크인 대상 -->
            <section class="checkin-layout">
                <!-- 왼쪽 목록 -->
                <div class="checkin-left-area">
					<!-- 검색 -->
					<div class="filter-bar checkin-filter">
					    <div class="search-box">
					        <input type="text" id="checkinSearchInput" class="form-control" placeholder="고객명 또는 객실번호 검색">
					    </div>
					    <button type="button" id="checkinSearchBtn" class="btn btn-dark">
					        검색
					    </button>
					</div>
                    <div class="checkin-panel-title">
						<h2 id="listTitle">체크인 예정 고객</h2>
						<span id="listCount">총 ${checkinList.size()}건</span>
                    </div>
					<div id="checkinListArea">
					<div class="checkin-table-wrap">
						<table class="checkin-table">
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
								<c:forEach var="checkin" items="${checkinList}">
									<tr class="checkin-row" data-reservation-id="${checkin.reservationId}">
										<td>
											<c:choose>
												<c:when test="${not empty checkin.roomNum}">${checkin.roomNum}호</c:when>
												<c:otherwise>미배정</c:otherwise>
											</c:choose>
										</td>
										<td>${checkin.guestName}</td>
										<td>${checkin.reservationCode}</td>
										<td>${checkin.guestCount}명</td>
										<td>
											<c:choose>
												<c:when test="${not empty checkin.roomStatus}">
													<span class="room-state">${checkin.roomStatus}</span>
												</c:when>
												<c:otherwise>-</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
								<c:if test="${empty checkinList}">
									<tr>
										<td colspan="5" class="empty-row">오늘 체크인 예정 고객이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					</div>
					<div id="checkoutListArea" style="display: none;">
					<div class="checkin-table-wrap">
						<table class="checkin-table">
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
								<c:forEach var="checkout" items="${checkoutList}">
									<tr class="checkout-row"
										data-reservation-id="${checkout.reservationId}"
										data-checkin-id="${checkout.id}">
										<td>${checkout.roomNum}호</td>
										<td>${checkout.guestName}</td>
										<td>${checkout.reservationCode}</td>
										<td>${checkout.guestCount}명</td>
										<td>
											<span class="room-state">투숙중</span>
										</td>
									</tr>
								</c:forEach>

								<c:if test="${empty checkoutList}">
									<tr>
										<td colspan="5" class="empty-row">
											오늘 체크아웃 예정 고객이 없습니다.
										</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					</div>
                </div>

				<!-- 오른쪽 상세 -->
				<div class="checkin-detail-panel">
					<div class="checkin-detail-header">
						<div>
							<h2 id="detailGuestName">고객을 선택하세요</h2>
							<p id="detailReservationCode">예약번호</p>
						</div>
					</div>

					<div class="checkin-info-grid">
						<div>
							<span>객실 타입</span>
							<strong id="detailRoomType">-</strong>
						</div>
						<div>
							<span>숙박 기간</span>
							<strong id="detailStayPeriod">-</strong>
						</div>
						<div>
							<span>투숙 인원</span>
							<strong id="detailGuestCount">-</strong>
						</div>
						<div>
							<span>요청사항</span>
							<strong id="detailMemo">-</strong>
						</div>
					</div>

					<!-- 객실 배정 -->
					<div class="room-assignment-section" id="roomAssignmentSection">
						<div class="checkin-section-title">
							<h3>객실 배정</h3>
							<p>현재 이용 가능한 동일 타입 객실입니다.</p>
						</div>
						<div id="availableRoomList" class="available-room-list">
						</div>
					</div>

					<!-- 객실 키 발급 -->
					<div class="key-section" id="keySection">
						<div class="checkin-section-title">
							<h3>객실 키 발급</h3>
						</div>

						<div class="key-type-grid">
							<label class="key-type-card">
								<input type="radio" name="keyType" value="실물 키">
								<strong>실물 카드키</strong>
								<span>프런트에서 카드키 발급</span>
							</label>

							<label class="key-type-card">
								<input type="radio" name="keyType" value="모바일 키">
								<strong>모바일 키</strong>
								<span>모바일 키 발급 처리</span>
							</label>
						</div>
					</div>

					<div class="checkin-action-row">
						<button type="button" class="btn btn-primary" id="checkinBtn">체크인 완료 처리</button>
						<button type="button" class="btn btn-primary" id="checkoutBtn" style="display: none;">체크아웃 완료 처리</button>
					</div>
				</div>
            </section>
        </section>
    </main>
</div>
</body>
</html>