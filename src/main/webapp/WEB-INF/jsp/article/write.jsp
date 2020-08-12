<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageName" value="게시물 작성" />
<%@ include file="../part/head.jspf"%>
<style>
body {
	text-align: center;
}
</style>
<script>
	<!-- 내용입력 -->
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
	<!-- 파일등록 -->
	var startUploadFiles = function(onSuccess) {
		
		if ( form.file__article__0__common__attachment__1.value.length == 0 && form.file__article__0__common__attachment__2.value.length == 0 ) {
			onSuccess();
			return;
		}
		var fileUploadFormData = new FormData(form); 
		
		fileUploadFormData.delete("relTypeCode");
		fileUploadFormData.delete("relId");
		fileUploadFormData.delete("body");

		$.ajax({
			url : './../file/doUploadAjax',
			data : fileUploadFormData,
			processData : false,
			contentType : false,
			dataType:"json",
			type : 'POST',
			success : onSuccess
		});
	}
	
	var startWriteReply = function(fileIdsStr, onSuccess) {
		
		$.ajax({
			url : './../article/doWrite',
			data : {
				fileIdsStr: fileIdsStr,
				body: form.body.value,
				relTypeCode: form.relTypeCode.value,
				relId: form.relId.value
			},
			dataType:"json",
			type : 'POST',
			success : onSuccess
		});
	};
	
	startUploadFiles(function(data) {
		
		var idsStr = '';
		if ( data && data.body && data.body.fileIdsStr ) {
			idsStr = data.body.fileIdsStr;
		}
		
		startWriteReply(idsStr, function(data) {
			if ( data.msg ) {
				alert(data.msg);
			}
			
			form.body.value = '';
			form.file__article__0__common__attachment__1.value = '';
			form.file__article__0__common__attachment__2.value = '';
		});
	});
	
}

</script>
<form action="doWrite" method="POST">
	<h1>게시물 작성</h1>

	<div>
		<span>제목</span> <input name="title" type="text" placeholder="제목" autofocus="autofocus" />
	</div>
	<div class="label">공개 여부</div>
	<div class="input">
		<select name="displayStatus">
			<option value="1">공개</option>
			<option value="0">비공개</option>
		</select>
	</div>
	<div>
		<div class="form-control-box">
			<input type="file" accept="video/*" capture name="file__article__0__common__attachment__1">
		</div>
	</div>
	<div>
		<span>내용</span>
		<textarea rows="10" cols="20" name="body" placeholder="내용"></textarea>
	</div>
	<div>
		<input type="submit" value="작성"> <input type="reset"
			value="취소" onclick="history.back();">
	</div>
</form>
<script>
	
</script>


<%@ include file="../part/foot.jspf"%>