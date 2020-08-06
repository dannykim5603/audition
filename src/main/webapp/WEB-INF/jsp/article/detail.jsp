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

.reply-list-box > table > tbody > tr[data-modify-mode="N"] .modify-mode-visible	{
	display: none;
}

.reply-list-box > table > tbody > tr[data-modify-mode="Y"] .modify-mode-invisible {
	display: none;
}

.reply-list-box > table > tbody > tr > .reply-body-td > .modify-mode-visible > form {
    width:100%;
    display:block;
}

.reply-list-box > table > tbody > tr > .reply-body-td > .modify-mode-visible > form > textarea {
    width:100%;
    height:100px;
    box-sizing:border-box;
    display:block;
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
<script>

function Article__writeReply(form) {
    form.body.value = form.body.value.trim();
    
    if ( form.body.value.length == 0 ) {
        form.body.focus();
        
        alert('내용을 입력해주세요.');
        return;
    }
    
    var $form = $(form);
    
    $form.find('input[type="submit"]').val('작성중..');
    $form.find('input[type="submit"]').prop('disabled', true);
    $form.find('input[type="reset"]').prop('disabled', true);
    
    /*
    $.post(
        './doWriteReply',
        {
            articleId:articleId,
            body:body
        },
        function(data) {
            if ( data.resultCode.substr(0, 2) == 'F-1' ) {
                alert(data.msg);
            }
            else {
                $form.find('input[type="submit"]').val('작성');
                $form.find('input[type="submit"]').prop('disabled', false);
                $form.find('input[type="reset"]').prop('disabled', false);
            }
        }
    );
    */
}

function Article__modifyReply(form) {
    form.body.value = form.body.value.trim();
    
    if ( form.body.value.length == 0 ) {
        form.body.focus();
        
        alert('내용을 입력해주세요.');
        return;
    }
    
    var $tr = $(form).closest('tr');
    
    $tr.attr('data-modify-mode', 'N');
    
    var newBody = form.body.value;
    var id = form.id.value;
    
    // 임시 테스트용
    $tr.find(' > .reply-body-td > .modify-mode-invisible').empty().append(newBody);
    
    // 실제 서버에서 실행
    /*
    $tr.find(' > .reply-body-td > .modify-mode-invisible').empty().append('변경중..');
    
    $.post('./doModifyReply', {
        id:id,
        body: newBody
    }, function(data) {
        if ( data.resultCode.substr(0, 2) == 'S-' ) {
            $tr.find(' > .reply-body-td > .modify-mode-invisible').empty().append(newBody);
        }
        else {
            alert(data.msg);
        }
    }, 'json');
    */
}

function Article__deleteReply(el, id) {
    if ( confirm(id + '번 댓글을 삭제하시겠습니까?') == false ) {
        return;
    }
    
    var $tr = $(el).closest('tr');
    
    /*
    $.post(
        './doDeleteReply',
        {
            id:id
        },
        function(data) {
            if ( data.resultCode.substr(0, 2) == 'S-' ) {
                $tr.remove();
            }
            else {
                alert(data.msg);
            }
        }
    );
    */
}

function Article__turnOnModifyMode(el) {
    var $tr = $(el).closest('tr');
    
    var body = $tr.find(' > .reply-body-td > .modify-mode-invisible').html().trim();
    
    $tr.find(' > .reply-body-td > .modify-mode-visible > form > textarea').val(body);
    
    $tr.attr('data-modify-mode', 'Y');
    $tr.siblings('[data-modify-mode="Y"]').attr('data-modify-mode', 'N');
}

function Article__turnOffModifyMode(el) {
    var $tr = $(el).closest('tr');
    
    $tr.attr('data-modify-mode', 'N');
}

</script>
<div>
	번호 : ${article.id} <br> 날짜 : ${article.regDate} <br> 제목 :
	${article.title} <br> 조회수 : ${article.hit}
</div>
<div class="body">내용 : ${article.body}</div>
<div class="reply-list-box">
	<table>
		<colgroup>
			<col width="10%" />
			<col width="25%" />
			<col width="15%" />
			<col />
			<col width="10%" />
		</colgroup>
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
			<tbody class="reply-body">
				<tr data-modify-mode="N">
					<td>${articleReply.id}</td>
					<td>${articleReply.regDate}</td>
					<td>${articleReply.writer}</td>
					<td class="reply-body-td">
					<div class="modify-mode-invisible">
							${articleReply.body}</div>
						<div class="modify-mode-visible">
							<form action=""	onsubmit="Article__modifyReply(this); return false;">
								<input type="hidden" name="id" value="${articleReply.id}">
								<textarea maxlength="300" name="body"></textarea>
								<input type="submit" value="수정완료"> <a	href="javascript:;" onclick="Article__turnOffModifyMode(this);">수정취소</a>
							</form>
						</div>
					</td>
					<td>
						<a href="javascript:;" onclick="Article__deleteReply(this, 8);">삭제</a>
                  	  	<a class="modify-mode-invisible" href="javascript:;" onclick="Article__turnOnModifyMode(this);">수정</a>
                  	  	<a class="modify-mode-visible" href="javascript:;" onclick="Article__turnOffModifyMode(this);">수정취소</a>
					</td>
				</tr>
				
				<tr data-modify-mode="N">
                <td>${articleReply.id}</td>
                <td>${articleReply.regDate}</td>
                <td>${articleReply.writer}</td>
                <td class="reply-body-td">
                    <div class="modify-mode-invisible">
                        ${articleReply.body}
                    </div>
                    <div class="modify-mode-visible">
                        <form action="" onsubmit="Article__modifyReply(this); return false;">
                            <input type="hidden" name="id" value="${articleReply.id}">
                            <textarea maxlength="300" name="body"></textarea>
                            <input type="submit" value="수정완료">
                            <a href="javascript:;" onclick="Article__turnOffModifyMode(this);">수정취소</a>
                        </form>
                    </div>
                </td>
                <td>
                    <a href="javascript:;" onclick="Article__deleteReply(this, ${articleReply.id});">삭제</a>
                    <a class="modify-mode-invisible" href="javascript:;" onclick="Article__turnOnModifyMode(this);">수정</a>
                    <a class="modify-mode-visible" href="javascript:;" onclick="Article__turnOffModifyMode(this);">수정취소</a>
                </td>
            </tr>
		</c:forEach>
		</tbody>
	</table>
</div>
<div class="reply-write con">
	<form action="writeReply" onsubmit="Article__writeReply(this); return false;">
		<table>
			<colgroup>
				<col width="100">
			</colgroup>
			<tbody>
				<tr>
					<th>내용</th>
					<td>
						<div>
							<textarea placeholder="내용을 입력해주세요." name="body" maxlength="300"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>작성</th>
					<td><input type="submit" value="작성"> <input type="reset" value="취소"></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<div class="direction">
	<c:if test="${article.delStatus == 'false' && $article.id > 0">
	<a href="./detail?id=${article.id-1}">BEFORE</a> <a
		href="./detail?id=${article.id+1}">NEXT</a>
		
	</c:if>
</div>
<div class="btns">
	<a href="./list">list</a> <a href="./modify?id=${article.id}">modify</a>
	<a href="./delete?id=${article.id}">delete</a>
</div>





<%@ include file="../part/foot.jspf"%>