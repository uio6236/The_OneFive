<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>


<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 예약 관리</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/admin.css">
    <link rel="stylesheet" href="/css/reservation.css">
</head>

<body data-context-path="${pageContext.request.contextPath}">

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>

    <main class="admin-content">

        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>

        <section class="admin-main">




			<form method="get" action="${pageContext.request.contextPath}/admin/reservations">

			    <div class="filter-bar reservation-filter">

			        <div class="search-box">
			            <input type="text" name="keyword" class="form-control"
			                   placeholder="예약번호 또는 예약자명을 검색하세요" value="${condition.keyword}">
			        </div>


			        <input type="date" name="checkinDate" class="form-control reservation-date"
			               value="${condition.checkinDate}">
						   
					<select name="status" class="form-control reservation-filter-select">
						<option value="" ${empty condition.status ? 'selected' : ''}>전체 상태</option>
						<option value="예약확정" ${condition.status == '예약확정' ? 'selected' : ''}>예약 확정</option>
						<option value="예약취소" ${condition.status == '예약취소' ? 'selected' : ''}>예약 취소</option>
						<option value="이용완료" ${condition.status == '이용완료' ? 'selected' : ''}>이용 완료</option>
					</select>						   
						   

			        <button type="submit" class="btn btn-dark">검색</button>

			    </div>

			</form>


            <!-- 예약 목록 + 우측 상세패널 -->
            <div class="reservation-main-layout">

            <!-- 예약 테이블 -->
            <div class="table-wrapper reservation-table-wrapper">

                <table class="common-table">

                    <thead>

                    <tr>
                        <th>예약번호</th>
                        <th>고객명</th>
						<th>예약자명</th>
						<th>전화번호(예약자)</th>
                        <th>객실 타입</th>
                        <th>체크인</th>
                        <th>체크아웃</th>
                        <th>인원</th>
                        <th>상태</th>
                        <th>총 예약금액</th>
                        <th></th>
                    </tr>

                    </thead>


                    <tbody>

                    <c:forEach var="r" items="${reservationList}">

                        <tr class="reservation-row ${r.status == '예약취소' ? 'cancelled-row' : ''}">

                            <td>
                                    ${r.code}
                            </td>

                            <td>
                                    ${r.guestName}
                            </td>
							<td>${empty r.bookerName ? '-' : r.bookerName}</td>
							<td>${empty r.bookerPhone ? '-' : r.bookerPhone}</td>

                            <td>
                                    ${r.typeName}
                            </td>

                            <td>
                                <fmt:formatDate value="${r.checkin}" pattern="yyyy.MM.dd"/>
                            </td>

                            <td>
                                <fmt:formatDate value="${r.checkout}" pattern="yyyy.MM.dd"/>
                            </td>

                            <td>
                                    ${r.guestCount}명
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${r.status == '예약확정'}">
                                        <span class="badge badge-blue">예약 확정</span>
                                    </c:when>
                                    <c:when test="${r.status == '예약취소'}">
                                        <span class="badge badge-danger">예약 취소</span>
                                    </c:when>
                                    <c:when test="${r.status == '이용완료'}">
                                        <span class="badge badge-gray">이용 완료</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge">${r.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <fmt:formatNumber value="${r.totalAmount}" pattern="#,###"/>원
                            </td>

                            <td>

                                <a
                                    href="#"
                                    class="table-detail-link js-detail-link"
                                    data-id="${r.reservationId}"
                                >
                                    상세
                                </a>

                            </td>

                        </tr>

                    </c:forEach>

                    <c:if test="${empty reservationList}">
                        <tr>
                            <td colspan="10" style="text-align:center;">
                                등록된 예약이 없습니다.
                            </td>
                        </tr>
                    </c:if>

                    </tbody>

                </table>

            </div>


            <!-- 우측 상세 패널 : 처음엔 비어있고, "상세" 클릭하면 JS가 채움 -->
            <aside class="reservation-detail-panel" id="detailPanel">

                <h3>예약 상세 정보</h3>
                <p>선택한 예약의 상세정보를 확인하고 관리하세요.</p>

                <div id="detailEmpty">
                    좌측 목록에서 예약을 선택하세요.
                </div>

                <div id="detailContent" style="display:none;">

                    <dl>
                        <dt>예약 번호</dt>
                        <dd id="detailCode"></dd>

                        <dt>고객명</dt>
                        <dd id="detailGuestName"></dd>
						
						<dt>예약자명</dt>
						<dd id="detailBookerName"></dd>

						<dt>전화번호(예약자)</dt>
						<dd id="detailBookerPhone"></dd>

						<dt>객실 타입</dt>
						<dd id="detailTypeName"></dd>

                        <dt>체크인</dt>
                        <dd id="detailCheckin"></dd>

                        <dt>체크아웃</dt>
                        <dd id="detailCheckout"></dd>

                        <dt>인원</dt>
                        <dd id="detailGuestCount"></dd>

                        <dt>예약 상태</dt>
                        <dd id="detailStatus"></dd>

                        <dt>총 예약금액</dt>
                        <dd id="detailTotalAmount"></dd>
                    </dl>

					<div class="detail-panel-buttons">
					    <form id="cancelForm" method="post" style="display:inline;">
					        <button type="submit" class="btn btn-danger"
					                onclick="return confirm('이 예약을 취소하시겠습니까?');">
					            예약 취소
					        </button>
					    </form>
					</div>

                </div>

            </aside>

            </div>
            <!-- // 예약 목록 + 우측 상세패널 -->


            <!-- 하단 -->
            <div class="admin-table-bottom">

                <span>
                    전체 ${fn:length(reservationList)}건
                </span>

				<!-- 페이징-->
				<div class="pagination" id="pagination"></div>
            </div>

        </section>

    </main>

</div>

<script src="/js/reservation.js"></script>

</body>
</html>
