<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 관리자 마이페이지</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/admin.css">
</head>

<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>

    <main class="admin-content">

        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>

        <section class="admin-main">

            <section class="admin-mypage-layout">


                <!-- 관리자 프로필 -->
                <aside class="admin-mypage-profile-card">

                    <div class="admin-mypage-profile-image">
                        김
                    </div>


                    <h2>
                        김민수
                    </h2>


                    <span class="admin-role-badge">
                        FRONT DESK
                    </span>


                    <div class="admin-profile-info-list">

                        <div>

                            <span>
                                사원번호
                            </span>

                            <strong>
                                EP1002
                            </strong>

                        </div>


                        <div>

                            <span>
                                소속 부서
                            </span>

                            <strong>
                                프런트 데스크
                            </strong>

                        </div>


                        <div>

                            <span>
                                권한
                            </span>

                            <strong>
                                MANAGER
                            </strong>

                        </div>


                        <div>

                            <span>
                                이메일
                            </span>

                            <strong>
                                minsu@theonefive.com
                            </strong>

                        </div>

                    </div>

                </aside>


                <!-- 정보 수정 -->
                <div class="admin-mypage-content-card">

                    <div class="admin-mypage-section-title">

                        <h2>
                            관리자 기본정보
                        </h2>

                        <p>
                            관리자 계정의 연락처 및 계정 정보를 관리합니다.
                        </p>

                    </div>


                    <form
                        action="/admin/mypage/update"
                        method="post"
                    >

                        <div class="admin-form-grid">

                            <div class="form-group">

                                <label class="form-label">
                                    관리자명
                                </label>

                                <input
                                    type="text"
                                    name="employeeName"
                                    class="form-control"
                                    value="김민수"
                                >

                            </div>


                            <div class="form-group">

                                <label class="form-label">
                                    사원번호
                                </label>

                                <input
                                    type="text"
                                    class="form-control"
                                    value="EP1002"
                                    readonly
                                >

                            </div>


                            <div class="form-group">

                                <label class="form-label">
                                    연락처
                                </label>

                                <input
                                    type="tel"
                                    name="phone"
                                    class="form-control"
                                    value="010-1234-5678"
                                >

                            </div>


                            <div class="form-group">

                                <label class="form-label">
                                    이메일
                                </label>

                                <input
                                    type="email"
                                    name="email"
                                    class="form-control"
                                    value="minsu@theonefive.com"
                                >

                            </div>

                        </div>


                        <div class="admin-password-section">

                            <div class="admin-mypage-section-title">

                                <h2>
                                    비밀번호 변경
                                </h2>

                                <p>
                                    계정 보안을 위해 주기적인 변경을 권장합니다.
                                </p>

                            </div>


                            <div class="form-group">

                                <label class="form-label">
                                    현재 비밀번호
                                </label>

                                <input
                                    type="password"
                                    name="currentPassword"
                                    class="form-control"
                                    placeholder="현재 비밀번호 입력"
                                >

                            </div>


                            <div class="admin-form-grid">

                                <div class="form-group">

                                    <label class="form-label">
                                        새 비밀번호
                                    </label>

                                    <input
                                        type="password"
                                        name="newPassword"
                                        class="form-control"
                                        placeholder="새 비밀번호"
                                    >

                                </div>


                                <div class="form-group">

                                    <label class="form-label">
                                        새 비밀번호 확인
                                    </label>

                                    <input
                                        type="password"
                                        name="newPasswordCheck"
                                        class="form-control"
                                        placeholder="새 비밀번호 재입력"
                                    >

                                </div>

                            </div>

                        </div>


                        <div class="admin-mypage-action-row">

                            <button
                                type="reset"
                                class="btn btn-outline"
                            >
                                초기화
                            </button>

                            <button
                                type="submit"
                                class="btn btn-primary"
                            >
                                변경사항 저장
                            </button>

                        </div>

                    </form>


                    <!-- 로그아웃 -->
                    <section class="admin-danger-zone">

                        <div>

                            <h3>
                                시스템 로그아웃
                            </h3>

                            <p>
                                현재 관리자 세션을 종료합니다.
                            </p>

                        </div>


                        <a
                            href="/logout"
                            class="btn btn-danger-outline"
                        >
                            로그아웃
                        </a>

                    </section>

                </div>

            </section>

        </section>

    </main>

</div>

</body>
</html>