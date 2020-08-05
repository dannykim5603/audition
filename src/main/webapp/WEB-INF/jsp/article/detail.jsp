<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageName" value="게시물 상세" />
<%@ include file="../part/head.jspf"%>

<style>
body {
	text-align: center;
}

.body {
	border: 3px black double;
}
.reply-list-box{
	text-align: -webkit-center;
	border: 3px black double;
    border-top: none;
}
</style>
<h1>게시물 상세</h1>

<div>
	번호 : ${article.id} <br> 날짜 : ${article.regDate} <br> 제목 :
	${article.title} <br> 조회수 : ${article.hit}
</div>
<div class="body">내용 : ${article.body}</div>
<div class="reply-list-box">
	<table>
		<c:forEach items="${articleReply}" var="articleReply">
		<thead>	
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>작성자</th>
				<th>내용</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${articleReply.id}</td>
				<td>${articleReply.regDate}</td>
				<td>${articleReply.writer}</td>
				<td>${articleReply.body}</td>
				<td>수정 / 삭제</td>
			</tr>
		</tbody>
		</c:forEach>
	</table>
</div>
<div class="reply-write-box"></div>
<div class="direction">
	<a href="./detail?id=${article.id-1}">BEFORE</a> <a
		href="./detail?id=${article.id+1}">NEXT</a>
</div>
<div class="btns">
	<a href="./list">list</a> <a href="./modify?id=${article.id}">modify</a>
	<a href="./delete?id=${article.id}">delete</a>
</div>





<%@ include file="../part/foot.jspf"%>