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
	margin-left: 18%;
	margin-right: 18%;
}

.reply-list-box {
	text-align: -webkit-center;
	border: 3px black double;
	border-top: none;
	margin-left: 20%;
	margin-right: 20%;
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

.table-box{
	margin-left:18%;
	margin-right:18%;
	margin-bottom : 10px;
}

.table-box > table > tbody > tr > td > button {
	margin-left:10px;
	margin-right:10px;
}

.form-control-box > {
	
}
</style>
<h1>게시물 상세</h1>

<div>
	번호 : ${article.id} <br> 날짜 : ${article.regDate} <br> 제목 :
	${article.title} <br> 조회수 : ${article.hit}<br>
</div>
<div class="body" style="margin-top:20px;">내용 : ${article.body}</div>

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

	<form class="table-box con form1" action=""	onsubmit="ArticleWriteReplyForm__submit(this); return false;">

		<table>
			<tbody>
				<tr>
					<th style="width:84px; text-align:center;" >내용</th>
					<td>
						<div class="form-control-box">
							<textarea maxlength="300" name="body" placeholder="내용을 입력해주세요."
								style="width: 100%; height: 50px;"></textarea>
						</div>
					<input type="submit" value="작성">
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</c:if>


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
<!-- 댓글 수정 -->
<style>
.article-reply-modify-form-modal {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(0, 0, 0, 0.4);
	display: none;
}
.article-reply-modify-form-modal-actived .article-reply-modify-form-modal
	{
	display: flex;
}
</style>

<div class="article-reply-modify-form-modal flex flex-ai-c flex-jc-c">
	<form action="doModifyReplyAjax" class="form1 bg-white padding-10" onsubmit="ArticleReplyList__submitModifyForm(this); return false;">
		<input type="hidden" name="id" />
		<div class="form-row">
			<div class="form-control-label">내용</div>
			<div class="form-control-box">
				<textarea name="body" placeholder="내용을 입력해주세요."></textarea>
			</div>
		</div>
		<div class="form-row">
			<div class="form-control-label">수정</div>
			<div class="form-control-box">
				<button type="submit">수정</button>
				<button type="button"
					onclick="ArticleReplyList__hideModifyFormModal();">취소</button>
			</div>
		</div>
	</form>
</div>

<script>
	var ArticleReplyList__$box = $('.article-reply-list-box');
	var ArticleReplyList__$tbody = ArticleReplyList__$box.find('tbody');
	var ArticleReplyList__lastLodedId = 0;

	var ArticleReplyList__submitModifyFormDone = false;
	
	function ArticleReplyList__submitModifyForm(form) {
		if (ArticleReplyList__submitModifyFormDone) {
			alert('처리중입니다.');
			return;
		}
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();
			return;
		}
		var id = form.id.value;
		var body = form.body.value;
		ArticleReplyList__submitModifyFormDone = true;
		$.post('doModifyReplyAjax', {
			id : id,
			body : body
		}, function(data) {
			if (data.resultCode && data.resultCode.substr(0, 2) == 'S-') {
				// 성공시에는 기존에 그려진 내용을 수정해야 한다.!!
				var $tr = $('.article-reply-list-box tbody > tr[data-id="' + id + '"] .article-reply-body');
				$tr.empty().append(body);
			}
			ArticleReplyList__hideModifyFormModal();
			ArticleReplyList__submitModifyFormDone = false;
		}, 'json');
	}
	
	function ArticleReplyList__showModifyFormModal(el) {
		$('html').addClass('article-reply-modify-form-modal-actived');
		var $tr = $(el).closest('tr');
		var originBody = $tr.data('data-originBody');
		var id = $tr.attr('data-id');
		var form = $('.article-reply-modify-form-modal form').get(0);
		form.id.value = id;
		form.body.value = originBody;
	}
	
	function ArticleReplyList__hideModifyFormModal() {
		$('html').removeClass('article-reply-modify-form-modal-actived');
	}
	
	function ArticleReplyList__loadMoreCallback(data) {
		if (data.body.articleReplies && data.body.articleReplies.length > 0) {
			ArticleReplyList__lastLodedId = data.body.articleReplies[data.body.articleReplies.length - 1].id;
			ArticleReplyList__drawReplies(data.body.articleReplies);
		}
		setTimeout(ArticleReplyList__loadMore, 2000);
	}
	
	function ArticleReplyList__loadMore() {
		var callback = function(data) {

			if (data.body.articleReplies && data.body.articleReplies.length > 0)

			{
				ArticleReplyList__lastLodedId = data.body.articleReplies[data.body.articleReplies.length - 1].id;
				ArticleReplyList__drawReplies(data.body.articleReplies);
			}

			setTimeout(ArticleReplyList__loadMore, 2000);
		};

		$.get('getForPrintArticleReplies', {
			articleId : param.id,
			from : ArticleReplyList__lastLodedId + 1
		}, ArticleReplyList__loadMoreCallback, 'json');
	}

	function ArticleReplyList__drawReplies(articleReplies) {
		for (var i = 0; i < articleReplies.length; i++) {
			var articleReply = articleReplies[i];
			ArticleReplyList__drawReply(articleReply);
		}
	}

	function ArticleReplyList__delete(el) {
		if (confirm('삭제 하시겠습니까?') == false) {
			return;
		}

		var $tr = $(el).closest('tr');

		var id = $tr.attr('data-id');
		$.post('./doDeleteReplyAjax', {
			id : id
		}, function(data) {
			$tr.remove();
		}, 'json');
	}

	function ArticleReplyList__drawReply(articleReply) {
		var html = '';
		html += '<tr data-id="' + articleReply.id + '">';
		html += '<td>' + articleReply.id + '</td>';
		html += '<td>' + articleReply.regDate + '</td>';
		html += '<td>' + articleReply.extra.writer + '</td>';
		html += '<td class="article-reply-body">' + articleReply.body + '</td>';
		html += '<td>';
		if (articleReply.extra.actorCanDelete) {
			html += '<button type="button" onclick="ArticleReplyList__delete(this);">삭제</button>';
		}
		if (articleReply.extra.actorCanModify) {
			html += '<button type="button" onclick="ArticleReplyList__showModifyFormModal(this);">수정</button>';
		}
		html += '</td>';
		html += '</tr>';
		var $tr = $(html);
		$tr.data('data-originBody', articleReply.body);
		ArticleReplyList__$tbody.prepend($tr);
	}

	ArticleReplyList__loadMore();
</script>


<div class="direction"  style="margin-right:20px;margin-left:20px;">
	<c:if test="${article.delStatus == 'false' && article.id > 0}">
		<a href="./detail?id=${article.id-1}">BEFORE</a>
		<a href="./detail?id=${article.id+1}">NEXT</a>
	</c:if>
</div>
<div class="btns" style="margin-bottom:20px;">
	<a href="./modify?id=${article.id}">modify</a>
	<a href="./delete?id=${article.id}">delete</a>
</div>

<%@ include file="../part/foot.jspf"%>