<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 예약 관리</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/admin.css">
    <link rel="stylesheet" href="/css/reservation.css">
</head>

<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>

    <main class="admin-content">

        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>

        <section class="admin-main">

            <!-- 상단 -->
            <div class="admin-page-action-row">

                <div>
                    <h2>
                        전체 예약 현황
                    </h2>

                    <p>
                        고객 예약정보를 조회하고 관리합니다.
                    </p>
                </div>


                <a
                    href="/admin/reservations/new"
                    class="btn btn-primary"
                >
                    + 새 예약 등록
                </a>

            </div>


            <!-- 검색 -->
            <div class="filter-bar reservation-filter">

                <div class="search-box">

                    <input
                        type="text"
                        class="form-control"
                        placeholder="예약번호 또는 고객명을 검색하세요"
                    >

                </div>


                <select class="form-control reservation-filter-select">

                    <option>
                        전체 상태
                    </option>

                    <option>
                        예약 확정
                    </option>

                    <option>
                        입금 대기
                    </option>

                    <option>
                        예약 취소
                    </option>

                </select>


                <input
                    type="date"
                    class="form-control reservation-date"
                >


                <button class="btn btn-dark">
                    검색
                </button>

            </div>


            <!-- 예약 테이블 -->
            <div class="table-wrapper reservation-table-wrapper">

                <table class="common-table">

                    <thead>

                    <tr>
                        <th>예약번호</th>
                        <th>고객명</th>
                        <th>객실</th>
                        <th>객실 타입</th>
                        <th>체크인</th>
                        <th>체크아웃</th>
                        <th>인원</th>
                        <th>상태</th>
                        <th>총 예약금액</th>
                        <th></th>
                    </tr>

                    </thead>


                    <tbody>

                    <tr>

                        <td>
                            RS-20260811-01
                        </td>

                        <td>
                            김우현
                        </td>

                        <td>
                            405호
                        </td>

                        <td>
                            디럭스 더블
                        </td>

                        <td>
                            2026.08.11
                        </td>

                        <td>
                            2026.08.14
                        </td>

                        <td>
                            2명
                        </td>

                        <td>
                            <span class="badge badge-blue">
                                예약 확정
                            </span>
                        </td>

                        <td>
                            ₩540,000
                        </td>

                        <td>

                            <a
                                href="/admin/reservations/1"
                                class="table-detail-link"
                            >
                                상세
                            </a>

                        </td>

                    </tr>


                    <tr>

                        <td>
                            RS-20260811-02
                        </td>

                        <td>
                            박서연
                        </td>

                        <td>
                            미배정
                        </td>

                        <td>
                            프리미어 킹
                        </td>

                        <td>
                            2026.08.11
                        </td>

                        <td>
                            2026.08.13
                        </td>

                        <td>
                            2명
                        </td>

                        <td>
                            <span class="badge badge-dark">
                                입금 대기
                            </span>
                        </td>

                        <td>
                            ₩520,000
                        </td>

                        <td>

                            <a
                                href="/admin/reservations/2"
                                class="table-detail-link"
                            >
                                상세
                            </a>

                        </td>

                    </tr>


                    <tr class="cancelled-row">

                        <td>
                            RS-20260810-05
                        </td>

                        <td>
                            최수진
                        </td>

                        <td>
                            -
                        </td>

                        <td>
                            디럭스 트윈
                        </td>

                        <td>
                            2026.08.15
                        </td>

                        <td>
                            2026.08.17
                        </td>

                        <td>
                            2명
                        </td>

                        <td>
                            <span class="badge badge-danger">
                                예약 취소
                            </span>
                        </td>

                        <td>
                            ₩390,000
                        </td>

                        <td>

                            <a
                                href="/admin/reservations/3"
                                class="table-detail-link"
                            >
                                상세
                            </a>

                        </td>

                    </tr>

                    </tbody>

                </table>

            </div>


            <!-- 하단 -->
            <div class="admin-table-bottom">

                <span>
                    전체 124건 중 1-10 표시
                </span>


                <div class="pagination">

                    <a href="#">
                        ‹
                    </a>

                    <a href="#" class="active">
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