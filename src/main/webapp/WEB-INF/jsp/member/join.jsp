<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageName" value="메인" />
<%@ include file="../part/head.jspf"%>
	
<script	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<style>
.join-form-box {
	color: black;
	display: flex;
	justify-content: center;
}

.form1 {
	width: 500px;
	margin-top: 100px;
	border: outset #444958 3px;
	padding: 20px;
}

.form1>.form-row {
	width: 100%;
}

.form1>.form-row>.label {
	padding-top: 10px;
	padding-bottom: 20px;
}

.form1>.form-row>.input>input {
	width: 90%;
	margin-left: 20px;
	height: 25px;
}

.last-box {
	margin-top:30px;
	text-align:center;
}

.last-box>a {
	background-color: white;
	color: black;
	font-weight: thin;
	padding: 0px 40px;
}
</style>

<script>
	var submitJoinFormDone = false;
	function submitJoinForm(form) {
		if ( submitJoinFormDone ) {
			alert('처리중 입니다.');
			return;
		}
		
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
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value.length == 0) {
			alert('로그인 비번확인을 입력해주세요.');
			form.loginPwConfirm.focus();
			return;
		}
		if (form.loginPw.value != form.loginPwConfirm.value) {
			alert('로그인 비번확인이 일치하지 않습니다.');
			form.loginPwConfirm.focus();
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.name.focus();
			return;
		}
		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value.length == 0) {
			alert('별명을 입력해주세요.');
			form.nickname.focus();
			return;
		}
		form.phoneNo.value = form.nickname.value.trim();
		if (form.nickname.value.length == 0) {
			alert('전화번호를 입력해주세요.');
			form.nickname.focus();
			return;
		}
		
		form.email.value = form.email.value.trim();

		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}
		
		form.loginPwReal.value = sha256(form.loginPw.value);
		form.loginPw.value = '';
		form.loginPwConfirm.value = '';
		
		form.submit();
		submitJoinFormDone = true;
	}
</script>

<div class="join-form-box con">
	<form action="doJoin" method="POST" class="join-form form1"	onsubmit="submitJoinForm(this); return false;">
		<input type="hidden" name="loginPwReal">
		<div class="form-row">
			<div class="label">LOGIN ID</div>
			<div class="input">
				<input name="loginId" type="text" placeholder=" login ID " />
			</div>
		</div>
		<div class="form-row">
			<div class="label">E-MAIL</div>
			<div class="input">
				<input name="email" type="email" placeholder="E-mail " />
			</div>
		</div>
		<div class="form-row">
			<div class="label">NAME</div>
			<div class="input">
				<input name="name" type="text" placeholder=" NAME "></input>
			</div>
		</div>
		<div class="form-row">
			<div class="label">NICKNAME</div>
			<div class="input">
				<input name="nickname" type="text" placeholder=" NICKNAME " />
			</div>
		</div>
		<div class="form-row">
			<div class="label">PHONE NO.</div>
			<div class="input">
				<input name="phoneNo" type="text" placeholder=" PHONE NO. " />
			</div>
		</div>
		<div class="form-row">
			<div class="label">LOGIN PW</div>
			<div class="input">
				<input name="loginPw" type="password" placeholder=" login PW "></input>
			</div>
		</div>
		<div class="form-row">
			<div class="label">LOGIN PW CONFIRM</div>
			<div class="input">
				<input name="loginPwConfirm" type="password"
					placeholder=" PW Confirm "></input>
			</div>
		</div>
		<div class="form-row">
			<div class="label"></div>
			<div class="input last-box">
				<input class="submit-box" style="width: 20%; "
					type="submit" value="회원가입" /> <a
					style="border: 1px solid #444958;" class="cancel" href="home">취소</a>
			</div>
		</div>
	</form>
</div>
	
	
	
<%@ include file="../part/foot.jspf"%>