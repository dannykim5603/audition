<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/head.jspf"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>
<style>
.login-form-box {
	color: white;
	display: flex;
	justify-content: center;
}

.form1 {
	width: 40%;
	margin-top: 100px;
}

.form1>.form-row {
	width: 100%;
}

.join-form {
	border: outset #444958 3px;
	width: 50%;
	padding : 15px;
	color: white;
}
.join-form >.form-row {

}

.form1>.form-row>.label {
	padding-top: 20px;
	padding-bottom: 20px;
}

.form1>.form-row>.input>input {
	width: 90%;
	margin-left: 20px;
	height: 25px;
}

.last-box{
	text-align:center;
}

.last-box>a {
	background-color: white;
	color: black;
	font-weight: thin;
	border-radius: 15px;
	padding: 0px 40px;
}
.find-box {
	margin-top:20px;
	display:flex;
	justify-content:center;
}
.find-box > a{
	padding: 0 20px;
}
.find-box > a:hover {
	color:red;
}
</style>
<script>

	function submitLoginForm(form) {
		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value.length == 0) {
			alert('로그인 아이디를 입력해주세요.');
			form.loginId.focus();
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('로그인 비번을 입력해주세요.');
			form.loginPw.focus();
			return;
		}

		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';

		form.submit();
	}
</script>

<div class="login-form-box con">
	<form action="doLogin" method="POST" class="join-form form1" onsubmit="submitLoginForm(this); return false;">
		<input type="hidden" name="redirectUrl" value="${param.afterLoginRedirectUrl}" />
		<input type="hidden" name="loginPwReal" />
		<div class="form-row">
			<div class="label">ID</div>
			<div class="input">
				<input name="loginId" type="text" placeholder=" login ID " />
			</div>
		</div>
		<div class="form-row">
			<div class="label">PW</div>
			<div class="input">
				<input name="loginPw" type="password" placeholder=" login PW "></input>
			</div>
		</div>
			<div class="form-row">
			<div class="label"></div>
			<div class="input last-box">
				<input class="submit-box" style="width: 20%; border-radius: 15px;"
					type="submit" value="로그인" /> <a class="cancel" href="../usr/home/main">취소</a>
			</div>
		</div>
	</form>
</div>

<%@ include file="../part/foot.jspf"%>