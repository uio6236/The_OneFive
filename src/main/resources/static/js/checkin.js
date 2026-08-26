document.addEventListener("DOMContentLoaded", function () {
	const rows = document.querySelectorAll(".checkin-row");
	const detailGuestName = document.querySelector("#detailGuestName");
	const detailReservationCode = document.querySelector("#detailReservationCode");
	const detailRoomType = document.querySelector("#detailRoomType");
	const detailStayPeriod = document.querySelector("#detailStayPeriod");
	const detailGuestCount = document.querySelector("#detailGuestCount");
	const detailMemo = document.querySelector("#detailMemo");

	rows.forEach(function (row) {
		row.addEventListener("click", async function () {
			const reservationId = row.dataset.reservationId;

			try {
				const response = await fetch("/admin/checkin/detail?reservationId=" + reservationId);

				if (!response.ok) {
					alert("체크인 상세 정보를 불러오지 못했습니다.");
					return;
				}

				const checkin = await response.json();

				rows.forEach(function (item) {
					item.classList.remove("active");
				});
				row.classList.add("active");

				detailGuestName.textContent = checkin.guestName;
				detailReservationCode.textContent = "예약번호 " + checkin.reservationCode;
				detailRoomType.textContent = checkin.roomTypeName;
				detailGuestCount.textContent = checkin.guestCount + "명";
				detailMemo.textContent = checkin.memo ? checkin.memo : "-";

				const checkinDate = formatDate(checkin.checkinTime);
				const checkoutDate = formatDate(checkin.checkoutTime);
				detailStayPeriod.textContent = checkinDate + " ~ " + checkoutDate;

			} catch (error) {
				console.error(error);
				alert("체크인 상세 정보를 불러오는 중 오류가 발생했습니다.");
			}
		});
	});

	function formatDate(dateTime) {
		if (!dateTime) return "-";

		const date = new Date(dateTime);
		const year = date.getFullYear();
		const month = String(date.getMonth() + 1).padStart(2, "0");
		const day = String(date.getDate()).padStart(2, "0");

		return year + "." + month + "." + day;
	}
});