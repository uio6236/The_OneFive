// 사번 형식: 영문+숫자 4~20자, 숫자만으로는 불가 (고객 아이디 규칙과 동일하게 맞춤)
const EMPLOYEE_CODE_REGEX = /^(?=.*[a-zA-Z])[a-zA-Z0-9]{4,20}$/;


// 비밀번호 일치 여부 확인
const customerPwd = document.querySelector("#password");				// 비밀번호 입력창
const customerPwdConfirm = document.querySelector("#passwordCheck");	// 비밀번호 확인 입력창

let checkPwd = false;	// 비밀번호 일치 여부

function validatePwdConfirm() {
	const confirmResult = document.querySelector("#check-pwd-result");

	// 비밀번호 확인 입력창이 비어있을 경우 검사 x
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


let checkCode = null;		// 아이디 중복체크 값
const checkCodeResult = document.querySelector("#check-code-result");
const employeeIdInput = document.querySelector("#code");

employeeIdInput.addEventListener("input", function() {
	checkCodeResult.textContent = "";
	checkCode = null;
});

// 아이디 [중복확인] 버튼의 클릭 이벤트 리스너 추가
const checkCodeBtn = document.querySelector("#check-code-btn");
checkCodeBtn.addEventListener("click", async function() {
	const employeeId = employeeIdInput.value.trim();

	// 아이디 값이 입력되지 않았을 경우, 요청 x
	if (employeeId.length === 0) {
		checkCodeResult.textContent = "사번을 입력해주세요.";
		checkCodeResult.className = "form-tip form-tip-error";
		checkCode = null;
		return;
	}

	// 형식 체크를 중복확인(서버 요청)보다 먼저 실행
	// 형식이 안 맞으면 여기서 바로 막고, 서버에는 요청 자체를 보내지 않음
	if (!EMPLOYEE_CODE_REGEX.test(employeeId)) {
		checkCodeResult.textContent = "사번은 영문과 숫자만 사용해서 4~20자로 입력해주세요.";
		checkCodeResult.className = "form-tip form-tip-error";
		checkCode = null;
		return;
	}

	// 여기부터는 형식이 맞는 사번만 도달 → 중복 확인 서버 요청
	try {
		const response = await fetch("/admin/checkCode?code=" + encodeURIComponent(employeeId), {
			method: "GET",
			headers: { "X-Requested-With": "XMLHttpRequest" }
		});

		// response.json() : json 응답을 자바스크립트 객체로 변경
		const result = await response.json();

		checkCodeResult.textContent = result.message;
		checkCodeResult.className = result.data ? "form-tip form-tip-error" : "form-tip form-tip-ok";

		checkCode = result.data ? null : employeeId;
	} catch (error) {
		console.log(error);

		checkCodeResult.textContent = "중복 확인 중 오류가 발생했습니다.";
		checkCodeResult.className = "form-tip form-tip-error";

		checkCode = null;
	}
});


// 회원가입 폼 제출 => 비밀번호가 일치했을 때, 사용 가능한 아이디인 경우 제출하도록 처리
const signupForm = document.querySelector("#signup-form");

signupForm.addEventListener("submit", function(e) {

	const employeeIdValue = employeeIdInput.value.trim();		// 현재 입력된 사번 값

	// 1) 사번 형식 검증 - 가장 먼저 체크
	if (!EMPLOYEE_CODE_REGEX.test(employeeIdValue)) {
		e.preventDefault();
		alert("사번은 영문과 숫자만 사용해서 4~20자로 입력해주세요.");
		return;
	}

	// 2) 사번 중복확인 여부 체크
	if (!checkCode) {
		e.preventDefault();
		alert("사번 중복확인을 진행해주세요.");
		return;
	}

	// 3) 비밀번호 일치 여부 체크
	if (!checkPwd) {
		e.preventDefault();		// 기존 폼 제출 동작을 막기!
		alert("비밀번호가 일치하지 않습니다.");
		return;
	}

});