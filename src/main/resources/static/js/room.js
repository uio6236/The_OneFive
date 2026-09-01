document.addEventListener("DOMContentLoaded", function () {
	let selectedRoomId = null;
	const roomGrids = document.querySelectorAll(".admin-room-grid");

	roomGrids.forEach(function (grid) {
		grid.addEventListener("wheel", function (event) {
			if (event.deltaY === 0) {
				return;
			}

			event.preventDefault();
			grid.scrollLeft += event.deltaY;
		}, { passive: false });
	});
    const detailLinks = document.querySelectorAll(".room-detail-link");
    const emptyArea = document.querySelector("#roomDetailEmpty");
    const detailContent = document.querySelector("#roomDetailContent");
    detailLinks.forEach(function (link) {
        link.addEventListener("click", async function (event) {
                // a 태그의 기본 페이지 이동 방지
                event.preventDefault();
                const roomId = link.dataset.roomId;
				selectedRoomId = roomId;
                try {
                    const response = await fetch("/admin/room/" + roomId);
                    if (!response.ok) {
                        alert("객실 정보를 불러오지 못했습니다.");
                        return;
                    }
                    const room = await response.json();
                    // 상세 정보 입력
                    document.querySelector("#detailFloor").textContent = room.floor + "F";
                    document.querySelector("#detailRoomNum").textContent = room.roomNum + "호";
                    document.querySelector("#detailRoomType").textContent = room.typeName;
                    document.querySelector("#detailRoomNumber").textContent = room.roomNum + "호";
                    document.querySelector("#detailTypeName").textContent = room.typeName;
                    document.querySelector("#detailFloorInfo").textContent = room.floor + "층";
                    document.querySelector("#detailStatusText").textContent = room.status;
                    document.querySelector("#detailMemo").value = "";

                    // 상태 Badge
                    const status = document.querySelector("#detailStatus");
                    status.textContent = room.status;
                    status.className = "room-detail-status";
                    if (room.status === "이용가능") {
                        status.classList.add("available");
                    } else if (room.status === "투숙중") {
                        status.classList.add("occupied");
                    } else if (room.status === "청소중") {
                        status.classList.add("cleaning");
                    } else if (room.status === "점검중") {
                        status.classList.add("inspection");
                    }

                    // 상세 패널 표시
                    emptyArea.style.display = "none";
                    detailContent.classList.add("active");

                    // 선택된 객실 카드 표시
                    detailLinks.forEach(function (item) {
                            item.closest(".admin-room-card")?.classList.remove("selected-room");
                        }
                    );
                    link.closest(".admin-room-card")?.classList.add("selected-room");
                } catch (error) {
                    console.error(error);
                    alert("객실 정보를 불러오는 중 오류가 발생했습니다.");
                }
            }
        );
    });
	const maintenanceRequestBtn =
		document.querySelector("#maintenanceRequestBtn");

	maintenanceRequestBtn.addEventListener("click", async function () {
		if (!selectedRoomId) {
			alert("객실을 먼저 선택해주세요.");
			return;
		}

		const note = document.querySelector("#detailMemo").value.trim();

		if (note === "") {
			alert("정비 요청 내용을 입력해주세요.");
			return;
		}

		if (!confirm("객실 정비를 요청하시겠습니까?")) {
			return;
		}

		try {
			const params = new URLSearchParams();
			params.append("note", note);

			const response = await fetch(
				"/admin/room/" + selectedRoomId + "/maintenance",
				{
					method: "POST",
					headers: {
						"Content-Type":
							"application/x-www-form-urlencoded"
					},
					body: params.toString()
				}
			);

			if (!response.ok) {
				alert("객실 정비 요청에 실패했습니다.");
				return;
			}

			const result = await response.json();

			if (!result) {
				alert("객실 정비 요청에 실패했습니다.");
				return;
			}

			alert("객실 정비 요청이 등록되었습니다.");
			location.reload();

		} catch (error) {
			console.error(error);
			alert("객실 정비 요청 중 오류가 발생했습니다.");
		}
	});
});