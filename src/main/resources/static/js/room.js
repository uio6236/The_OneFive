document.addEventListener("DOMContentLoaded", function () {
    const detailLinks = document.querySelectorAll(".room-detail-link");
    const emptyArea = document.querySelector("#roomDetailEmpty");
    const detailContent = document.querySelector("#roomDetailContent");
    detailLinks.forEach(function (link) {
        link.addEventListener("click", async function (event) {
                // a 태그의 기본 페이지 이동 방지
                event.preventDefault();
                const roomId = link.dataset.roomId;
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
                    document.querySelector("#detailMemo").textContent = room.memo ? room.memo : "등록된 메모가 없습니다.";

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
});