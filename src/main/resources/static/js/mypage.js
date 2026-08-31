
const mypageForm = document.querySelector('.mypage-form-buttons').closest('form');
// 이 파일 자체가 마이페이지 전용이라 이 요소는 항상 존재한다고 가정 가능
// → optional chaining(?.)이나 if 가드가 굳이 없어도 됨 (있어도 무방하지만)

mypageForm.addEventListener('submit', function (e) {
    e.preventDefault();

    const newPassword = document.querySelector('[name="newPassword"]').value;
    const newPasswordCheck = document.querySelector('[name="newPasswordCheck"]').value;

    if (newPassword !== newPasswordCheck) {
        alert('신규 비밀번호가 일치하지 않습니다.');
        return;
    }

    const payload = {
        name: document.querySelector('[name="name"]').value,
        phone: document.querySelector('[name="phone"]').value,
        password: document.querySelector('[name="currentPassword"]').value,
        newPassword: newPassword
    };

    fetch('/mypage/update', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
    })
    .then(res => res.json())
    .then(data => {
        alert(data.message);
        if (data.success) {
            location.reload();
        }
    })
    .catch(err => {
        alert('요청 처리 중 오류가 발생했습니다.');
        console.error(err);
    });
});