<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>The OneFive - 1:1 문의</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/customer.css">
    <link rel="stylesheet" href="/css/inquiry.css">
</head>

<body>

<div class="customer-page">

    <jsp:include page="/WEB-INF/views/common/customerHeader.jsp"/>

    <main class="customer-main">

        <div class="mypage-title">
            <h1>1:1 문의</h1>
            <p>궁금하신 사항을 문의하시면 담당자가 확인 후 답변드립니다.</p>
        </div>

        <div class="inquiry-panel-title">
            <h2>내 문의 내역</h2>
            <a href="${pageContext.request.contextPath}/customer/inquiries/form" class="btn btn-primary">
                문의하기
            </a>
        </div>

        <div class="inquiry-list">

            <c:forEach items="${myInquiries}" var="inq">
                <a href="${pageContext.request.contextPath}/customer/inquiries/detail/${inq.id}"
                   class="inquiry-list-item">

                    <div class="inquiry-list-top">
                        <strong>${inq.title}</strong>

                        <c:choose>
                            <c:when test="${inq.status == '대기중'}">
                                <span class="badge badge-blue">답변 대기</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-dark">답변 완료</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <p>${inq.content}</p>

                    <div class="inquiry-list-bottom">
                        <span>${inq.inquiryNo}</span>
                        <span><fmt:formatDate value="${inq.createdAt}" pattern="yyyy.MM.dd"/></span>
                    </div>

                </a>
            </c:forEach>

            <c:if test="${empty myInquiries}">
                <p class="inquiry-empty">등록하신 문의가 없습니다.</p>
            </c:if>

        </div>

    </main>

</div>

</body>
</html>
