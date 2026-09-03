// 아이디 형식: 영문+숫자 4~20자, 숫자만으로는 불가 (서버 CustomerServiceImpl의 정규식과 동일하게 맞춤)
const LOGIN_ID_REGEX = /^(?=.*[a-zA-Z])[a-zA-Z0-9]{4,20}$/;

// 전화번호 형식: 010-1234-5678 형태만 허용 (서버 정규식과 동일)
const PHONE_REGEX = /^01[0-9]-\d{3,4}-\d{4}$/;


// 비밀번호 일치 여부 확인
const customerPwd = document.querySelector("#password");				// 비밀번호 입력창
const customerPwdConfirm = document.querySelector("#passwordCheck");	// 비밀번호 확인 입력창

let checkPwd = false;	// 비밀번호 일치 여부

function validatePwdConfirm() {
	const confirmResult = document.querySelector("#check-pwd-result");

	if (!customerPwdConfirm.value.trim()) {
		confirmResult.textContent = "";
		checkPwd = false;
		return;
	}

	checkPwd = customerPwd.value === customerPwdConfirm.value;

	confirmResult.textContent = checkPwd ? "비밀번호가 일치합니다." : "비밀번호가 일치하지 않습니다.";
	confirmResult.className = checkPwd ? "form-tip form-tip-ok" : "form-tip form-tip-error";
}

customerPwd.addEventListener('input', validatePwdConfirm);
customerPwdConfirm.addEventListener('input', validatePwdConfirm);


let checkId = null;		// 아이디 중복체크 값
const checkIdResult = document.querySelector("#check-id-result");
const customerIdInput = document.querySelector("#loginId");

customerIdInput.addEventListener("input", function() {
	checkIdResult.textContent = "";
	checkId = null;
});

// 아이디 [중복확인] 버튼의 클릭 이벤트 리스너 추가
const checkIdBtn = document.querySelector("#check-id-btn");
checkIdBtn.addEventListener("click", async function() {
	const customerId = customerIdInput.value.trim();

	// 아이디 값이 입력되지 않았을 경우, 요청 x
	if (customerId.length === 0) {
		checkIdResult.textContent = "아이디를 입력해주세요.";
		checkIdResult.className = "form-tip form-tip-error";
		checkId = null;
		return;
	}

	// 형식 체크를 중복확인(서버 요청)보다 먼저 실행
	// 형식이 안 맞으면 여기서 바로 막고, 서버에는 요청 자체를 보내지 않음
	if (!LOGIN_ID_REGEX.test(customerId)) {
		checkIdResult.textContent = "아이디는 영문과 숫자만 사용해서 4~20자로 입력해주세요.";
		checkIdResult.className = "form-tip form-tip-error";
		checkId = null;
		return;
	}

	// 여기부터는 형식이 맞는 아이디만 도달 → 중복 확인 서버 요청
	try {
		const response = await fetch("/customer/checkId?loginId=" + encodeURIComponent(customerId), {
			method: "GET",
			headers: { "X-Requested-With": "XMLHttpRequest" }
		});

		const result = await response.json();

		checkIdResult.textContent = result.message;
		checkIdResult.className = result.data ? "form-tip form-tip-error" : "form-tip form-tip-ok";

		checkId = result.data ? null : customerId;
	} catch (error) {
		console.log(error);

		checkIdResult.textContent = "중복 확인 중 오류가 발생했습니다.";
		checkIdResult.className = "form-tip form-tip-error";

		checkId = null;
	}
});


// 회원가입 폼 제출 => 비밀번호가 일치했을 때, 사용 가능한 아이디인 경우 제출하도록 처리
const signupForm = document.querySelector("#signup-form");

signupForm.addEventListener("submit", function(e) {

	const loginIdValue = customerIdInput.value.trim();		// 현재 입력된 아이디 값

	// 1) 아이디 형식 검증 - 가장 먼저 체크
	if (!LOGIN_ID_REGEX.test(loginIdValue)) {
		e.preventDefault();
		alert("아이디는 영문과 숫자만 사용해서 4~20자로 입력해주세요.");
		return;
	}

	const phoneInput = document.querySelector("#phone");	// 전화번호 입력창
	const phoneValue = phoneInput.value.trim();			// 현재 입력된 전화번호 값

	// 2) 전화번호 형식 검증 - 아이디 통과한 다음에 체크
	if (!PHONE_REGEX.test(phoneValue)) {
		e.preventDefault();
		alert("휴대폰 번호 형식이 올바르지 않습니다. (예: 010-1234-5678)");
		return;
	}

	// 3) 아이디 중복확인 여부 체크
	if (!checkId) {
		e.preventDefault();
		alert("아이디 중복확인을 진행해주세요.");
		return;
	}

	// 4) 비밀번호 일치 여부 체크
	if (!checkPwd) {
		e.preventDefault();
		alert("비밀번호가 일치하지 않습니다.");
		return;
	}

});