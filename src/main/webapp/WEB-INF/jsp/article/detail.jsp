<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세</title>
</head>
<body>
	<h1>게시물 상세</h1>
	
	<div>
		번호 : ${article.id} <br>  날짜 : ${article.regDate} <br> 제목 : ${article.title}
	</div>
	<div>
		내용 : ${article.body}
	</div>
	<div class="direction">
		<a href="./detail?id=${article.id-1}">BEFORE</a>
		<a href="./detail?id=${article.id+1}">NEXT</a>
	</div>
	<div class="btns">
		<a href="./list">list</a>
		<a href="./modify?id=${article.id}">modify</a>
		<a href="./delete?id=${article.id}">delete</a>
	</div>
</body>
</html>