<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>The OneFive - 하우스키핑</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/housekeeping.css">
</head>
<body>

<div class="admin-layout">
    <jsp:include page="/WEB-INF/views/common/adminSidebar.jsp"/>

    <main class="admin-content">
        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>

        <section class="admin-main">

            <div class="housekeeping-layout">
            <div class="housekeeping-main-col">

            <%-- 상태별(청소대기/청소중/점검완료) 건수 카드. 좌측 컬러바 + 우측 아이콘박스는 nth-child로 색상 자동 적용 --%>
            <section class="housekeeping-summary-grid">
                <c:forEach var="sc" items="${statusCounts}">
                    <div class="housekeeping-summary-card">
                        <span class="summary-bar"></span>
                        <div class="summary-text">
                            <span>${sc.status}</span>
                            <strong>${sc.count}개 객실</strong>
                        </div>
                        <div class="summary-icon">
                            <svg viewBox="0 0 24 24">
                                <path d="M6 3v6l-3 9a2 2 0 0 0 2 3h14a2 2 0 0 0 2-3l-3-9V3"/>
                                <path d="M6 3h12"/>
                                <path d="M10 12h4"/>
                            </svg>
                        </div>
                    </div>
                </c:forEach>
            </section>

            <%-- 층/상태 필터 폼 (GET 방식, 선택값은 selectedFloor/selectedStatus로 유지) --%>
            <form method="get" action="${pageContext.request.contextPath}/admin/housekeeping"
                  class="filter-bar housekeeping-filter">

                <label class="filter-label">배정 층:</label>
                <select name="floor" class="form-control housekeeping-filter-select">
                    <option value="">전체</option>
                    <c:forEach begin="1" end="10" var="f">
                        <option value="${f}" ${selectedFloor == f ? 'selected' : ''}>${f}층</option>
                    </c:forEach>
                </select>

                <label class="filter-label">상태:</label>
                <select name="status" class="form-control housekeeping-filter-select">
                    <option value="">전체</option>
                    <option value="청소대기" ${selectedStatus == '청소대기' ? 'selected' : ''}>청소 대기</option>
                    <option value="청소중" ${selectedStatus == '청소중' ? 'selected' : ''}>청소 중</option>
                    <option value="점검완료" ${selectedStatus == '점검완료' ? 'selected' : ''}>점검 완료</option>
                </select>

                <button type="submit" class="btn btn-dark">조회</button>
            </form>

            <div class="table-wrapper">
                <table class="common-table housekeeping-table">
                    <thead>
                    <tr>
                        <th>객실</th>
                        <th>층</th>
                        <th>객실 타입</th>
                        <th>상태</th>
                        <th>담당자</th>
                        <th>비고 / 전달사항</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%-- 행 클릭 시 상세패널 오픈 + 선택된 행 하이라이트 --%>
                    <c:forEach var="hk" items="${list}">
                        <tr class="hk-row" data-id="${hk.id}" onclick="openDetail(${hk.id}, this)">
                            <td>${hk.roomNum}</td>
                            <td>${hk.floor}층</td>
                            <td>${hk.typeName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${hk.status == '청소대기'}">
                                        <span class="badge badge-waiting">${hk.status}</span>
                                    </c:when>
                                    <c:when test="${hk.status == '청소중'}">
                                        <span class="badge badge-progress">${hk.status}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-done">${hk.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${hk.employeeName != null ? hk.employeeName : '미배정'}</td>
                            <td>${hk.note}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            </div>

            <%-- 우측 상세패널: 표 옆에 고정되어 행을 클릭할 때마다 내용만 갱신됨 --%>
            <aside class="housekeeping-management-panel" id="managementPanel">

                <div class="housekeeping-panel-header">
                    <h2>하우스키핑 상세</h2>
                    <p>객실 상태를 확인하고 업무를 처리합니다.</p>
                </div>

                <div class="housekeeping-info-list">
                    <div class="info-row"><span>객실 번호</span><strong id="p-roomNum"></strong></div>
                    <div class="info-row"><span>객실 타입</span><strong id="p-typeName"></strong></div>
                    <div class="info-row"><span>층</span><strong id="p-floor"></strong></div>
                </div>

                <div class="housekeeping-current-status">
                    <span class="form-label">현재 상태</span>
                    <span class="badge" id="p-status"></span>
                </div>

                <%-- 진행 단계 스텝바 (3단계). 현재 위치는 JS가 STATUS+COMPLETED_AT 조합으로 계산 --%>
                <div class="housekeeping-status-flow" id="statusFlow">
                    <div class="status-flow-item" data-step="청소대기"><span>1</span><strong>청소 대기</strong></div>
                    <div class="status-flow-line"></div>
                    <div class="status-flow-item" data-step="청소중"><span>2</span><strong>청소 중</strong></div>
                    <div class="status-flow-line"></div>
                    <div class="status-flow-item" data-step="점검완료"><span>3</span><strong>점검 완료</strong></div>
                </div>

                <%-- 담당자 드롭다운: 페이지 로드 시 loadEmployees()가 옵션을 채움 --%>
                <label class="housekeeping-assign-label">담당자</label>
                <div class="housekeeping-assign-row">
                    <select class="form-control" id="p-employeeSelect"></select>
                    <button type="button" id="p-assignBtn" onclick="changeEmployee()">담당자 배정</button>
                </div>

                <div class="housekeeping-note">
                    <label class="form-label">비고/전달사항</label>
                    <div class="housekeeping-note-row">
                        <input type="text" class="form-control" id="p-note">
                        <button type="button" class="btn btn-outline" onclick="saveNote()">저장</button>
                    </div>
                </div>

                <div class="housekeeping-action-row">
                    <button type="button" class="btn btn-primary" id="p-actionBtn"></button>
                </div>
            </aside>
            </div>

        </section>
    </main>
</div>

<script>
// 공통 API 호출 함수: fetch로 요청 보내고 JSON 응답을 그대로 반환
var ctx = '${pageContext.request.contextPath}';
var currentId = null;   // 현재 상세패널에 열려있는 하우스키핑 id

function callApi(url, method, body) {
    method = method || 'POST';
    var options = { method: method };
    if (body) {
        options.headers = { 'Content-Type': 'application/json' };
        options.body = JSON.stringify(body);
    }
    return fetch(url, options).then(function(res) { return res.json(); });
}

// 행 클릭 시 상세정보 조회 + 상세패널/스텝바/액션버튼 갱신
function openDetail(id, rowEl) {
    currentId = id;

    document.querySelectorAll('.hk-row').forEach(function(tr) {
        tr.classList.remove('selected');
    });
    if (rowEl) rowEl.classList.add('selected');

    callApi(ctx + '/api/housekeeping/detail?id=' + id, 'GET').then(function(result) {
        if (!result.success) { alert(result.message); return; }
        var hk = result.data;

        document.getElementById('managementPanel').style.display = 'block';
        document.getElementById('p-status').textContent = hk.status;
        document.getElementById('p-status').className = 'badge ' +
            (hk.status === '청소대기' ? 'badge-waiting' : hk.status === '청소중' ? 'badge-progress' : 'badge-done');
        document.getElementById('p-roomNum').textContent = hk.roomNum + '호';
        document.getElementById('p-typeName').textContent = hk.typeName;
        document.getElementById('p-floor').textContent = hk.floor + '층';
        document.getElementById('p-note').value = hk.note || '';

        // 담당자 드롭다운을 현재 담당자로 세팅
        var select = document.getElementById('p-employeeSelect');
        select.value = hk.employeeId || '';

        // STATUS 3단계만으로는 "청소 완료, 점검 대기"를 구분할 수 없으므로
        // COMPLETED_AT 유무를 함께 봐서 스텝바 진행 인덱스를 계산
        var steps = ['청소대기', '청소중', '점검완료'];
        var currentIndex;
        if (hk.status === '점검완료') {
            currentIndex = 3; // 전 단계 완료, 강조할 현재 단계 없음
        } else if (hk.status === '청소중' && hk.completedAt) {
            currentIndex = 2; // 청소는 끝남 → 점검완료가 현재 단계
        } else {
            currentIndex = steps.indexOf(hk.status);
        }
        document.querySelectorAll('.status-flow-item').forEach(function(el, idx) {
            el.classList.remove('completed', 'current');
            if (idx < currentIndex) el.classList.add('completed');
            if (idx === currentIndex) el.classList.add('current');
        });
        document.querySelectorAll('.status-flow-line').forEach(function(el, idx) {
            el.classList.toggle('active', idx < currentIndex);
        });

        // 상태별로 액션 버튼 텍스트/클릭 동작(다음 단계 API)을 다르게 설정
        var btn = document.getElementById('p-actionBtn');
        if (hk.status === '청소대기') {
            btn.textContent = '청소 시작'; btn.disabled = false;
            btn.onclick = function() { runAction('start'); };
        } else if (hk.status === '청소중' && !hk.completedAt) {
            btn.textContent = '청소 완료 처리'; btn.disabled = false;
            btn.onclick = function() { runAction('complete'); };
        } else if (hk.status === '청소중' && hk.completedAt) {
            btn.textContent = '점검 완료 처리'; btn.disabled = false;
            btn.onclick = function() { runAction('inspect'); };
        } else {
            btn.textContent = '처리 완료됨'; btn.disabled = true;
        }

        // 점검완료 건은 담당자 변경 불가
        var isInspected = (hk.status === '점검완료');
        select.disabled = isInspected;
        document.getElementById('p-assignBtn').disabled = isInspected;
    });
}

// 청소 시작/완료, 점검 완료 공통 처리
function runAction(step) {
    callApi(ctx + '/api/housekeeping/' + step, 'POST', { ids: [currentId] }).then(function(result) {
        alert(result.message);
        if (result.success) location.reload();
    });
}

// 담당자 드롭다운 옵션 채우기 (페이지 로드 시 1회 호출)
function loadEmployees() {
    return callApi(ctx + '/api/employees', 'GET').then(function(result) {
        if (!result.success) return;
        var select = document.getElementById('p-employeeSelect');
        select.innerHTML = '<option value="">미배정</option>';
        result.data.forEach(function(emp) {
            var opt = document.createElement('option');
            opt.value = emp.id;
            opt.textContent = emp.name;
            select.appendChild(opt);
        });
    });
}

// 담당자 드롭다운 준비가 끝난 뒤 첫 번째 행을 자동으로 선택해서 상세패널을 채움
loadEmployees().then(function() {
    var firstRow = document.querySelector('.hk-row');
    if (firstRow) {
        openDetail(Number(firstRow.getAttribute('data-id')), firstRow);
    }
});

// 담당자 배정: 드롭다운에서 고른 값을 그대로 서버에 전달
function changeEmployee() {
    var employeeId = document.getElementById('p-employeeSelect').value;
    if (!employeeId) { alert('배정할 담당자를 선택하세요.'); return; }
    callApi(ctx + '/api/housekeeping/assign', 'POST', { ids: [currentId], employeeId: Number(employeeId) })
        .then(function(result) { alert(result.message); if (result.success) location.reload(); });
}

// 비고 저장
function saveNote() {
    var note = document.getElementById('p-note').value;
    callApi(ctx + '/api/housekeeping/note', 'POST', { id: currentId, note: note })
        .then(function(result) { alert(result.message); });
}

// innerHTML로 직접 삽입하기 전 사용자 입력값을 이스케이프해서 XSS 방지
function escapeHtml(str) {
    var div = document.createElement('div');
    div.textContent = (str == null) ? '' : str;
    return div.innerHTML;
}

// 표/상세패널의 상태 배지 색 분류 로직
function badgeClass(status) {
    if (status === '청소대기') return 'badge-waiting';
    if (status === '청소중') return 'badge-progress';
    return 'badge-done';
}

// 폴링용 표 렌더링: tbody만 다시 그리고, 선택돼 있던 행의 하이라이트는 유지
function renderTable(list) {
    var tbody = document.querySelector('.housekeeping-table tbody');
    var selectedId = currentId;

    tbody.innerHTML = list.map(function(hk) {
        return '<tr class="hk-row" data-id="' + hk.id + '" onclick="openDetail(' + hk.id + ', this)">' +
            '<td>' + hk.roomNum + '</td>' +
            '<td>' + hk.floor + '층</td>' +
            '<td>' + escapeHtml(hk.typeName) + '</td>' +
            '<td><span class="badge ' + badgeClass(hk.status) + '">' + hk.status + '</span></td>' +
            '<td>' + escapeHtml(hk.employeeName || '미배정') + '</td>' +
            '<td>' + escapeHtml(hk.note || '') + '</td>' +
        '</tr>';
    }).join('');

    if (selectedId) {
        var row = tbody.querySelector('tr[data-id="' + selectedId + '"]');
        if (row) row.classList.add('selected');
    }
}

// 폴링용 카드 렌더링: statusCounts는 항상 고정 순서로 내려오므로 인덱스로 매칭
function renderSummary(counts) {
    var cards = document.querySelectorAll('.housekeeping-summary-card strong');
    counts.forEach(function(sc, i) {
        if (cards[i]) cards[i].textContent = sc.count + '개 객실';
    });
}

// 현재 필터 조건으로 목록/카드를 다시 조회해서 화면 일부만 갱신
function pollList() {
    var floor = document.querySelector('select[name="floor"]').value;
    var status = document.querySelector('select[name="status"]').value;
    var qs = [];
    if (floor) qs.push('floor=' + encodeURIComponent(floor));
    if (status) qs.push('status=' + encodeURIComponent(status));
    var url = ctx + '/api/housekeeping/list' + (qs.length ? '?' + qs.join('&') : '');

    callApi(url, 'GET').then(function(result) {
        if (!result.success) return; // 실패 시 알림 없이 다음 주기에 재시도
        renderTable(result.data.list);
        renderSummary(result.data.statusCounts);
    });
}

// 15초마다 자동 갱신
setInterval(pollList, 15000);
</script>

</body>
</html>
