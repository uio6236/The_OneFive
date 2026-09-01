<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>The OneFive - 문의하기</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/customer.css">
    <link rel="stylesheet" href="/css/inquiry.css">
</head>

<body>

<div class="customer-page">

    <jsp:include page="/WEB-INF/views/common/customerHeader.jsp"/>

    <main class="customer-main">

        <div class="mypage-title">
            <h1>문의하기</h1>
            <p>궁금하신 사항을 남겨주시면 확인 후 답변드리겠습니다.</p>
        </div>

        <form action="${pageContext.request.contextPath}/customer/inquiries" method="post"
              class="inquiry-detail-panel">

            <div class="inquiry-answer-area">
                <label for="title" class="form-label">제목</label>
                <input type="text" id="title" name="title" class="form-control"
                       placeholder="문의 제목을 입력하세요" required>
            </div>

            <div class="inquiry-answer-area">
                <label for="content" class="form-label">문의 내용</label>
                <textarea id="content" name="content" class="form-control"
                          placeholder="문의하실 내용을 자세히 입력해주세요." required></textarea>
            </div>

            <div class="inquiry-action-row">
                <a href="${pageContext.request.contextPath}/customer/inquiries" class="btn btn-outline">
                    취소
                </a>
                <button type="submit" class="btn btn-primary">등록</button>
            </div>

        </form>

    </main>

</div>

</body>
</html>
