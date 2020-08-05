<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 리스트</title>
</head>
<body>
<style>
body {
	text-align:center;
}

.list-table {
	border: 3px black double;
	text-align:center;
	margin-left:auto;
	margin-right:auto;
}

.list-table > thead {
	
}
</style>
<!-- 리스트 테이블 -->
	<h1>게시물 리스트</h1>
	<h2>전체 게시물 개수 <${totalCount}> </h2>
	<table class="list-table con">
		<colgroup>
			<col width="25"/>
			<col width="250"/>
			<col width="200"/>
		</colgroup>
		<thead>
			<tr>
				<th>id</th>
				<th>regDate</th>
				<th>title</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="article">
			<tr>
				<td>${article.id}</td>
				<td>${article.regDate}</td>
				<td><a style="color: black; text-decoration: none" href="./detail?id=${article.id}">${article.title}</a></td>
			</tr>
			</c:forEach>
		</tbody>

	</table>
		<div class="btns">
			<a href="./list">list</a> <a href="./write">write</a>
		</div>
</body>
</html>