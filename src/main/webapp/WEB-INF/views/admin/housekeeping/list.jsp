<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 하우스키핑</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/admin.css">
    <link rel="stylesheet" href="/css/housekeeping.css">
</head>

<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>

    <main class="admin-content">

        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>

        <section class="admin-main">

            <!-- 상태 요약 -->
            <section class="housekeeping-summary-grid">

                <div class="housekeeping-summary-card">

                    <span>
                        청소 대기
                    </span>

                    <strong>
                        5실
                    </strong>

                </div>


                <div class="housekeeping-summary-card">

                    <span>
                        청소 중
                    </span>

                    <strong>
                        7실
                    </strong>

                </div>


                <div class="housekeeping-summary-card">

                    <span>
                        청소 완료
                    </span>

                    <strong>
                        18실
                    </strong>

                </div>


                <div class="housekeeping-summary-card">

                    <span>
                        점검 완료
                    </span>

                    <strong>
                        12실
                    </strong>

                </div>

            </section>


            <!-- 검색 -->
            <div class="filter-bar housekeeping-filter">

                <select class="form-control housekeeping-filter-select">

                    <option>
                        전체 층
                    </option>

                    <option>
                        3층
                    </option>

                    <option>
                        4층
                    </option>

                    <option>
                        5층
                    </option>

                </select>


                <select class="form-control housekeeping-filter-select">

                    <option>
                        전체 상태
                    </option>

                    <option>
                        청소 대기
                    </option>

                    <option>
                        청소 중
                    </option>

                    <option>
                        청소 완료
                    </option>

                    <option>
                        점검 완료
                    </option>

                </select>


                <div class="search-box">

                    <input
                        type="text"
                        class="form-control"
                        placeholder="객실 번호 또는 담당자 검색"
                    >

                </div>


                <button
                    type="button"
                    class="btn btn-dark"
                >
                    조회
                </button>

            </div>


            <!-- 하우스키핑 테이블 -->
            <div class="table-wrapper">

                <table class="common-table housekeeping-table">

                    <thead>

                    <tr>
                        <th>객실</th>
                        <th>객실 타입</th>
                        <th>상태</th>
                        <th>담당자</th>
                        <th>요청시간</th>
                        <th>시작시간</th>
                        <th>완료시간</th>
                        <th>전달사항</th>
                        <th></th>
                    </tr>

                    </thead>


                    <tbody>

                    <tr>

                        <td>
                            502호
                        </td>

                        <td>
                            디럭스 트윈
                        </td>

                        <td>
                            <span class="badge badge-blue">
                                청소 완료
                            </span>
                        </td>

                        <td>
                            김민지
                        </td>

                        <td>
                            12:15
                        </td>

                        <td>
                            12:30
                        </td>

                        <td>
                            13:10
                        </td>

                        <td>
                            미니바 확인 필요
                        </td>

                        <td>

                            <button
                                type="button"
                                class="housekeeping-detail-btn"
                            >
                                관리
                            </button>

                        </td>

                    </tr>


                    <tr>

                        <td>
                            503호
                        </td>

                        <td>
                            프리미어 킹
                        </td>

                        <td>
                            <span class="badge badge-dark">
                                청소 중
                            </span>
                        </td>

                        <td>
                            박정우
                        </td>

                        <td>
                            12:45
                        </td>

                        <td>
                            13:00
                        </td>

                        <td>
                            -
                        </td>

                        <td>
                            침구 교체
                        </td>

                        <td>

                            <button
                                type="button"
                                class="housekeeping-detail-btn"
                            >
                                관리
                            </button>

                        </td>

                    </tr>


                    <tr>

                        <td>
                            405호
                        </td>

                        <td>
                            디럭스 더블
                        </td>

                        <td>
                            <span class="badge badge-blue">
                                청소 대기
                            </span>
                        </td>

                        <td>
                            미배정
                        </td>

                        <td>
                            13:45
                        </td>

                        <td>
                            -
                        </td>

                        <td>
                            -
                        </td>

                        <td>
                            고객 퇴실 완료
                        </td>

                        <td>

                            <button
                                type="button"
                                class="housekeeping-detail-btn"
                            >
                                관리
                            </button>

                        </td>

                    </tr>


                    <tr>

                        <td>
                            305호
                        </td>

                        <td>
                            패밀리 스위트
                        </td>

                        <td>
                            <span class="badge badge-dark">
                                점검 완료
                            </span>
                        </td>

                        <td>
                            이지수
                        </td>

                        <td>
                            10:20
                        </td>

                        <td>
                            10:30
                        </td>

                        <td>
                            11:40
                        </td>

                        <td>
                            이상 없음
                        </td>

                        <td>

                            <button
                                type="button"
                                class="housekeeping-detail-btn"
                            >
                                관리
                            </button>

                        </td>

                    </tr>

                    </tbody>

                </table>

            </div>


            <!-- 하단 -->
            <div class="admin-table-bottom">

                <span>
                    전체 42건
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


            <!-- 상태 변경 패널 예시 -->
            <section class="housekeeping-management-panel">

                <div class="housekeeping-panel-header">

                    <div>

                        <span class="badge badge-dark">
                            청소 중
                        </span>

                        <h2>
                            503호 객실 정비
                        </h2>

                        <p>
                            프리미어 킹
                        </p>

                    </div>

                </div>


                <div class="housekeeping-detail-grid">

                    <div>

                        <span>
                            담당자
                        </span>

                        <select class="form-control">

                            <option>
                                박정우
                            </option>

                            <option>
                                김민지
                            </option>

                            <option>
                                이지수
                            </option>

                        </select>

                    </div>


                    <div>

                        <span>
                            작업 시작시간
                        </span>

                        <strong>
                            13:00
                        </strong>

                    </div>


                    <div>

                        <span>
                            예상 완료시간
                        </span>

                        <strong>
                            13:40
                        </strong>

                    </div>

                </div>


                <div class="housekeeping-note">

                    <label class="form-label">
                        전달사항
                    </label>

                    <textarea
                        class="form-control"
                    >침구 전체 교체 및 욕실 어메니티 보충</textarea>

                </div>


                <div class="housekeeping-status-flow">

                    <div class="status-flow-item completed">

                        <span>
                            01
                        </span>

                        <strong>
                            청소 대기
                        </strong>

                    </div>


                    <div class="status-flow-line active"></div>


                    <div class="status-flow-item current">

                        <span>
                            02
                        </span>

                        <strong>
                            청소 중
                        </strong>

                    </div>


                    <div class="status-flow-line"></div>


                    <div class="status-flow-item">

                        <span>
                            03
                        </span>

                        <strong>
                            청소 완료
                        </strong>

                    </div>


                    <div class="status-flow-line"></div>


                    <div class="status-flow-item">

                        <span>
                            04
                        </span>

                        <strong>
                            점검 완료
                        </strong>

                    </div>

                </div>


                <div class="housekeeping-action-row">

                    <button
                        type="button"
                        class="btn btn-outline"
                    >
                        담당자 변경
                    </button>

                    <button
                        type="button"
                        class="btn btn-primary"
                    >
                        청소 완료 처리
                    </button>

                </div>

            </section>

        </section>

    </main>

</div>

</body>
</html>