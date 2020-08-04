<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 리스트</title>
</head>
<body>
	<h1>게시물 리스트</h1>
	
	<h2 class="con">전체 게시물 개수 : ${totalCount}</h2>
	
	<c:forEach items="${list}" var="article">
	<div>
		${article.id} / ${article.regDate} / <a style="color:black; text-decoration:none" href="./detail?id=${article.id}">${article.title}</a>
	</div>
	</c:forEach>
	
	<div class="btns">
		<a href="./list">list</a>
		<a href="./write">write</a>
	</div>
</body>
</html>