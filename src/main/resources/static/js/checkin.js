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
	const checkinTab = document.querySelector("#checkinTab");
	const checkoutTab = document.querySelector("#checkoutTab");
	const checkinSearchInput = document.querySelector("#checkinSearchInput");
	const checkinSearchBtn = document.querySelector("#checkinSearchBtn");
	const checkinListArea = document.querySelector("#checkinListArea");
	const checkoutListArea = document.querySelector("#checkoutListArea");
	const listTitle = document.querySelector("#listTitle");
	const listCount = document.querySelector("#listCount");
	const checkoutRows = document.querySelectorAll(".checkout-row");
	const roomAssignmentSection = document.querySelector("#roomAssignmentSection");
	const keySection = document.querySelector("#keySection");
	const checkoutBtn = document.querySelector("#checkoutBtn");
	
	let selectedReservationId = null;
	let selectedGuestId = null;
	let selectedRoomId = null;
	let selectedCheckinId = null;
	
	checkinTab.addEventListener("click", function () {
		checkinTab.classList.add("active");
		checkoutTab.classList.remove("active");

		checkinListArea.style.display = "block";
		checkoutListArea.style.display = "none";

		listTitle.textContent = "체크인 예정 고객";
		listCount.textContent = "총 " + document.querySelectorAll(".checkin-row").length + "건";
		
		roomAssignmentSection.style.display = "block";
		keySection.style.display = "block";
		checkinBtn.style.display = "block";
		checkoutBtn.style.display = "none";
		checkinSearchInput.value = "";
		resetSearchRows();
		resetDetailPanel();
	});

	checkoutTab.addEventListener("click", function () {
		checkoutTab.classList.add("active");
		checkinTab.classList.remove("active");

		checkoutListArea.style.display = "block";
		checkinListArea.style.display = "none";

		listTitle.textContent = "체크아웃 예정 고객";
		listCount.textContent = "총 " + document.querySelectorAll(".checkout-row").length + "건";
		
		roomAssignmentSection.style.display = "none";
		keySection.style.display = "none";
		checkinBtn.style.display = "none";
		checkoutBtn.style.display = "block";
		checkinSearchInput.value = "";
		resetSearchRows();
		resetDetailPanel();
	});
	
	function resetSearchRows() {
		rows.forEach(function (row) {
			row.style.display = "";
		});

		checkoutRows.forEach(function (row) {
			row.style.display = "";
		});
	}
	
	function resetDetailPanel() {
		detailGuestName.textContent = "고객을 선택하세요";
		detailReservationCode.textContent = "예약번호";
		detailRoomType.textContent = "-";
		detailStayPeriod.textContent = "-";
		detailGuestCount.textContent = "-";
		detailMemo.textContent = "-";

		availableRoomList.innerHTML = "";

		selectedReservationId = null;
		selectedGuestId = null;
		selectedRoomId = null;
		selectedCheckinId = null;
		resetKeySelection();

		rows.forEach(function (row) {
			row.classList.remove("active");
		});

		document.querySelectorAll(".checkout-row").forEach(function (row) {
			row.classList.remove("active");
		});
	}
	
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
	checkoutRows.forEach(function (row) {
		row.addEventListener("click", async function () {
			const reservationId = row.dataset.reservationId;
			const checkinId = row.dataset.checkinId;

			try {
				const response = await fetch("/admin/checkin/detail?reservationId=" + reservationId);

				if (!response.ok) {
					alert("체크아웃 상세 정보를 불러오지 못했습니다.");
					return;
				}

				const checkout = await response.json();

				selectedReservationId = checkout.reservationId;
				selectedGuestId = checkout.guestId;
				selectedRoomId = checkout.roomId;
				selectedCheckinId = checkinId;

				checkoutRows.forEach(function (item) {
					item.classList.remove("active");
				});
				row.classList.add("active");

				detailGuestName.textContent = checkout.guestName;
				detailReservationCode.textContent = "예약번호 " + checkout.reservationCode;
				detailRoomType.textContent = checkout.roomTypeName;
				detailGuestCount.textContent = checkout.guestCount + "명";
				detailMemo.textContent = checkout.memo ? checkout.memo : "-";

				const checkinDate = formatDate(checkout.checkinTime);
				const checkoutDate = formatDate(checkout.checkoutTime);
				detailStayPeriod.textContent = checkinDate + " ~ " + checkoutDate;
			} catch (error) {
				console.error(error);
				alert("체크아웃 상세 정보를 불러오는 중 오류가 발생했습니다.");
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
	
	checkoutBtn.addEventListener("click", async function () {
		if (selectedCheckinId === null) {
			alert("체크아웃할 고객을 선택해주세요.");
			return;
		}

		if (selectedRoomId === null) {
			alert("객실 정보를 확인할 수 없습니다.");
			return;
		}

		const data = new URLSearchParams();
		data.append("id", selectedCheckinId);
		data.append("roomId", selectedRoomId);

		try {
			const response = await fetch("/admin/checkin/checkout", {
				method: "POST",
				headers: {
					"Content-Type": "application/x-www-form-urlencoded"
				},
				body: data
			});

			if (!response.ok) {
				alert("체크아웃 처리에 실패했습니다.");
				return;
			}

			alert("체크아웃이 완료되었습니다.");
			location.href = "/admin/checkin";
		} catch (error) {
			console.error(error);
			alert("체크아웃 처리 중 오류가 발생했습니다.");
		}
	});
	function searchRows(targetRows, keyword) {
		targetRows.forEach(function (row) {
			const roomNum = row.children[0].textContent.trim();
			const guestName = row.children[1].textContent.trim();

			if (roomNum.includes(keyword) || guestName.includes(keyword)) {
				row.style.display = "";
			} else {
				row.style.display = "none";
			}
		});
	}
	checkinSearchBtn.addEventListener("click", function () {
		const keyword = checkinSearchInput.value.trim();

		if (checkinTab.classList.contains("active")) {
			searchRows(rows, keyword);
		} else {
			searchRows(checkoutRows, keyword);
		}
	});
	checkinSearchInput.addEventListener("keydown", function (event) {
		if (event.key === "Enter") {
			checkinSearchBtn.click();
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
	availableRoomList.addEventListener("wheel", function (event) {
		if (event.deltaY === 0) {
			return;
		}

		event.preventDefault();
		availableRoomList.scrollLeft += event.deltaY;
	}, { passive: false });
});