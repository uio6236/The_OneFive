<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>The OneFive - 고객 관리</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/admin.css">
    <link rel="stylesheet" href="/css/customer.css">
</head>

<body>

<div class="admin-layout">

    <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>

    <main class="admin-content">

        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>

        <section class="admin-main">


            <div class="admin-page-action-row">

                <div>

                    <h2>
                        고객 및 투숙객 관리
                    </h2>

                    <p>
                        고객 기본정보와 방문 이력 및 특이사항을 관리합니다.
                    </p>

                </div>


                <button
                    type="button"
                    class="btn btn-primary"
                >
                    + 고객 등록
                </button>

            </div>


            <!-- 검색 -->
            <div class="filter-bar admin-customer-filter">

                <div class="search-box">

                    <input
                        type="text"
                        class="form-control"
                        placeholder="고객명, 연락처, 이메일 검색"
                    >

                </div>


                <select class="form-control customer-filter-select">

                    <option>
                        전체 등급
                    </option>

                    <option>
                        일반
                    </option>

                    <option>
                        VIP
                    </option>

                </select>


                <select class="form-control customer-filter-select">

                    <option>
                        전체 방문
                    </option>

                    <option>
                        첫 방문
                    </option>

                    <option>
                        재방문
                    </option>

                </select>


                <button
                    type="button"
                    class="btn btn-dark"
                >
                    검색
                </button>

            </div>


            <!-- 고객 테이블 -->
            <div class="table-wrapper admin-customer-table">

                <table class="common-table">

                    <thead>

                    <tr>
                        <th>고객명</th>
                        <th>연락처</th>
                        <th>이메일</th>
                        <th>등급</th>
                        <th>총 방문</th>
                        <th>최근 방문일</th>
                        <th>재방문</th>
                        <th>특이사항</th>
                        <th></th>
                    </tr>

                    </thead>


                    <tbody>

                    <tr>

                        <td>
                            김우현
                        </td>

                        <td>
                            010-1234-5678
                        </td>

                        <td>
                            woohyun@email.com
                        </td>

                        <td>
                            <span class="badge badge-blue">
                                VIP
                            </span>
                        </td>

                        <td>
                            14회
                        </td>

                        <td>
                            2026.08.11
                        </td>

                        <td>
                            <span class="badge badge-dark">
                                REVISIT
                            </span>
                        </td>

                        <td>
                            고층 객실 선호
                        </td>

                        <td>

                            <a
                                href="/admin/customers/1"
                                class="table-detail-link"
                            >
                                상세
                            </a>

                        </td>

                    </tr>


                    <tr>

                        <td>
                            박서연
                        </td>

                        <td>
                            010-2222-3333
                        </td>

                        <td>
                            seoyeon@email.com
                        </td>

                        <td>
                            <span class="badge badge-dark">
                                일반
                            </span>
                        </td>

                        <td>
                            3회
                        </td>

                        <td>
                            2026.06.18
                        </td>

                        <td>
                            <span class="badge badge-blue">
                                REVISIT
                            </span>
                        </td>

                        <td>
                            조용한 객실 선호
                        </td>

                        <td>

                            <a
                                href="/admin/customers/2"
                                class="table-detail-link"
                            >
                                상세
                            </a>

                        </td>

                    </tr>


                    <tr>

                        <td>
                            이준혁
                        </td>

                        <td>
                            010-4444-5555
                        </td>

                        <td>
                            junhyuk@email.com
                        </td>

                        <td>
                            <span class="badge badge-dark">
                                일반
                            </span>
                        </td>

                        <td>
                            1회
                        </td>

                        <td>
                            2026.08.11
                        </td>

                        <td>
                            <span class="badge badge-blue">
                                FIRST
                            </span>
                        </td>

                        <td>
                            -
                        </td>

                        <td>

                            <a
                                href="/admin/customers/3"
                                class="table-detail-link"
                            >
                                상세
                            </a>

                        </td>

                    </tr>

                    </tbody>

                </table>

            </div>


            <div class="admin-table-bottom">

                <span>
                    전체 482명 중 1-10 표시
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