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
		document.querySelector('#detailTypeName').textContent = data.typeName;
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


// detail.jsp 전용 - 날짜 기본값/제한, 인원 바뀔 때마다 예상 금액 실시간 계산 + 예약 가능 여부 확인
document.addEventListener('DOMContentLoaded', function () {

    var checkinInput = document.querySelector('#checkinDate');
    var checkoutInput = document.querySelector('#checkoutDate');
    var adultSelect = document.querySelector('#adultCount');
    var childSelect = document.querySelector('#childCount');
    var basePriceInput = document.querySelector('#basePrice');
    var baseCapacityInput = document.querySelector('#baseCapacity');
    var maxCapacityInput = document.querySelector('#maxCapacity');

    if (!checkinInput) return;

    var ADULT_EXTRA_FEE = 10000;
    var CHILD_FEE = 5000;

    // 성인 인원에 따라, 유아가 고를 수 있는 최대치를 다시 계산해서 옵션을 새로 그림
    function updateChildOptions() {
        var maxCapacity = Number(maxCapacityInput.value);
        var adultCount = Number(adultSelect.value);
        var remaining = Math.max(0, maxCapacity - adultCount);

        var currentChildValue = Number(childSelect.value) || 0;

        childSelect.innerHTML = '';
        for (var i = 0; i <= remaining; i++) {
            var option = document.createElement('option');
            option.value = i;
            option.textContent = i + '명';
            childSelect.appendChild(option);
        }

        childSelect.value = Math.min(currentChildValue, remaining);
    }

    function formatDateForInput(date) {
        var yyyy = date.getFullYear();
        var mm = String(date.getMonth() + 1).padStart(2, '0');
        var dd = String(date.getDate()).padStart(2, '0');
        return yyyy + '-' + mm + '-' + dd;
    }

    function updateCheckoutMin() {
        if (!checkinInput.value) return;

        var checkin = new Date(checkinInput.value);
        var minCheckout = new Date(checkin);
        minCheckout.setDate(checkin.getDate() + 1);

        var minCheckoutStr = formatDateForInput(minCheckout);
        checkoutInput.min = minCheckoutStr;

        if (checkoutInput.value && checkoutInput.value < minCheckoutStr) {
            checkoutInput.value = minCheckoutStr;
        }
    }

    function setDefaultDates() {
        var today = new Date();
        var tomorrow = new Date();
        tomorrow.setDate(today.getDate() + 1);

        var todayStr = formatDateForInput(today);

        checkinInput.min = todayStr;

        if (!checkinInput.value) {
            checkinInput.value = todayStr;
        }
        if (!checkoutInput.value) {
            checkoutInput.value = formatDateForInput(tomorrow);
        }

        updateCheckoutMin();
    }

    function calculate() {
        var basePrice = Number(basePriceInput.value);
        var baseCapacity = Number(baseCapacityInput.value);

        var nights = 0;
        if (checkinInput.value && checkoutInput.value) {
            var checkin = new Date(checkinInput.value);
            var checkout = new Date(checkoutInput.value);
            if (checkout > checkin) {
                nights = Math.round((checkout - checkin) / (1000 * 60 * 60 * 24));
            }
        }

        var adultCount = Number(adultSelect.value);
        var childCount = Number(childSelect.value);

        var adultsWithinCapacity = Math.min(adultCount, baseCapacity);
        var extraAdults = adultCount - adultsWithinCapacity;

        var remainingCapacity = baseCapacity - adultsWithinCapacity;
        var childrenWithinCapacity = Math.min(childCount, remainingCapacity);
        var extraChildren = childCount - childrenWithinCapacity;

        var extraFeePerNight = (extraAdults * ADULT_EXTRA_FEE) + (extraChildren * CHILD_FEE);

        var baseAmount = basePrice * nights;
        var extraAmount = extraFeePerNight * nights;
        var totalAmount = baseAmount + extraAmount;

        document.querySelector('#baseAmountText').textContent = '₩' + baseAmount.toLocaleString();
        document.querySelector('#nightsText').textContent = nights + '박';
        document.querySelector('#extraAmountText').textContent = '₩' + extraAmount.toLocaleString();
        document.querySelector('#totalAmountText').textContent = '₩' + totalAmount.toLocaleString();
    }

    // 선택한 날짜 기준으로 실제 예약 가능한지 서버에 물어봄 (AJAX)
    function checkAvailability() {
        if (!checkinInput.value || !checkoutInput.value) return;

        var params = new URLSearchParams({
            roomTypeId: document.querySelector('input[name="roomTypeId"]').value,
            checkinDate: checkinInput.value,
            checkoutDate: checkoutInput.value
        });

        fetch('/customer/reservation/availability?' + params.toString())
            .then(function (res) {
                return res.json();
            })
            .then(function (count) {
                var badge = document.querySelector('#availabilityBadge');
                var submitBtn = document.querySelector('#submitBtn');

                if (count > 0) {
                    badge.textContent = '예약 가능';
                    badge.className = 'room-available';
                    submitBtn.disabled = false;
                } else {
                    badge.textContent = '예약 마감';
                    badge.className = 'room-soldout';
                    submitBtn.disabled = true;
                }
            })
            .catch(function (err) {
                console.error('재고 확인 실패', err);
            });
    }

    checkinInput.addEventListener('change', function () {
        updateCheckoutMin();
        calculate();
        checkAvailability();
    });
    checkoutInput.addEventListener('change', function () {
        calculate();
        checkAvailability();
    });

    adultSelect.addEventListener('change', function () {
        updateChildOptions();
        calculate();
    });
    childSelect.addEventListener('change', calculate);

    setDefaultDates();
    updateChildOptions();
    calculate();
    checkAvailability();

});