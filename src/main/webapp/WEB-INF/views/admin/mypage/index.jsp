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

            <c:if test="${not empty message}">
                <p class="mypage-message success">${message}</p>
            </c:if>

            <c:if test="${not empty error}">
                <p class="mypage-message error">${error}</p>
            </c:if>

            <section class="mypage-layout">

                <!-- 왼쪽 컬럼: 프로필 + 개인 기본 정보 -->
                <div class="mypage-left-column">

                    <div class="mypage-card mypage-profile-card">

                        <div class="mypage-avatar">
                            ${fn:substring(employee.name, 0, 1)}
                        </div>

                        <h2>${employee.name}</h2>
                        <p class="mypage-position">${employee.position}</p>

                    </div>


                    <div class="mypage-card">

                        <form action="${pageContext.request.contextPath}/admin/mypage/update-info" method="post">

                            <div class="mypage-section-header">
                                <h3>개인 기본 정보</h3>
                                <button type="submit" class="btn btn-outline btn-sm">정보 수정</button>
                            </div>

                            <div class="mypage-form-grid">

                                <div class="mypage-form-group">
                                    <label for="name">이름</label>
                                    <input type="text" id="name" name="name" value="${employee.name}"
                                           pattern="[가-힣a-zA-Z\s]{2,10}" minlength="2" maxlength="10"
                                           title="한글/영문 2~10자, 숫자나 특수문자는 입력할 수 없습니다." required>
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
                                    <input type="tel" id="phone" name="phone" value="${employee.phone}"
                                           pattern="[0-9-]+" title="숫자와 '-'만 입력할 수 있습니다." required>
                                </div>

                            </div>

                        </form>

                    </div>

                </div>


                <!-- 오른쪽 컬럼: 비밀번호 변경 + 계정 작업 -->
                <div class="mypage-right-column">

                    <div class="mypage-card">

                        <form action="${pageContext.request.contextPath}/admin/mypage/update-password" method="post">

                            <div class="mypage-section-header">
                                <h3>비밀번호 변경</h3>
                            </div>

                            <div class="mypage-password-form">

                                <div class="mypage-form-group">
                                    <label for="currentPassword">현재 비밀번호</label>
                                    <input type="password" id="currentPassword" name="currentPassword"
                                           placeholder="현재 비밀번호 입력">
                                </div>

                                <div class="mypage-form-group">
                                    <label for="newPassword">새 비밀번호</label>
                                    <input type="password" id="newPassword" name="newPassword"
                                           placeholder="새로운 비밀번호 입력"
                                           pattern="(?=.*[A-Za-z])(?=.*\d).{8,}" minlength="8"
                                           title="영문과 숫자를 포함하여 8자 이상 입력해주세요.">
                                </div>

                                <div class="mypage-form-group">
                                    <label for="newPasswordCheck">새 비밀번호 확인</label>
                                    <input type="password" id="newPasswordCheck" name="newPasswordCheck"
                                           placeholder="새로운 비밀번호 재입력">
                                </div>

                            </div>

                            <div class="mypage-submit-row">
                                <button type="submit" class="btn btn-primary">비밀번호 변경 적용</button>
                            </div>

                        </form>

                    </div>


                    <div class="mypage-card mypage-account-actions">

                        <div class="mypage-section-header">
                            <h3>계정 작업</h3>
                        </div>

                        <p>안전한 로그아웃으로 관리 시스템 세션을 완전 종료할 수 있습니다.</p>

                        <a href="/logout" class="btn btn-danger-outline">로그아웃</a>

                    </div>

                </div>

            </section>

        </section>

    </main>

</div>

</body>
</html>
