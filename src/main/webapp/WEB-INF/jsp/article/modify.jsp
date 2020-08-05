<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
</head>
<body>
	<form action="./doModfiy" method="POST">
		<input type="hidden" name="id" value="${article.id}" />
		<h1>게시물 수정</h1>

		<div>
			번호 : ${article.id} <br> 날짜 : ${article.regDate}
		</div>
		<div>
			<div class="label">제목</div>
			<input name="title" type="text" placeholder="${article.title}" />
		</div>
		<div class="label">공개 여부</div>
		<div class="input">
			<select name="displayStatus">
				<option value="1">공개</option>
				<option value="0">비공개</option>
			</select>
		</div>
		<div>
			<div class="label">내용</div>
			<textarea name="body" id="" cols="30" rows="10">${article.body}</textarea>
		</div>
		<div>
			<input type="submit" class="submit-btn" value="modify" />
			<button type="button" class="cancel" value="cancel" onclick="location.href='./detail?id=${article.id}'">cancel</button>
		</div>
	</form>
	<div class="btns">
		<a href="./list">list</a> <a href="./delete?id=${article.id}">delete</a>
	</div>
</body>
</html>