<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!--
	실제 기능 연결 때는 로그인한 계정 유형에 따라 이동 경로를 나눠야 함.
	CUSTOMER
	    ↓
	/customer/main


	EMPLOYEE
	    ↓
	/admin/dashboard
	LoginController나 AuthController에서 처리
-->
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>The OneFive - 로그인</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/customer.css">
</head>

<body>
<div class="auth-page">
    <!-- 왼쪽 브랜드 영역 -->
    <section class="auth-brand">
        <div class="auth-brand-overlay">
            <a href="/" class="auth-logo">
				<span class="auth-logo-icon">
					<img src="${pageContext.request.contextPath}/images/common/hotel-icon.png"
						alt="The OneFive 로고">
				</span>
                <div>
                    <strong>The OneFive</strong>
                    <span>HOTEL & RESORT</span>
                </div>

            </a>
            <div class="auth-brand-content">
                <span class="auth-chip">
                    HOTEL LOGIN
                </span>
                <h1>
                    The OneFive 로그인
                </h1>
                <p>
                    호텔 통합 로그인 시스템
                </p>

                <div class="auth-blue-line"></div>

            </div>


            <div class="auth-feature-area">

                <h3>
                    KEY FEATURES
                </h3>

                <div class="auth-feature">

                    <span class="auth-check">✓</span>

                    <div>
                        <strong>안전한 로그인 시스템</strong>

                        <p>
                            256비트 SSL 암호화로 고객님의
                            개인정보를 안전하게 보호합니다.
                        </p>
                    </div>

                </div>


                <div class="auth-feature">

                    <span class="auth-check">✓</span>

                    <div>
                        <strong>실시간 예약 관리</strong>

                        <p>
                            객실 예약, 변경, 취소를
                            간편하게 관리할 수 있습니다.
                        </p>
                    </div>

                </div>


                <div class="auth-feature">

                    <span class="auth-check">✓</span>

                    <div>
                        <strong>통합 서비스 이용</strong>

                        <p>
                            멤버십 혜택, 포인트 적립,
                            문의 관리 등 모든 서비스를 한 곳에서 이용합니다.
                        </p>
                    </div>

                </div>

            </div>

        </div>

    </section>


    <!-- 오른쪽 로그인 영역 -->
    <section class="auth-form-section">

        <div class="auth-form-card">

            <div class="auth-form-title">

                <h2>
                    로그인
                </h2>

                <p>
                    아이디와 비밀번호를 입력해 주세요.
                </p>

            </div>


            <form action="/login" method="post">

                <div class="form-group">

                    <label for="loginId" class="form-label">
                        아이디
                    </label>

                    <input type="text" id="loginId" name="loginId" value="${savedLoginId}"
					class="form-control" placeholder="아이디를 입력하세요" required />

                </div>


                <div class="form-group">

                    <label for="password" class="form-label">
                        비밀번호
                    </label>

                    <input type="password" id="password" name="password" 
					 class="form-control" placeholder="비밀번호를 입력하세요" required>

                </div>


				<div class="login-option-row">

				    <label class="login-remember">
				        <input type="checkbox" name="rememberId" id="rememberId">
						<c:if test="${not empty savedLoginId}"></c:if>
				        아이디 저장
				    </label>

                </div>


                <button type="submit" class="btn btn-primary auth-submit">
                    로그인
                </button>

            </form>


            <div class="auth-bottom-link">

                <span>
                    계정이 없으신가요?
                </span>

                <a href="/customer/signup">
                    회원 가입
                </a><br><br>

				<a href="/admin/adminLogin">관리자용 로그인 </a>
				
            </div>

        </div>


        <div class="auth-copyright">

            안전한 로그인을 위해 개인정보 보호 정책을 준수합니다.

            <br>

            © 2026 The OneFive Hotel. All rights reserved.

        </div>

    </section>

</div>
<script>
    // 컨트롤러에서 넘어온 errorMessage 확인
    const errorMessage = "${errorMessage}";
    
    if (errorMessage && errorMessage.trim() !== "") {
        alert(errorMessage);
    }
</script>
</body>
</html>