<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>The OneFive - 객실 현황</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/admin.css">
    <link rel="stylesheet" href="/css/room.css">
	<script src="/js/room.js"></script>
</head>
<body>
<div class="admin-layout">
    <!-- 관리자 사이드바 -->
    <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>
    <!-- 관리자 메인 영역 -->
    <main class="admin-content">
        <!-- 관리자 헤더 -->
        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>
        <section class="admin-main">
            <!-- 객실 상태 요약 -->
			<section class="room-status-overview">
			    <div class="room-overview-card">
			        <div class="room-overview-line available"></div>
			        <div class="room-overview-content">
			            <span class="room-overview-label">이용가능 (Clean)</span>
			            <strong>${availableCount} <small>객실</small></strong>
			        </div>
			        <span class="room-overview-rate">${availableRate}%</span>
			    </div>
			    <div class="room-overview-card">
			        <div class="room-overview-line occupied"></div>
			        <div class="room-overview-content">
			            <span class="room-overview-label">투숙중 (Occupied)</span>
			            <strong>${occupiedCount} <small>객실</small></strong>
			        </div>
			        <span class="room-overview-rate">${occupiedRate}%</span>
			    </div>
			    <div class="room-overview-card">
			        <div class="room-overview-line cleaning"></div>
			        <div class="room-overview-content">
			            <span class="room-overview-label">청소중 (Dirty)</span>
			            <strong>${cleaningCount} <small>객실</small></strong>
			        </div>
			        <span class="room-overview-rate">${cleaningRate}%</span>
			    </div>
			    <div class="room-overview-card">
			        <div class="room-overview-line inspection"></div>
			        <div class="room-overview-content">
			            <span class="room-overview-label">점검중 (Out of Order)</span>
			            <strong>${inspectionCount} <small>객실</small></strong>
			        </div>
			        <span class="room-overview-rate danger">${inspectionRate}%</span>
			    </div>
			</section>


			<div class="room-content-layout">
				<div class="room-left-area">
					<!-- 층 필터 -->
					<form action="/admin/room" method="get" class="filter-bar room-filter-bar">
					    <select name="floor" class="form-control room-filter-select">
					        <option value="0" ${selectedFloor == 0 ? 'selected' : ''}>
					            전체 층
					        </option>
					        <option value="2" ${selectedFloor == 2 ? 'selected' : ''}>
					            2층
					        </option>
					        <option value="3" ${selectedFloor == 3 ? 'selected' : ''}>
					            3층
					        </option>
					        <option value="4" ${selectedFloor == 4 ? 'selected' : ''}>
					            4층
					        </option>
					        <option value="5" ${selectedFloor == 5 ? 'selected' : ''}>
					            5층
					        </option>
					    </select>
					    <button type="submit" class="btn btn-dark">
					        조회
					    </button>
					</form>

					<!-- 조회 결과 없음 -->
					<c:if test="${empty roomList}">
					    <div class="card">
					        <div class="card-body">
					            조회된 객실이 없습니다.
					        </div>
					    </div>
					</c:if>
		            <!-- 객실 목록 -->
		            <c:if test="${not empty roomList}">
		                <!-- 5층 -->
		                <c:if test="${selectedFloor == 0 || selectedFloor == 5}">
		                    <section class="room-floor-section">
		                        <div class="room-floor-title">
		                            <div>
		                                <h2>5층</h2>
		                            </div>
		                        </div>
		                        <div class="admin-room-grid">
		                            <c:forEach var="room" items="${roomList}">
		                                <c:if test="${room.floor == 5}">
		                                    <c:set var="roomClass" value="room-available-card"/>
		                                    <c:if test="${room.status == '투숙중'}">
		                                        <c:set var="roomClass" value="room-occupied-card"/>
		                                    </c:if>
		                                    <c:if test="${room.status == '청소중'}">
		                                        <c:set var="roomClass" value="room-cleaning-card"/>
		                                    </c:if>
		                                    <c:if test="${room.status == '점검중'}">
		                                        <c:set var="roomClass" value="room-inspection-card"/>
		                                    </c:if>
		                                    <article class="admin-room-card ${roomClass}">
		                                        <div class="room-card-top">
		                                            <span class="room-number">
		                                                ${room.roomNum}
		                                            </span>
		                                            <span class="room-state">
		                                                ${room.status}
		                                            </span>
		                                        </div>
		                                        <strong class="room-type-name">
		                                            ${room.typeName}
		                                        </strong>
		                                        <span class="room-current-guest">
													<c:choose>
													    <c:when test="${room.status == '이용가능'}">공실</c:when>
													    <c:when test="${room.status == '투숙중'}">투숙객: ${room.guestName}</c:when>
													    <c:when test="${room.status == '청소중'}">청소중</c:when>
													    <c:when test="${room.status == '점검중'}">점검중</c:when>
													    <c:otherwise>상태 확인 필요</c:otherwise>
													</c:choose>
		                                        </span>
												<div class="room-card-actions">
													<a href="/admin/room/${room.id}" class="room-action-link room-detail-link" data-room-id="${room.id}">
													    세부 정보
													</a>
												</div>
		                                    </article>
		                                </c:if>
		                            </c:forEach>
		                        </div>
		                    </section>
		                </c:if>
						
		                <!-- 4층 -->
		                <c:if test="${selectedFloor == 0 || selectedFloor == 4}">
		                    <section class="room-floor-section">
		                        <div class="room-floor-title">
		                            <div>
		                                <h2>4층</h2>
		                            </div>
		                        </div>
		                        <div class="admin-room-grid">
		                            <c:forEach var="room" items="${roomList}">
		                                <c:if test="${room.floor == 4}">
		                                    <c:set var="roomClass" value="room-available-card"/>
		                                    <c:if test="${room.status == '투숙중'}">
		                                        <c:set var="roomClass" value="room-occupied-card"/>
		                                    </c:if>
		                                    <c:if test="${room.status == '청소중'}">
		                                        <c:set var="roomClass" value="room-cleaning-card"/>
		                                    </c:if>
		                                    <c:if test="${room.status == '점검중'}">
		                                        <c:set var="roomClass" value="room-inspection-card"/>
		                                    </c:if>
											
		                                    <article class="admin-room-card ${roomClass}">
		                                        <div class="room-card-top">
		                                            <span class="room-number">
		                                                ${room.roomNum}
		                                            </span>
		                                            <span class="room-state">
		                                                ${room.status}
		                                            </span>
		                                        </div>
		                                        <strong class="room-type-name">
		                                            ${room.typeName}
		                                        </strong>
		                                        <span class="room-current-guest">
													<c:choose>
													    <c:when test="${room.status == '이용가능'}">공실</c:when>
													    <c:when test="${room.status == '투숙중'}">투숙객: ${room.guestName}</c:when>
													    <c:when test="${room.status == '청소중'}">청소중</c:when>
													    <c:when test="${room.status == '점검중'}">점검중</c:when>
													    <c:otherwise>상태 확인 필요</c:otherwise>
													</c:choose>
		                                        </span>
												<div class="room-card-actions">
													<a href="/admin/room/${room.id}" class="room-action-link room-detail-link" data-room-id="${room.id}">
													    세부 정보
													</a>
												</div>
		                                    </article>
		                                </c:if>
		                            </c:forEach>
		                        </div>
		                    </section>
		                </c:if>
		
		                <!-- 3층 -->
		                <c:if test="${selectedFloor == 0 || selectedFloor == 3}">
		                    <section class="room-floor-section">
		                        <div class="room-floor-title">
		                            <div>
		                                <h2>3층</h2>
		                            </div>
		                        </div>
		                        <div class="admin-room-grid">
		                            <c:forEach var="room" items="${roomList}">
		                                <c:if test="${room.floor == 3}">
		                                    <c:set var="roomClass" value="room-available-card"/>
		                                    <c:if test="${room.status == '투숙중'}">
		                                        <c:set var="roomClass" value="room-occupied-card"/>
		                                    </c:if>
		                                    <c:if test="${room.status == '청소중'}">
		                                        <c:set var="roomClass" value="room-cleaning-card"/>
		                                    </c:if>
		                                    <c:if test="${room.status == '점검중'}">
		                                        <c:set var="roomClass" value="room-inspection-card"/>
		                                    </c:if>
		
		                                    <article class="admin-room-card ${roomClass}">
		                                        <div class="room-card-top">
		                                            <span class="room-number">
		                                                ${room.roomNum}
		                                            </span>
		                                            <span class="room-state">
		                                                ${room.status}
		                                            </span>
		                                        </div>
		                                        <strong class="room-type-name">
		                                            ${room.typeName}
		                                        </strong>
		                                        <span class="room-current-guest">
													<c:choose>
													    <c:when test="${room.status == '이용가능'}">공실</c:when>
													    <c:when test="${room.status == '투숙중'}">투숙객: ${room.guestName}</c:when>
													    <c:when test="${room.status == '청소중'}">청소중</c:when>
													    <c:when test="${room.status == '점검중'}">점검중</c:when>
													    <c:otherwise>상태 확인 필요</c:otherwise>
													</c:choose>
		                                        </span>
												<div class="room-card-actions">
													<a href="/admin/room/${room.id}" class="room-action-link room-detail-link" data-room-id="${room.id}">
													    세부 정보
													</a>
												</div>
		                                    </article>
		                                </c:if>
		                            </c:forEach>
		                        </div>
		                    </section>
		                </c:if>
		
		                <!-- 2층 -->
		                <c:if test="${selectedFloor == 0 || selectedFloor == 2}">
		                    <section class="room-floor-section">
		                        <div class="room-floor-title">
		                            <div>
		                                <h2>2층</h2>
		                            </div>
		                        </div>
		                        <div class="admin-room-grid">
		                            <c:forEach var="room" items="${roomList}">
		                                <c:if test="${room.floor == 2}">
		                                    <c:set var="roomClass" value="room-available-card"/>
		                                    <c:if test="${room.status == '투숙중'}">
		                                        <c:set var="roomClass" value="room-occupied-card"/>
		                                    </c:if>
		                                    <c:if test="${room.status == '청소중'}">
		                                        <c:set var="roomClass" value="room-cleaning-card"/>
		                                    </c:if>
		                                    <c:if test="${room.status == '점검중'}">
		                                        <c:set var="roomClass" value="room-inspection-card"/>
		                                    </c:if>
		                                    <article class="admin-room-card ${roomClass}">
		                                        <div class="room-card-top">
		                                            <span class="room-number">
		                                                ${room.roomNum}
		                                            </span>
		                                            <span class="room-state">
		                                                ${room.status}
		                                            </span>
		                                        </div>
		                                        <strong class="room-type-name">
		                                            ${room.typeName}
		                                        </strong>
		                                        <span class="room-current-guest">
													<c:choose>
													    <c:when test="${room.status == '이용가능'}">공실</c:when>
													    <c:when test="${room.status == '투숙중'}">투숙객: ${room.guestName}</c:when>
													    <c:when test="${room.status == '청소중'}">청소중</c:when>
													    <c:when test="${room.status == '점검중'}">점검중</c:when>
													    <c:otherwise>상태 확인 필요</c:otherwise>
													</c:choose>
		                                        </span>
		                                        <div class="room-card-actions">
													<a href="/admin/room/${room.id}" class="room-action-link room-detail-link" data-room-id="${room.id}">
													    세부 정보
													</a>
		                                        </div>
		                                    </article>
		                                </c:if>
		                            </c:forEach>
		                        </div>
		                    </section>
		                </c:if>
		            </c:if>
				</div>
				<aside id="roomDetailPanel" class="room-detail-panel">
				    <!-- 아무 객실도 선택하지 않았을 때 -->
				    <div id="roomDetailEmpty" class="room-detail-empty">
				        <div class="room-detail-empty-icon">▦</div>
				        <h3>객실 상세 정보</h3>
				        <p>
				            객실의 세부 정보를 확인하려면<br>
				            객실의 '세부 정보'를 선택하세요.
				        </p>
				    </div>
				    <!-- 객실 선택 후 표시 -->
				    <div id="roomDetailContent"
				         class="room-detail-content">
				        <div class="room-detail-header">
				            <div>
				                <span id="detailFloor" class="room-detail-floor"></span>
				                <h2 id="detailRoomNum">객실 정보</h2>
				                <p id="detailRoomType"></p>
				            </div>
				            <span id="detailStatus" class="room-detail-status"></span>
				        </div>

				        <div class="room-detail-info-grid">
				            <div class="room-detail-info-item">
				                <span>객실 번호</span>
				                <strong id="detailRoomNumber"></strong>
				            </div>
				            <div class="room-detail-info-item">
				                <span>객실 타입</span>
				                <strong id="detailTypeName"></strong>
				            </div>
				            <div class="room-detail-info-item">
				                <span>층</span>
				                <strong id="detailFloorInfo"></strong>
				            </div>
				            <div class="room-detail-info-item">
				                <span>현재 상태</span>
				                <strong id="detailStatusText"></strong>
				            </div>
				        </div>

				        <div class="room-detail-memo">
				            <span>객실 메모</span>
				            <p id="detailMemo">등록된 메모가 없습니다.</p>
				        </div>
				        <div class="room-detail-actions">
				            <button type="button" class="btn btn-primary">
				                객실 정비
				            </button>
				        </div>
				    </div>
				</aside>
			</div>
		</section> 
	</main>
</div> 
</body>
</html>