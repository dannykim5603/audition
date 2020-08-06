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
	height: 500px;
	margin-left: 20px;
	margin-right: 20px
}

.reply-list-box {
	text-align: -webkit-center;
	border: 3px black double;
	border-top: none;
	margin-left: 20px;
	margin-right: 20px;
}

.reply-body {
	text-align: center;
}

.reply-list-box>table>tbody>tr[data-modify-mode="N"] .modify-mode-visible
	{
	display: none;
}

.reply-list-box>table>tbody>tr[data-modify-mode="Y"] .modify-mode-invisible
	{
	display: none;
}

.reply-list-box>table>tbody>tr>.reply-body-td>.modify-mode-visible>form
	{
	width: 100%;
	display: block;
}

.reply-list-box>table>tbody>tr>.reply-body-td>.modify-mode-visible>form>textarea
	{
	width: 100%;
	height: 100px;
	box-sizing: border-box;
	display: block;
}

.reply-write>form {
	display: block;
	width: 100%;
}

.reply-write>form>table {
	width: 100%;
	border-collapse: collapse;
}

.reply-write>form>table th, .reply-write>form>table td {
	border: 1px solid black;
	padding: 10px;
}

.reply-write>form>table textarea {
	width: 100%;
	display: block;
	box-sizing: border-box;
	height: 100px;
}

.direction {
	display: flex;
	justify-content: space-between;
}
</style>
<h1>게시물 상세</h1>

<div>
	번호 : ${article.id} <br> 날짜 : ${article.regDate} <br> 제목 :
	${article.title} <br> 조회수 : ${article.hit}
</div>
<div class="body">내용 : ${article.body}</div>
<!--  댓글 리스트  -->
<div class="article-reply-list-box table-box con">
	<table>
		<colgroup>
			<col width="80">
			<col width="180">
			<col width="180">
			<col>
			<col width="200">
		</colgroup>
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

		</tbody>
	</table>
</div>

<script>
	var ArticleReplyList__$box = $('.article-reply-list-box');
	var ArticleReplyList__$tbody = ArticleReplyList__$box.find('tbody');
	var ArticleReplyList__lastLodedId = 0;
	function ArticleReplyList__loadMore() {
		$.get('getForPrintArticleReplies',{articleId : param.id,from : ArticleReplyList__lastLodedId + 1},
				
						function(data) {
			
							if (data.body.articleReplies && data.body.articleReplies.length > 0) 
								
								{
									ArticleReplyList__lastLodedId = data.body.articleReplies[data.body.articleReplies.length - 1].id;
									ArticleReplyList__drawReplies(data.body.articleReplies);
								}	
							
							setTimeout(ArticleReplyList__loadMore, 2000);},
						'json');
	}
	
	function ArticleReplyList__drawReplies(articleReplies) {
		for (var i = 0; i < articleReplies.length; i++) {
			var articleReply = articleReplies[i];
			ArticleReplyList__drawReply(articleReply);
		}
	}
	
	function ArticleReplyList__delete(el) {
		if ( confirm('삭제 하시겠습니까?') == false ) {
			return;
		}
		
		var $tr = $(el).closest('tr');
		
		var id = $tr.attr('data-id');
		$.post('./doDeleteReplyAjax',{id:id},
			function(data) {$tr.remove();},'json');
	}
	
	function ArticleReplyList__drawReply(articleReply) {
		var html = '';
		html += '<tr data-id="' + articleReply.id + '">';
		html += '<td>' + articleReply.id + '</td>';
		html += '<td>' + articleReply.regDate + '</td>';
		html += '<td>' + articleReply.extra.writer + '</td>';
		html += '<td>' + articleReply.body + '</td>';
		html += '<td><button onclick="ArticleReplyList__delete(this);">삭제</button></td>';
		html += '</tr>';
		ArticleReplyList__$tbody.prepend(html);
	}
	
	ArticleReplyList__loadMore();
	
</script>

<!-- 댓글작성 -->
<c:if test="${isLogined}">
	<h2 class="con">댓글 작성</h2>

	<script>
		function ArticleWriteReplyForm__submit(form) {
			form.body.value = form.body.value.trim();
			if (form.body.value.length == 0) {
				alert('댓글을 입력해주세요.');
				form.body.focus();
				return;
			}
			$.post('./doWriteReplyAjax', {
				articleId : param.id,
				body : form.body.value
			}, function(data) {
			}, 'json');
			form.body.value = '';
		}
	</script>

	<form class="table-box con form1" action=""
		onsubmit="ArticleWriteReplyForm__submit(this); return false;">

		<table>
			<tbody>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<textarea maxlength="300" name="body" placeholder="내용을 입력해주세요."
								class="height-300"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>작성</th>
					<td><input type="submit" value="작성"></td>
				</tr>
			</tbody>
		</table>
	</form>
</c:if>


<div class="direction">
	<c:if test="${article.delStatus == 'false' && $article.id > 0}">
		<a href="./detail?id=${article.id-1}">BEFORE</a>
		<a href="./detail?id=${article.id+1}">NEXT</a>
	</c:if>
</div>
<div class="btns">
	<a href="./list">list</a> <a href="./modify?id=${article.id}">modify</a>
	<a href="./delete?id=${article.id}">delete</a>
</div>

<%@ include file="../part/foot.jspf"%>