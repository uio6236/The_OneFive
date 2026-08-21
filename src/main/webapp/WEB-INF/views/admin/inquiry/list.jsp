<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 문의 관리</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/admin.css">
    <link rel="stylesheet" href="/css/inquiry.css">
</head>

<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>

    <main class="admin-content">

        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>

        <section class="admin-main">

            <!-- 상단 요약 -->
            <section class="inquiry-summary-grid">

                <div class="inquiry-summary-card">

                    <span>
                        전체 문의
                    </span>

                    <strong>
                        32건
                    </strong>

                </div>


                <div class="inquiry-summary-card">

                    <span>
                        답변 대기
                    </span>

                    <strong>
                        5건
                    </strong>

                </div>


                <div class="inquiry-summary-card">

                    <span>
                        답변 완료
                    </span>

                    <strong>
                        27건
                    </strong>

                </div>

            </section>


            <!-- 검색 -->
            <div class="filter-bar inquiry-filter">

                <div class="search-box">

                    <input
                        type="text"
                        class="form-control"
                        placeholder="문의번호, 고객명 또는 제목 검색"
                    >

                </div>


                <select class="form-control inquiry-filter-select">

                    <option>
                        전체 상태
                    </option>

                    <option>
                        답변 대기
                    </option>

                    <option>
                        답변 완료
                    </option>

                </select>


                <button
                    type="button"
                    class="btn btn-dark"
                >
                    검색
                </button>

            </div>


            <!-- 문의 영역 -->
            <section class="inquiry-layout">

                <!-- 왼쪽 문의목록 -->
                <div class="inquiry-list-panel">

                    <div class="inquiry-panel-title">

                        <h2>
                            고객 문의 목록
                        </h2>

                        <span>
                            총 32건
                        </span>

                    </div>


                    <div class="inquiry-list">


                        <button
                            type="button"
                            class="inquiry-list-item active"
                        >

                            <div class="inquiry-list-top">

                                <strong>
                                    얼리 체크인 가능 여부 문의
                                </strong>

                                <span class="badge badge-blue">
                                    답변 대기
                                </span>

                            </div>


                            <p>
                                체크인 예정 시간보다 조금 일찍 도착할 예정입니다.
                            </p>


                            <div class="inquiry-list-bottom">

                                <span>
                                    홍길동
                                </span>

                                <span>
                                    2026.08.12
                                </span>

                            </div>

                        </button>


                        <button
                            type="button"
                            class="inquiry-list-item"
                        >

                            <div class="inquiry-list-top">

                                <strong>
                                    레이트 체크아웃 요금 문의
                                </strong>

                                <span class="badge badge-dark">
                                    답변 완료
                                </span>

                            </div>


                            <p>
                                체크아웃 시간 연장 시 추가 비용이 궁금합니다.
                            </p>


                            <div class="inquiry-list-bottom">

                                <span>
                                    김우현
                                </span>

                                <span>
                                    2026.08.11
                                </span>

                            </div>

                        </button>


                        <button
                            type="button"
                            class="inquiry-list-item"
                        >

                            <div class="inquiry-list-top">

                                <strong>
                                    객실 내 침구 추가 요청
                                </strong>

                                <span class="badge badge-dark">
                                    답변 완료
                                </span>

                            </div>


                            <p>
                                어린이 동반으로 추가 침구 요청드립니다.
                            </p>


                            <div class="inquiry-list-bottom">

                                <span>
                                    박서연
                                </span>

                                <span>
                                    2026.08.10
                                </span>

                            </div>

                        </button>

                    </div>

                </div>


                <!-- 오른쪽 상세/답변 -->
                <div class="inquiry-detail-panel">

                    <div class="inquiry-detail-header">

                        <div>

                            <span class="badge badge-blue">
                                답변 대기
                            </span>

                            <h2>
                                얼리 체크인 가능 여부 문의
                            </h2>

                            <p>
                                문의번호 INQ-20260812-01
                            </p>

                        </div>

                    </div>


                    <div class="inquiry-customer-info">

                        <div>

                            <span>
                                고객명
                            </span>

                            <strong>
                                홍길동
                            </strong>

                        </div>


                        <div>

                            <span>
                                이메일
                            </span>

                            <strong>
                                gildong@gmail.com
                            </strong>

                        </div>


                        <div>

                            <span>
                                작성일
                            </span>

                            <strong>
                                2026.08.12 10:25
                            </strong>

                        </div>

                    </div>


                    <div class="inquiry-content-box">

                        <span>
                            문의 내용
                        </span>

                        <p>
                            안녕하세요.
                            8월 15일 체크인 예정인데 개인 일정으로 인해
                            오후 1시쯤 호텔에 도착할 예정입니다.
                            정규 체크인 시간보다 일찍 체크인이 가능한지
                            확인 부탁드립니다.
                        </p>

                    </div>


                    <div class="inquiry-answer-area">

                        <label
                            for="answer"
                            class="form-label"
                        >
                            관리자 답변
                        </label>

                        <textarea
                            id="answer"
                            name="answer"
                            class="form-control"
                            placeholder="고객 문의에 대한 답변을 입력하세요."
                        ></textarea>

                    </div>


                    <div class="inquiry-action-row">

                        <button
                            type="button"
                            class="btn btn-outline"
                        >
                            임시 저장
                        </button>

                        <button
                            type="button"
                            class="btn btn-primary"
                        >
                            답변 등록
                        </button>

                    </div>

                </div>

            </section>


            <!-- Pagination -->
            <div class="admin-table-bottom">

                <span>
                    전체 32건 중 1-10 표시
                </span>


                <div class="pagination">

                    <a href="#">
                        ‹
                    </a>

                    <a
                        href="#"
                        class="active"
                    >
                        1
                    </a>

                    <a href="#">
                        2
                    </a>

                    <a href="#">
                        3
                    </a>

                    <a href="#">
                        ›
                    </a>

                </div>

            </div>

        </section>

    </main>

</div>

</body>
</html>