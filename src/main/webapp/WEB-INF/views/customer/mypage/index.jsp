<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 마이페이지</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/customer.css">
</head>

<body>

<div class="customer-page">

    <jsp:include page="/WEB-INF/views/common/customerHeader.jsp"/>


    <main class="customer-main">


        <div class="mypage-title">

            <h1>
                마이페이지
            </h1>

            <p>
                고객님의 개인정보 관리와 과거 이용 내역 및
                1:1 문의사항을 통합 제어합니다.
            </p>

        </div>


        <!-- 메뉴 -->
        <nav class="mypage-tabs">

            <a
                href="#profile"
                class="active"
            >
                개인정보 관리
            </a>

            <a href="#inquiry">
                1:1 문의 내역
            </a>

        </nav>


        <!-- 상단 -->
        <section class="mypage-top-layout">


            <!-- 개인정보 -->
            <div
                id="profile"
                class="mypage-profile-card"
            >

                <h2>
                    회원 정보 수정
                </h2>

                <p>
                    The OneFive 호텔 멤버십 계정 정보를
                    최신 상태로 유지하세요.
                </p>


                <form
                    action="/mypage/update"
                    method="post"
                >

                    <div class="form-group">

                        <label class="form-label">
                            고객 계정 ID
                        </label>

                        <input
                            type="text"
                            name="loginId"
                            class="form-control"
                            value="${customer.loginId}"
                        >

                    </div>


                    <div class="form-group">

                        <label class="form-label">
                            고객 성함
                        </label>

                        <input
                            type="text"
                            name="name"
                            class="form-control"
                            value="${customer.name}"
                        >

                    </div>


                    <div class="form-group">

                        <label class="form-label">
                            휴대폰 연락처
                        </label>

                        <input
                            type="text"
                            name="phone"
                            class="form-control"
                            value="${customer.phone}"
                        >

                    </div>


                    <div class="mypage-password-title">
                        비밀번호 변경
                    </div>


                    <div class="form-group">

                        <label class="form-label">
                            현재 비밀번호
                        </label>

                        <input
                            type="password"
                            name="currentPassword"
                            class="form-control"
                            placeholder="현재 사용중인 비밀번호 입력"
                        >

                    </div>


                    <div class="form-group">

                        <label class="form-label">
                            신규 비밀번호
                        </label>

                        <input
                            type="password"
                            name="newPassword"
                            class="form-control"
                            placeholder="새 비밀번호 입력"
                        >

                    </div>


                    <div class="form-group">

                        <label class="form-label">
                            신규 비밀번호 확인
                        </label>

                        <input
                            type="password"
                            name="newPasswordCheck"
                            class="form-control"
                            placeholder="새 비밀번호 재입력"
                        >

                    </div>


                    <div class="mypage-form-buttons">

                        <button type="submit" class="btn btn-primary">
                            회원정보 저장
                        </button>

                    </div>

                </form>

            </div>


            <!-- 우측 멤버십 -->
            <aside class="mypage-summary-area">


                <div class="membership-card">

                    <div class="membership-top">

                        <strong>
                            ▣ The OneFive
                        </strong>

                        <span>
                            VIP
                        </span>

                    </div>

                    <div class="membership-bottom">

                        <span>MEMBER ID
							<strong>onefive_kim01</strong>
                        </span>

                    </div>

                </div>


                <div class="mypage-stat-grid">

                    <div>

                        <span>
                            총 누적 투숙
                        </span>

                        <strong>
                            14회
                        </strong>

                    </div>


                    <div>

                        <span>
                            미답변 문의
                        </span>

                        <strong>
                            1건
                        </strong>

                    </div>

                </div>

            </aside>

        </section>


        <!-- 투숙 내역 -->
        <section
            id="history"
            class="mypage-section-card"
        >

            <h2>
                전체 투숙 및 예약 내역 조회
            </h2>


            <div class="table-wrapper">

                <table class="common-table">

                    <thead>

                    <tr>
                        <th>객실 명 / 호수</th>
                        <th>이용 기간</th>
                        <th>결제금액</th>
                        <th>상태</th>
                        <th>상세</th>
                    </tr>

                    </thead>


                    <tbody>

                    <tr>

                        <td>
                            디럭스 더블
                        </td>

                        <td>
                            2026.08.15 ~ 2026.08.17
                        </td>

                        <td>
                            ₩342,000
                        </td>

                        <td>
                            <span class="badge badge-blue">
                                예약 완료
                            </span>
                        </td>

                        <td>
                            <a href="#" class="mypage-link danger">
                                예약 취소
                            </a>
                        </td>

                    </tr>

                    <tr>
                        <td>
                            디럭스 트윈
                        </td>

                        <td>
                            2026.05.02 ~ 2026.05.03
                        </td>

                        <td>
                            ₩195,000
                        </td>

                        <td>
                            <span class="badge badge-dark">
                                이용 완료
                            </span>
                        </td>

                        <td>

                            <a
                                href="#"
                                class="mypage-link"
                            >
                                상세 보기
                            </a>

                        </td>

                    </tr>


                    <tr>

                        <td>
                            패밀리 스위트
                        </td>

                        <td>
                            2026.01.24 ~ 2026.01.26
                        </td>

                        <td>
                            ₩440,000
                        </td>

                        <td>
                            <span class="badge badge-dark">
                                예약 취소
                            </span>
                        </td>

                        <td>
                            환불 완료
                        </td>

                    </tr>

                    </tbody>

                </table>

            </div>

        </section>


    </main>

	
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</div>

<script src="/js/mypage.js"></script>
</body>
</html>