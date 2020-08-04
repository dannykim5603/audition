<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성</title>
</head>
<body>
	<form action="doWrite" method="POST">
		<h1>게시물 작성</h1>

		<div>
			<span>제목</span> <input name="title" type="text" placeholder="제목"
				autofocus="autofocus" />
		</div>
		<div class="label">공개 여부</div>
		<div class="input">
			<select name="displayStatus">
				<option value="1">공개</option>
				<option value="0">비공개</option>
			</select>
		</div>
		<div>
			<span>내용</span>
			<textarea rows="10" cols="20" name="body" placeholder="내용"></textarea>
		</div>
		<div>
			<input type="submit" value="작성"> 
			<input type="reset" value="취소" onclick="history.back();">
		</div>
	</form>
	<script>
		function submitWriteForm(form) {
			var source = editor1.getMarkdown().trim();
			if (source.length == 0) {
				alert('내용을 입력해주세요.');
				editor1.focus();
				return;
			}
			form.body.value = source;
			form.submit();
		}
	</script>
</body>
</html>