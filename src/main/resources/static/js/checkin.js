document.addEventListener("DOMContentLoaded", function () {
	const rows = document.querySelectorAll(".checkin-row, .past-checkin-row");
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
	const checkoutRows = document.querySelectorAll(".checkout-row, .past-checkout-row");
	const roomAssignmentSection = document.querySelector("#roomAssignmentSection");
	const keySection = document.querySelector("#keySection");
	const checkoutBtn = document.querySelector("#checkoutBtn");
	
	let selectedReservationId = null;
	let selectedGuestId = null;
	let selectedRoomId = null;
	let selectedCheckinId = null;
	
	const PAGE_SIZE = 5;

	function createPagination(rowSelector, paginationSelector) {
		const allRows = Array.from(document.querySelectorAll(rowSelector));
		const pagination = document.querySelector(paginationSelector);
		let filteredRows = [...allRows];
		let currentPage = 1;

		function showPage(page) {
			const totalPages = Math.ceil(filteredRows.length / PAGE_SIZE);

			if (totalPages === 0) {
				currentPage = 1;
			} else if (page > totalPages) {
				currentPage = totalPages;
			} else {
				currentPage = page;
			}

			allRows.forEach(function (row) {
				row.style.display = "none";
			});

			const start = (currentPage - 1) * PAGE_SIZE;
			const end = start + PAGE_SIZE;

			filteredRows.slice(start, end).forEach(function (row) {
				row.style.display = "";
			});

			renderPagination();
		}

		function renderPagination() {
			pagination.innerHTML = "";

			const totalPages = Math.ceil(filteredRows.length / PAGE_SIZE);

			if (totalPages <= 1) {
				return;
			}

			const prevButton = document.createElement("button");
			prevButton.type = "button";
			prevButton.textContent = "<";
			prevButton.disabled = currentPage === 1;

			prevButton.addEventListener("click", function () {
				if (currentPage > 1) {
					showPage(currentPage - 1);
				}
			});

			pagination.appendChild(prevButton);

			for (let page = 1; page <= totalPages; page++) {
				const pageButton = document.createElement("button");
				pageButton.type = "button";
				pageButton.textContent = page;

				if (page === currentPage) {
					pageButton.classList.add("active");
				}

				pageButton.addEventListener("click", function () {
					showPage(page);
				});

				pagination.appendChild(pageButton);
			}

			const nextButton = document.createElement("button");
			nextButton.type = "button";
			nextButton.textContent = ">";
			nextButton.disabled = currentPage === totalPages;

			nextButton.addEventListener("click", function () {
				if (currentPage < totalPages) {
					showPage(currentPage + 1);
				}
			});

			pagination.appendChild(nextButton);
		}

		function search(keyword) {
			const normalizedKeyword = keyword.trim().toLowerCase();

			if (normalizedKeyword === "") {
				filteredRows = [...allRows];
			} else {
				filteredRows = allRows.filter(function (row) {
					return row.textContent.toLowerCase().includes(normalizedKeyword);
				});
			}

			showPage(1);
		}

		function reset() {
			filteredRows = [...allRows];
			showPage(1);
		}

		showPage(1);

		return {
			search: search,
			reset: reset
		};
	}
	const checkinPagination = createPagination(".checkin-row", "#checkinPagination");
	const pastCheckinPagination = createPagination(".past-checkin-row", "#pastCheckinPagination");
	const checkoutPagination = createPagination(".checkout-row", "#checkoutPagination");
	const pastCheckoutPagination = createPagination(".past-checkout-row", "#pastCheckoutPagination");
	
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
		checkinPagination.reset();
		pastCheckinPagination.reset();
		checkoutPagination.reset();
		pastCheckoutPagination.reset();
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

		checkoutRows.forEach(function (row) {
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

	checkinSearchBtn.addEventListener("click", function () {
		const keyword = checkinSearchInput.value;

		if (checkinTab.classList.contains("active")) {
			checkinPagination.search(keyword);
			pastCheckinPagination.search(keyword);
		} else {
			checkoutPagination.search(keyword);
			pastCheckoutPagination.search(keyword);
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