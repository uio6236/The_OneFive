// ========================================
// 관리자 고객 수정
// ========================================

let selectedCustomerId = null;


// 수정 버튼
document.querySelectorAll(".customer-edit-btn")
    .forEach(function(button) {

        button.addEventListener("click", async function() {

            const id = this.dataset.id;

            selectedCustomerId = id;

            try {

                const response =
                    await fetch("/admin/customers/" + id);

                if (!response.ok) {
                    throw new Error("고객 정보를 가져오지 못했습니다.");
                }

                const customer = await response.json();

                // 고객 정보 입력
                document.querySelector("#detailName").value =
                    customer.name || "";

                document.querySelector("#detailPhone").value =
                    customer.phone || "";

                document.querySelector("#detailEmail").value =
                    customer.email || "";

                document.querySelector("#detailMemo").value =
                    customer.memo || "";


                // 빈 화면 숨기기
                document.querySelector("#customerDetailEmpty")
                    .style.display = "none";

                // 수정 화면 보여주기
                document.querySelector("#customerDetailContent")
                    .style.display = "block";

            } catch (error) {

                console.error(error);

                alert("고객 정보를 불러오는 중 오류가 발생했습니다.");

            }

        });

    });
	// [추가] 불러온 원본 데이터를 보관할 변수
	let originalCustomerData = null;

	// 기존 fetch 성공 로직(button.addEventListener 내부)에 백업 코드 1줄 추가 필요:
	// const customer = await response.json();
	// originalCustomerData = customer; // <-- 이 줄을 기존 수정 버튼 클릭 이벤트 안에 넣어주세요!


	// ----------------------------------------------------
	// 1. 취소 버튼 클릭 이벤트
	// ----------------------------------------------------
	


	// ----------------------------------------------------
	// 2. 저장 버튼 클릭 이벤트
	// ----------------------------------------------------
	document.querySelector("#customerSaveBtn").addEventListener("click", async function () {
	    if (!selectedCustomerId) {
	        alert("선택된 고객이 없습니다.");
	        return;
	    }

	    
	    const memo = document.querySelector("#detailMemo").value;

	    // Controller의 @PostMapping("/{id}") 로 전달할 Form Data 생성
	    const formData = new URLSearchParams();
	   
	    formData.append("memo", memo);

	    try {
	        const response = await fetch("/admin/customers/" + selectedCustomerId, {
	            method: "POST",
	            headers: {
	                "Content-Type": "application/x-www-form-urlencoded"
	            },
	            body: formData
	        });

	        if (response.ok) {
	            alert("고객 정보가 수정되었습니다.");
	            location.reload(); // 저장 후 목록 갱신을 위해 페이지 리로드
	        } else {
	            alert("수정에 실패했습니다.");
	        }
	    } catch (error) {
	        console.error(error);
	        alert("저장 중 오류가 발생했습니다.");
	    }
	});
