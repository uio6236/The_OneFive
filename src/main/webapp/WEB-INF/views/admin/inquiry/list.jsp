<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 문의 관리</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/admin.css">
    <link rel="stylesheet" href="/css/inquiry.css">
</head>

<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>

    <main class="admin-content">

        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>

        <section class="admin-main">

            <!-- 상단 요약 -->
            <section class="inquiry-summary-grid">

                <div class="inquiry-summary-card">
                    <span>전체 문의</span>
                    <strong>${totalCount}건</strong>
                </div>

                <div class="inquiry-summary-card">
                    <span>답변 대기</span>
                    <strong>${pendingCount}건</strong>
                </div>

                <div class="inquiry-summary-card">
                    <span>답변 완료</span>
                    <strong>${completedCount}건</strong>
                </div>

            </section>


            <!-- 검색/필터 -->
            <form action="${pageContext.request.contextPath}/admin/inquiries" method="get"
                  class="filter-bar inquiry-filter">

                <div class="search-box">
                    <input type="text" name="keyword" class="form-control"
                           placeholder="문의번호, 고객명 또는 제목 검색"
                           value="${keyword}">
                </div>

                <select name="status" class="form-control inquiry-filter-select">
                    <option value="전체" ${empty status || status == '전체' ? 'selected' : ''}>전체 상태</option>
                    <option value="대기중" ${status == '대기중' ? 'selected' : ''}>대기중</option>
                    <option value="답변완료" ${status == '답변완료' ? 'selected' : ''}>답변완료</option>
                </select>

                <select name="sortOrder" class="form-control inquiry-filter-select">
                    <option value="latest" ${empty sortOrder || sortOrder == 'latest' ? 'selected' : ''}>작성일 기준: 최신순</option>
                    <option value="oldest" ${sortOrder == 'oldest' ? 'selected' : ''}>작성일 기준: 오래된순</option>
                </select>

                <button type="submit" class="btn btn-dark">검색</button>

            </form>


            <!-- 문의 영역 -->
            <section class="inquiry-layout">

                <!-- 왼쪽 문의목록 -->
                <div class="inquiry-list-panel">

                    <div class="inquiry-panel-title">
                        <h2>고객 문의 목록</h2>
                        <span>총 ${filteredCount}건</span>
                    </div>

                    <div class="inquiry-table-wrapper">
                        <table class="inquiry-table">
                            <thead>
                                <tr>
                                    <th>문의번호</th>
                                    <th>문의 제목</th>
                                    <th>고객명</th>
                                    <th>작성일</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody>

                                <c:forEach items="${inquiryList}" var="inq">
                                    <tr class="${selectedInquiry.id == inq.id ? 'active' : ''}"
                                        onclick="location.href='${pageContext.request.contextPath}/admin/inquiries?id=${inq.id}'">

                                        <td class="inquiry-table-no">${inq.inquiryNo}</td>
                                        <td class="inquiry-table-title">${fn:escapeXml(inq.title)}</td>
                                        <td>${fn:escapeXml(inq.guestName)}</td>
                                        <td class="inquiry-table-date"><fmt:formatDate value="${inq.createdAt}" pattern="yyyy-MM-dd"/></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${inq.status == '대기중'}">
                                                    <span class="badge badge-blue">대기중</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-dark">답변완료</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                    </tr>
                                </c:forEach>

                                <c:if test="${empty inquiryList}">
                                    <tr>
                                        <td colspan="5" class="inquiry-empty">등록된 문의가 없습니다.</td>
                                    </tr>
                                </c:if>

                            </tbody>
                        </table>
                    </div>

                    <!-- 페이지네이션 -->
                    <c:if test="${totalPages > 1}">
                    <div class="admin-table-bottom">

                   

                      <br><div class="pagination">

                            <c:if test="${currentPage > 1}">
                                <a href="${pageContext.request.contextPath}/admin/inquiries?page=${currentPage - 1}&keyword=${keyword}&status=${status}&sortOrder=${sortOrder}">
                                    &lsaquo;
                                </a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="p">
                                <a href="${pageContext.request.contextPath}/admin/inquiries?page=${p}&keyword=${keyword}&status=${status}&sortOrder=${sortOrder}"
                                   class="${p == currentPage ? 'active' : ''}">
                                    ${p}
                                </a>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a href="${pageContext.request.contextPath}/admin/inquiries?page=${currentPage + 1}&keyword=${keyword}&status=${status}&sortOrder=${sortOrder}">
                                    &rsaquo;
                                </a>
                            </c:if>

                        </div><br>

                    </div>
                    </c:if>

                </div>


                <!-- 오른쪽 상세/답변 -->
                <c:if test="${not empty selectedInquiry}">
                <div class="inquiry-detail-panel">

                    <div class="inquiry-detail-header">
                        <div>
                            <c:choose>
                                <c:when test="${selectedInquiry.status == '대기중'}">
                                    <span class="badge badge-blue">답변 대기</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-dark">답변 완료</span>
                                </c:otherwise>
                            </c:choose>

                            <h2>${fn:escapeXml(selectedInquiry.title)}</h2>
                            <p>문의번호 ${selectedInquiry.inquiryNo}</p>
                        </div>
                    </div>

                    <div class="inquiry-customer-info">
                        <div>
                            <span>고객명</span>
                            <strong>${fn:escapeXml(selectedInquiry.guestName)}</strong>
                        </div>

                        <div>
                            <span>이메일</span>
                            <strong>${fn:escapeXml(selectedInquiry.guestEmail)}</strong>
                        </div>

                        <div>
                            <span>작성일</span>
                            <strong><fmt:formatDate value="${selectedInquiry.createdAt}" pattern="yyyy.MM.dd HH:mm"/></strong>
                        </div>
                    </div>

                    <div class="inquiry-content-box">
                        <span>문의 내용</span>
                        <p>${fn:escapeXml(selectedInquiry.content)}</p>
                    </div>

                    <c:if test="${not empty error}">
                        <p class="inquiry-message error">${error}</p>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/inquiries/answer" method="post">
                        <input type="hidden" name="id" value="${selectedInquiry.id}">

                        <div class="inquiry-answer-area">
                            <label for="answer" class="form-label">관리자 답변</label>
                            <textarea id="answer" name="answer" class="form-control"
                                      placeholder="고객 문의에 대한 답변을 입력하세요.">${fn:escapeXml(selectedInquiry.answer)}</textarea>
                        </div>

                        <div class="inquiry-action-row">
                            <button type="submit" class="btn btn-primary">
                                <c:choose>
                                    <c:when test="${selectedInquiry.status == '답변완료'}">답변 수정</c:when>
                                    <c:otherwise>답변 등록</c:otherwise>
                                </c:choose>
                            </button>
                        </div>
                    </form>

                </div>
                </c:if>

            </section>

        </section>

    </main>

</div>

</body>
</html>
