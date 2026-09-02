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

    if (!checkinInput || !basePriceInput || !adultSelect) return;

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

// payment.jsp 전용 - 결제수단 토글 + 요청사항 왼쪽↔오른쪽 동기화
document.addEventListener('DOMContentLoaded', function () {

    var paymentForm = document.querySelector('#paymentForm');
    if (!paymentForm) return;
	// 연락처 자동 하이픈: 010-1234-5678
	var phoneInput = document.querySelector('#phone');
	if (phoneInput) {
	    phoneInput.addEventListener('input', function () {
	        var digits = this.value.replace(/[^0-9]/g, '').slice(0, 11);
	        var formatted = digits;
	        if (digits.length > 3 && digits.length <= 7) {
	            formatted = digits.slice(0, 3) + '-' + digits.slice(3);
	        } else if (digits.length > 7) {
	            formatted = digits.slice(0, 3) + '-' + digits.slice(3, 7) + '-' + digits.slice(7);
	        }
	        this.value = formatted;
	    });
	}

	// 카드번호 자동 하이픈: 0000 - 0000 - 0000 - 0000
	var cardNumberInput = document.querySelector('#cardNumber');
	if (cardNumberInput) {
	    cardNumberInput.addEventListener('input', function () {
	        var digits = this.value.replace(/[^0-9]/g, '').slice(0, 16);
	        var groups = digits.match(/.{1,4}/g) || [];
	        this.value = groups.join(' - ');
	    });
	}

	// 유효기간 자동 슬래시: MM / YY
	var expiryInput = document.querySelector('#expiry');
	if (expiryInput) {
	    expiryInput.addEventListener('input', function () {
	        var digits = this.value.replace(/[^0-9]/g, '').slice(0, 4);
	        var formatted = digits;
	        if (digits.length > 2) {
	            formatted = digits.slice(0, 2) + ' / ' + digits.slice(2);
	        }
	        this.value = formatted;
	    });
	}
    // 결제수단 탭 클릭 시 active 토글 + 카드/계좌 필드 전환
    document.querySelectorAll('.payment-method').forEach(function (label) {
        label.addEventListener('click', function () {
            document.querySelectorAll('.payment-method').forEach(function (l) {
                l.classList.remove('active');
            });
            this.classList.add('active');

            var radio = this.querySelector('input[type="radio"]');
            if (radio) radio.checked = true;

            var method = this.dataset.method;
            document.querySelector('#cardFields').style.display = (method === 'CARD') ? 'block' : 'none';
            document.querySelector('#accountFields').style.display = (method === 'ACCOUNT') ? 'block' : 'none';
        });
    });

    // 왼쪽 카드의 요청사항 입력값을, 폼 안 hidden input에 실시간 복사
    var requestDisplay = document.querySelector('#requestDisplay');
    var requestHidden = document.querySelector('#requestHidden');
    if (requestDisplay && requestHidden) {
        requestDisplay.addEventListener('input', function () {
            requestHidden.value = this.value;
        });
    }

});

// 관리자 예약 목록 - 10개씩 클라이언트에서 나눠 보여주기
document.addEventListener('DOMContentLoaded', function () {
    var rows = document.querySelectorAll('.reservation-row');
    var pagination = document.querySelector('#pagination');
    if (!pagination || rows.length === 0) return;

    var pageSize = 10;
    var totalPages = Math.ceil(rows.length / pageSize);

    function showPage(page) {
        rows.forEach(function (row, index) {
            var rowPage = Math.floor(index / pageSize) + 1;
            row.style.display = (rowPage === page) ? '' : 'none';
        });
        pagination.querySelectorAll('a').forEach(function (link) {
            link.classList.toggle('active', Number(link.dataset.page) === page);
        });
    }

    for (var i = 1; i <= totalPages; i++) {
        var link = document.createElement('a');
        link.href = '#';
        link.textContent = i;
        link.dataset.page = i;
        link.addEventListener('click', function (e) {
            e.preventDefault();
            showPage(Number(this.dataset.page));
        });
        pagination.appendChild(link);
    }

    showPage(1);
});
// rooms.jsp 전용 - 체크인 바뀌면 체크아웃 무조건 +1일로 갱신
document.addEventListener('DOMContentLoaded', function () {
    var searchForm = document.querySelector('.room-search-bar');
    if (!searchForm) return;   // rooms.jsp가 아니면 여기서 끝

    var checkinInput = document.getElementById('checkinDate');
    var checkoutInput = document.getElementById('checkoutDate');
    if (!checkinInput || !checkoutInput) return;

    function updateCheckout() {
        if (!checkinInput.value) return;

        var checkin = new Date(checkinInput.value);
        checkin.setDate(checkin.getDate() + 1);

        var yyyy = checkin.getFullYear();
        var mm = String(checkin.getMonth() + 1).padStart(2, '0');
        var dd = String(checkin.getDate()).padStart(2, '0');
        var nextDayStr = yyyy + '-' + mm + '-' + dd;

        checkoutInput.min = nextDayStr;
        checkoutInput.value = nextDayStr;
    }

    checkinInput.addEventListener('change', updateCheckout);
});
