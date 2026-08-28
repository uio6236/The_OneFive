document.addEventListener("DOMContentLoaded", function () {
	const rows = document.querySelectorAll(".checkin-row");
	const detailGuestName = document.querySelector("#detailGuestName");
	const detailReservationCode = document.querySelector("#detailReservationCode");
	const detailRoomType = document.querySelector("#detailRoomType");
	const detailStayPeriod = document.querySelector("#detailStayPeriod");
	const detailGuestCount = document.querySelector("#detailGuestCount");
	const detailMemo = document.querySelector("#detailMemo");
	const availableRoomList = document.querySelector("#availableRoomList");
	const keyTypeCards = document.querySelectorAll(".key-type-card");
	const checkinBtn = document.querySelector("#checkinBtn");

	let selectedReservationId = null;
	let selectedGuestId = null;
	let selectedRoomId = null;

	function resetKeySelection() {
		keyTypeCards.forEach(function (card) {
			card.classList.remove("active");

			const radio = card.querySelector('input[type="radio"]');
			if (radio) {
				radio.checked = false;
			}
		});
	}

	keyTypeCards.forEach(function (card) {
		card.addEventListener("click", function () {
			keyTypeCards.forEach(function (item) {
				item.classList.remove("active");
			});
			card.classList.add("active");
			const radio = card.querySelector('input[type="radio"]');
			if (radio) {
				radio.checked = true;
			}
		});
	});

	rows.forEach(function (row) {
		row.addEventListener("click", async function () {
			const reservationId = row.dataset.reservationId;

			resetKeySelection();
			selectedReservationId = null;
			selectedGuestId = null;
			selectedRoomId = null;

			try {
				const response = await fetch("/admin/checkin/detail?reservationId=" + reservationId);

				if (!response.ok) {
					alert("체크인 상세 정보를 불러오지 못했습니다.");
					return;
				}

				const checkin = await response.json();

				selectedReservationId = checkin.reservationId;
				selectedGuestId = checkin.guestId;

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

				const roomResponse = await fetch(
					"/admin/checkin/available-rooms?roomTypeId=" + checkin.roomTypeId
				);

				if (!roomResponse.ok) {
					alert("이용 가능한 객실 정보를 불러오지 못했습니다.");
					return;
				}

				const rooms = await roomResponse.json();

				availableRoomList.innerHTML = "";

				if (rooms.length === 0) {
					availableRoomList.innerHTML = "<p>현재 배정 가능한 객실이 없습니다.</p>";
					return;
				}

				rooms.forEach(function (room) {
					const roomButton = document.createElement("button");

					roomButton.type = "button";
					roomButton.className = "available-room-item";
					roomButton.textContent = room.roomNum + "호";

					roomButton.addEventListener("click", function () {
						const roomButtons = document.querySelectorAll(".available-room-item");

						roomButtons.forEach(function (button) {
							button.classList.remove("active");
						});

						roomButton.classList.add("active");
						selectedRoomId = room.id;
					});

					availableRoomList.appendChild(roomButton);
				});

			} catch (error) {
				console.error(error);
				alert("체크인 상세 정보를 불러오는 중 오류가 발생했습니다.");
			}
		});
	});

	checkinBtn.addEventListener("click", async function () {
		if (selectedReservationId === null) {
			alert("체크인할 고객을 선택해주세요.");
			return;
		}
		if (selectedRoomId === null) {
			alert("배정할 객실을 선택해주세요.");
			return;
		}
		const selectedKey = document.querySelector('input[name="keyType"]:checked');
		if (!selectedKey) {
			alert("키 발급 유형을 선택해주세요.");
			return;
		}

		const keyType = selectedKey.value;
		const data = new URLSearchParams();
		data.append("reservationId", selectedReservationId);
		data.append("guestId", selectedGuestId);
		data.append("roomId", selectedRoomId);
		data.append("keyType", keyType);
		try {
			const response = await fetch("/admin/checkin", {
				method: "POST",
				headers: {"Content-Type": "application/x-www-form-urlencoded"},
				body: data
			});
			if (!response.ok) {
				alert("체크인 처리에 실패했습니다.");
				return;
			}

			alert("체크인이 완료되었습니다.");
			location.href = "/admin/checkin";
		} catch (error) {
			console.error(error);
			alert("체크인 처리 중 오류가 발생했습니다.");
		}
	});

	function formatDate(dateTime) {
		if (!dateTime) {
			return "-";
		}

		const date = new Date(dateTime);
		const year = date.getFullYear();
		const month = String(date.getMonth() + 1).padStart(2, "0");
		const day = String(date.getDate()).padStart(2, "0");

		return year + "." + month + "." + day;
	}
});