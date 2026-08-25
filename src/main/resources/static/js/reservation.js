// 관리자 예약 목록 화면 - 우측 상세패널 동작

document.addEventListener('DOMContentLoaded', function () {

    var detailLinks = document.querySelectorAll('.js-detail-link');
    var detailEmpty = document.querySelector('#detailEmpty');
    var detailContent = document.querySelector('#detailContent');
    var cancelForm = document.querySelector('#cancelForm');

    var contextPath = document.body.dataset.contextPath || '';

    detailLinks.forEach(function (link) {
        link.addEventListener('click', function (e) {
            e.preventDefault();
            var id = this.dataset.id;
            loadDetail(id);
        });
    });

    function loadDetail(id) {
        fetch(contextPath + '/admin/reservations/' + id)
            .then(function (res) {
                return res.json();
            })
            .then(function (data) {
                fillDetail(data);
                cancelForm.action = contextPath + '/admin/reservations/' + id + '/cancel';

                detailEmpty.style.display = 'none';
                detailContent.style.display = 'block';
            })
            .catch(function (err) {
                console.error('예약 상세 조회 실패', err);
                alert('예약 정보를 불러오지 못했습니다.');
            });
    }

    function fillDetail(data) {
        document.querySelector('#detailCode').textContent = data.code;
        document.querySelector('#detailGuestName').textContent = data.guestName;
        document.querySelector('#detailRoom').textContent =
            (data.roomNum ? data.roomNum + '호' : '미배정') + ' (' + data.typeName + ')';
        document.querySelector('#detailCheckin').textContent = formatDate(data.checkin);
        document.querySelector('#detailCheckout').textContent = formatDate(data.checkout);
        document.querySelector('#detailGuestCount').textContent = data.guestCount + '명';
        document.querySelector('#detailStatus').textContent = data.status;
        document.querySelector('#detailTotalAmount').textContent =
            Number(data.totalAmount).toLocaleString() + '원';
    }

    // 서버에서 넘어온 날짜(ISO 문자열)를 yyyy.MM.dd로 간단 변환
    function formatDate(value) {
        if (!value) return '';
        var d = new Date(value);
        var yyyy = d.getFullYear();
        var mm = String(d.getMonth() + 1).padStart(2, '0');
        var dd = String(d.getDate()).padStart(2, '0');
        return yyyy + '.' + mm + '.' + dd;
    }

});