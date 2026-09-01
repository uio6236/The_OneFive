<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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


            <!-- 1. 가로 배치(display: flex)를 적용할 전체 감싸는 태그 시작 -->
            <div class="admin-customer-content">

                <!-- 2. 좌측 목록 영역 (남은 너비를 채움) -->
                <div class="admin-customer-list">

                    <div class="admin-page-action-row">
                        <div>
                            <h2>고객 및 투숙객 관리</h2>
                            <p>고객 기본정보와 방문 이력 및 특이사항을 관리합니다.</p>
                        </div>
                    </div>
                    
                    <form method="get" action="/admin/customers" class="filter-bar admin-customer-filter">
                        <div class="search-box">
                            <input
                                type="text"
                                name="keyword"
                                class="form-control"
                                value="${search.keyword}"
                                placeholder="고객명, 연락처, 이메일 검색"
                            >
                        </div>

                        <div>멤버십</div>

                        <select name="membershipGrade" class="form-control customer-filter-select">
                            <option value="전체" ${search.membershipGrade == '전체' ? 'selected' : ''}>전체</option>
                            <option value="NORMAL" ${search.membershipGrade == 'NORMAL' ? 'selected' : ''}>NORMAL</option>
                            <option value="VIP" ${search.membershipGrade == 'VIP' ? 'selected' : ''}>VIP</option>
                        </select>

                        <button type="submit" class="btn btn-dark">검색</button>
                    </form>

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
                                <th>메모</th>
                                <th></th>
                            </tr>
                            </thead>

			
			<form method="get" action="/admin/customers" class="filter-bar admin-customer-filter">


                            <tbody>
                            <c:forEach items="${customerList}" var="c">
                                <tr>
                                    <td>${c.name}</td>
                                    <td>${c.phone}</td>
                                    <td>${c.email}</td>
                                    <td>
                                        <span class="badge ${c.membershipGrade == 'VIP' ? 'badge-blue' : 'badge-dark'}">
                                            ${c.membershipGrade}
                                        </span>
                                    </td>
                                    <td>${c.totalVisitCount}회</td>
                                    <td>${c.memo}</td>
                                    <td>
                                        <button
                                            type="button"
                                            class="text-link customer-edit-btn"
                                            data-id="${c.id}">
                                            수정
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div><br>

                    <div class="admin-table-bottom">
                        <div class="pagination">
                            <c:if test="${search.page > 1}">
                                <a href="/admin/customers?keyword=${search.keyword}&membershipGrade=${search.membershipGrade}&page=${search.page - 1}">‹</a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="p">
                                <a href="/admin/customers?keyword=${search.keyword}&membershipGrade=${search.membershipGrade}&page=${p}"
                                   class="${p == search.page ? 'active' : ''}">
                                    ${p}
                                </a>
                            </c:forEach>

                            <c:if test="${search.page < totalPages}">
                                <a href="/admin/customers?keyword=${search.keyword}&membershipGrade=${search.membershipGrade}&page=${search.page + 1}">›</a>
                            </c:if>
                        </div>
                    </div>

                </div> <!-- /.admin-customer-list 끝 -->

                <!-- 3. 우측 고정 카드 패널 -->
                <aside class="customer-detail-panel" id="DetailPanel">

                    <h3>고객 정보</h3>

                    <p>선택한 고객의 정보를 확인하고 수정하세요.</p>

                    <!-- 고객을 선택하지 않았을 때 -->
                    <div id="customerDetailEmpty">
                        좌측 목록에서 고객을 선택하세요.
                    </div>

                    <!-- 고객 선택 후 -->
                    <div id="customerDetailContent" style="display:none;">
                        <div class="form-group">
                            <label>고객명</label>
                            <input
                                type="text"
                                id="detailName"
                                class="form-control"
                                readonly>
                        </div>

                        <div class="form-group">
                            <label>연락처</label>
                            <input
                                type="text"
                                id="detailPhone"
                                class="form-control"
                                readonly>
                        </div>

                        <div class="form-group">
                            <label>이메일</label>
                            <input
                                type="text"
                                id="detailEmail"
                                class="form-control"
                                readonly>
                        </div>

                        <!-- 메모 -->
                        <div class="form-group">
                            <label>메모</label>
                            <textarea
                                id="detailMemo"
                                class="form-control"
                                rows="5"></textarea>
                        </div>

                        <div class="admin-mypage-action-row">
                            <button
                                type="button"
                                id="customerSaveBtn"
                                class="btn btn-dark">
                                저장
                            </button>
                        </div>
                    </div>

                </aside>

            </div> <!-- /.admin-customer-content 끝 -->

        </section>

    </main>

</div>
<script src="/js/admin-customer.js"></script>
</body>
</html>