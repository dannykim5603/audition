<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageName" value="메인" />
<%@ include file="../part/head.jspf"%>
	
	
	
	
	<h1>메인입니다.</h1>
<div class = "util-box">
<a href="/usr/member/join">join</a>	
<a href="/usr/member/login">login</a>
<a href="/usr/article/list">list</a>
</div>
<style>
	.util-box {
		
	}
	
	.util-box > a {
		text-decoration : none;
		margin : 10px;
	}
</style>
	
<%@ include file="../part/foot.jspf"%>