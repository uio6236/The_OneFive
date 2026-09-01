<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 회원가입</title>

    <link
        rel="stylesheet"
        href="/css/common.css"
    >

    <link
        rel="stylesheet"
        href="/css/customer.css"
    >
</head>

<body>

<div class="auth-page">

    <!-- 왼쪽 브랜드 영역 -->
    <section class="auth-brand">

        <div class="auth-brand-overlay">

            <a href="/" class="auth-logo">

                <span class="auth-logo-icon">
                    ▣
                </span>

                <div>
                    <strong>The OneFive</strong>
                    <span>HOTEL & RESORT</span>
                </div>

            </a>


            <div class="auth-brand-content">

                <span class="auth-chip">
                    MEMBERSHIP
                </span>

                <h1>
                    The OneFive 호텔
                    <br>
                    고객 회원가입
                </h1>

                <p>
                    간편하게 회원가입하고 다양한 혜택을 누리세요.
                </p>

                <div class="auth-blue-line"></div>

            </div>


            <div class="auth-feature-area">

                <h3>
                    BENEFITS
                </h3>


                <div class="auth-feature">

                    <span class="auth-check">
                        ✓
                    </span>

                    <div>

                        <strong>
                            실시간 객실 예약 현황
                        </strong>

                        <p>
                            원하는 날짜와 객실 타입을 선택하여
                            예약 가능 여부를 확인할 수 있습니다.
                        </p>

                    </div>

                </div>


                <div class="auth-feature">

                    <span class="auth-check">
                        ✓
                    </span>

                    <div>

                        <strong>
                            간편 체크인 / 체크아웃
                        </strong>

                        <p>
                            사전 정보 등록으로 도착 시
                            빠르고 편리하게 이용할 수 있습니다.
                        </p>

                    </div>

                </div>


                <div class="auth-feature">

                    <span class="auth-check">
                        ✓
                    </span>

                    <div>
                        <strong>
                            멤버십 혜택 및 포인트 적립
                        </strong>
                        <p>
                            회원 전용 할인과 포인트 등
                            다양한 혜택을 제공합니다.
                        </p>
                    </div>
                </div>
            </div>
        </div>

    </section>

    <!-- 회원가입 -->
    <section class="auth-form-section">
        <div class="auth-form-card signup-card">
            <div class="auth-form-title">
                <h2>
                    회원가입
                </h2>
                <p>
                    The OneFive 호텔의 멤버십 서비스 이용을 위해
                    회원 정보를 등록해 주세요.
                </p>
            </div>


            <form action="/customer/signup" method="post" id="signup-form">
                <div class="form-group">
                    <label for="loginId" class="form-label">
                        아이디
                    </label>
					
                    <input type="text" id="loginId" name="loginId" class="form-control" 
					placeholder="아이디를 입력하세요" required>
					
					<button type="button" id="check-id-btn" class="btn btn-outline">중복확인</button>
					
					<p id="check-id-result" class="form-tip"></p>
                </div>

                <div class="form-group">

                    <label for="password" class="form-label" >
                        비밀번호
                    </label>
					
                    <input type="password" id="password" name="password" class="form-control"
                        placeholder="비밀번호를 입력하세요" required>
                </div>

                <div class="form-group">

                    <label for="passwordCheck" class="form-label">
                        비밀번호 확인
                    </label>

                    <input type="password" id="passwordCheck" class="form-control" 
					placeholder="비밀번호를 한번 더 입력하세요" required>
					
					<p id="check-pwd-result" class="form-tip"></p>

                </div>


                <div class="form-group">

                    <label
                        for="customerName"
                        class="form-label"
                    >
                        이름
                    </label>

                    <input
                        type="text"
                        id="name"
                        name="name"
                        class="form-control"
                        placeholder="이름을 입력하세요"
                        required
                    >

                </div>


                <div class="form-group">

                    <label
                        for="phone"
                        class="form-label"
                    >
                        전화번호
                    </label>

                    <input
                        type="tel"
                        id="phone"
                        name="phone"
                        class="form-control"
                        placeholder="010-0000-0000"
                        required
                    >

                </div>


                <div class="form-group">

                    <label
                        for="email"
                        class="form-label"
                    >
                        이메일
                    </label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        class="form-control"
                        placeholder="example@email.com"
                        required
                    >

                </div>


                <button
                    type="submit"
                    class="btn btn-primary auth-submit"
                >
                    회원가입
                </button>

            </form>


            <div class="auth-bottom-link">

                <span>
                    이미 계정이 있으신가요?
                </span>

                <a href="/login">
                    로그인
                </a>

            </div>

        </div>


        <div class="auth-copyright">

            회원가입 시 The OneFive 호텔의 이용약관 및
            개인정보 처리방침에 동의하게 됩니다.

            <br>

            © 2026 The OneFive Hotel. All rights reserved.

        </div>

    </section>

</div>
<script src="/js/customer.js" defer></script>
</body>

</html>