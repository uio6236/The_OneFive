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
                    관리자 회원가입
                </h1>

                <p>
                    호텔 관리 시스템 이용을 위한 관리자 계정을 등록하세요
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
                            통합 호텔 운영 관리
                        </strong>

                        <p>
                            객실, 예약, 고객 정보를 한 곳에서 통합 관리하고 운영 효율을 극대화 할 수 있습니다.
                        </p>

                    </div>

                </div>


                <div class="auth-feature">

                    <span class="auth-check">
                        ✓
                    </span>

                    <div>

                        <strong>
                            실시간 현황 모니터링
                        </strong>

                        <p>
                         객실 가동률, 매출, 체크인/체크아웃 현황을 실시간 대시보드로 확인할 수 있습니다.
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
                    The OneFive 호텔 관리 시스템 이용을 위해 관리자 정보를 등록해 주세요.
                </p>
            </div>


            <form action="/admin/adminSignup" method="post" id="signup-form">
                <div class="form-group">
                    <label for="code" class="form-label">
                        사번
                    </label>
					
                    <input type="text" id="code" name="code" class="form-control" 
					placeholder="사번을 입력하세요" required>
					
					<button type="button" id="check-code-btn" class="btn btn-outline">중복확인</button>
					
					<p id="check-code-result" class="form-tip"></p>
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
				
				<label class="form-label">부서</label>

				<!-- 라디오 버튼들을 감싸는 박스 (이미지의 라운드 테두리 스타일 적용) -->
				<div class="dept-radio-group">
				    <label class="radio-item">
				        <input type="radio" id="dept_front" name="position" value="프론트" checked required>
				        <span>프론트</span>
				    </label>
				    
				    <label class="radio-item">
				        <input type="radio" id="dept_housekeeping" name="position" value="하우스키핑" required>
				        <span>하우스키핑</span>
				    </label>
				</div><br>



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
<script src="/js/admin.js" defer></script>
</body>

</html>