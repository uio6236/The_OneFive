<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>The OneFive - 문의 상세</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/customer.css">
    <link rel="stylesheet" href="/css/inquiry.css">
</head>

<body>

<div class="customer-page">

    <jsp:include page="/WEB-INF/views/common/customerHeader.jsp"/>

    <main class="customer-main">

        <c:if test="${empty inquiry}">
            <p class="inquiry-empty">문의를 찾을 수 없습니다.</p>
        </c:if>

        <c:if test="${not empty inquiry}">

            <div class="inquiry-detail-panel">

                <div class="inquiry-detail-header">
                    <div>
                        <c:choose>
                            <c:when test="${inquiry.status == '대기중'}">
                                <span class="badge badge-blue">답변 대기</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-dark">답변 완료</span>
                            </c:otherwise>
                        </c:choose>

                        <h2>${inquiry.title}</h2>
                        <p>문의번호 ${inquiry.inquiryNo} · <fmt:formatDate value="${inquiry.createdAt}" pattern="yyyy.MM.dd HH:mm"/></p>
                    </div>
                </div>

                <div class="inquiry-content-box">
                    <span>문의 내용</span>
                    <p>${inquiry.content}</p>
                </div>

                <c:choose>
                    <c:when test="${inquiry.status == '답변완료'}">
                        <div class="inquiry-content-box">
                            <span>답변 내용</span>
                            <p>${inquiry.answer}</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="inquiry-empty">아직 답변이 등록되지 않았습니다.</p>
                    </c:otherwise>
                </c:choose>

                <div class="inquiry-action-row">
                    <a href="${pageContext.request.contextPath}/customer/inquiries" class="btn btn-outline">
                        목록으로
                    </a>
                </div>

            </div>

        </c:if>

    </main>

</div>

</body>
</html>
