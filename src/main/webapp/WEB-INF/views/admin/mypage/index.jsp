<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>The OneFive - 관리자 마이페이지</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/admin.css">
    <link rel="stylesheet" href="/css/mypage.css">
</head>

<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>

    <main class="admin-content">

        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>

        <section class="admin-main">

            <section class="mypage-layout">

                <!-- 왼쪽: 프로필 카드 -->
                <div class="mypage-card mypage-profile-card">

                    <div class="mypage-avatar">
                        ${fn:substring(employee.name, 0, 1)}
                    </div>

                    <h2>${employee.name}</h2>
                    <p class="mypage-position">${employee.position}</p>

                </div>


                <!-- 오른쪽: 정보수정 + 비밀번호 변경 + 계정작업 -->
                <div class="mypage-right-column">

                    <c:if test="${not empty message}">
                        <p class="mypage-message success">${message}</p>
                    </c:if>

                    <c:if test="${not empty error}">
                        <p class="mypage-message error">${error}</p>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/admin/mypage/update" method="post">

                        <!-- 개인 기본 정보 -->
                        <div class="mypage-card">

                            <div class="mypage-section-header">
                                <h3>개인 기본 정보</h3>
                            </div>

                            <div class="mypage-form-grid">

                                <div class="mypage-form-group">
                                    <label for="name">이름</label>
                                    <input type="text" id="name" name="name" value="${employee.name}">
                                </div>

                                <div class="mypage-form-group">
                                    <label for="code">사원번호</label>
                                    <input type="text" id="code" value="${employee.code}" readonly>
                                </div>

                                <div class="mypage-form-group">
                                    <label for="email">이메일 주소</label>
                                    <input type="email" id="email" name="email" value="${employee.email}">
                                </div>

                                <div class="mypage-form-group">
                                    <label for="phone">연락처</label>
                                    <input type="tel" id="phone" name="phone" value="${employee.phone}">
                                </div>

                            </div>

                            <div class="mypage-submit-row">
                                <button type="submit" class="btn btn-primary">정보 수정 저장</button>
                            </div>

                        </div>


                        <!-- 비밀번호 변경 -->
                        <div class="mypage-card">

                            <div class="mypage-section-header">
                                <h3>비밀번호 변경</h3>
                            </div>

                            <div class="mypage-password-form">

                                <div class="mypage-form-group">
                                    <label for="currentPassword">현재 비밀번호</label>
                                    <input type="password" id="currentPassword" name="currentPassword"
                                           placeholder="현재 비밀번호 입력">
                                </div>

                                <div class="mypage-form-grid">
                                    <div class="mypage-form-group">
                                        <label for="newPassword">새 비밀번호</label>
                                        <input type="password" id="newPassword" name="newPassword"
                                               placeholder="새로운 비밀번호 입력">
                                    </div>

                                    <div class="mypage-form-group">
                                        <label for="newPasswordCheck">새 비밀번호 확인</label>
                                        <input type="password" id="newPasswordCheck" name="newPasswordCheck"
                                               placeholder="새로운 비밀번호 재입력">
                                    </div>
                                </div>

                            </div>

                            <div class="mypage-submit-row">
                                <button type="submit" class="btn btn-primary">비밀번호 변경 적용</button>
                            </div>

                        </div>

                    </form>


                    <!-- 계정 작업 (로그아웃) -->
                    <div class="mypage-card mypage-account-actions">

                        <div class="mypage-section-header">
                            <h3>계정 작업</h3>
                        </div>

                        <p>안전한 로그아웃으로 관리 시스템 세션을 완전 종료할 수 있습니다.</p>

                        <a href="/logout" class="btn btn-danger-outline">시스템 로그아웃</a>

                    </div>

                </div>

            </section>

        </section>

    </main>

</div>

</body>
</html>
