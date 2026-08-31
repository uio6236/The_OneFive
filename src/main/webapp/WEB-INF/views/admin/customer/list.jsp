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


            <div class="admin-page-action-row">

                <div>

                    <h2>
                        고객 및 투숙객 관리
                    </h2>

                    <p>
                        고객 기본정보와 방문 이력 및 특이사항을 관리합니다.
                    </p>

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
						            <a href="/admin/customers/${c.id}" class="table-detail-link">수정</a>
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

        </section>

    </main>

</div>

</body>
</html>