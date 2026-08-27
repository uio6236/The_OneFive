<%@ page contentType="text/html; charset=UTF-8" %>

<header class="admin-header">
    <div class="admin-header-title">
        <h1>${pageTitle}</h1>
        <p>${pageDescription}</p>
    </div>

    <div class="admin-header-actions">
        <div class="admin-date">
            ${today} <!-- 나중에 common의 controller에서 Date 함수로 날짜 불러와서 model로 넣어주기 -->
        </div>
    </div>
</header>