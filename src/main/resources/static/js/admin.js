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

// 아이디 [중복확인] 버튼의 클릭 이벤트 리스너 추가 (TODO: alert)
const checkCodeBtn = document.querySelector("#check-code-btn");
checkCodeBtn.addEventListener("click", async function() {
	const employeeId = employeeIdInput.value.trim();
	// 아이디 값이 입력되지 않았을 경우, 요청 x
	if (employeeId.length === 0) {
		checkCodeResult.textContent = "아이디를 입력해주세요.";
		checkCodeResult.className = "form-tip form-tip-error";
		checkCode = null;
		return;
	}
	
	// 입력된 아이디값이 중복되는 지 서버로 요청!
	/*
		* fetch API
		  : 브라우저에서 서버로 요청을 보내고 응답을 받을 수 있게 해주는 자바스크립트 내장 함수
		    form 태그의 submit과 달리 "화면 새로고침 없이(비동기적으로)", 
			백엔드 서버와 데이터를 주고 받을 수 있음. 이러한 통신 방식을 AJAX라고 함.
			
		fetch(URL, settings)
		- URL : 요청을 보낼 주소
		- settings : 설정 객체 (요청 방식, 헤더, 데이터 등)
		  - method: 요청 방식
		  - headers: 헤더 설정 
		  
		encodeURIComponent() : 전달하는 파라미터에 &, =와 같은 특수문자가 있을 경우 URL 형식이 깨지는 것을 방지(인코딩)
		"X-Requested-With": "XMLHttpRequest" 
		=> 이 요청이 브라우저 주소창에서 이동한 것이 아니라, 자바스크립트(AJAX)를 통해 보낸 것임을 서버에 알려주는 설정(관례)
	*/
	try {
		const response = await fetch("/admin/checkCode?code=" + encodeURIComponent(employeeId), {
			method: "GET",
			headers: { "X-Requested-With": "XMLHttpRequest" }  
		});
		
		// response.json() : json 응답을 자바스크립트 객체로 변경
		const result = await response.json();
		
		// console.log(result);
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
	
	if (!checkCode) {
		e.preventDefault();
		alert("아이디 중복확인을 진행해주세요.");
		return;
	}
	
	if (!checkPwd) {
		e.preventDefault();		// 기존 폼 제출 동작을 막기!
		alert("비밀번호가 일치하지 않습니다.");
		return;
	}
	
});