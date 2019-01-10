<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<style>
	.tab {
		float : left;
		width : 30%;
		height : 100%;
		background-color : gray;
	}
	
	.profile{
		width : 10%;
		background-color : fuchsia;
	}
</style>

<div class = "tab profile">
	<c:if test = "${sessionScope.id == null}">
		Guest
	</c:if>
	<c:if test = "${sessionScope.id != null}">
		환영합니다<br>
		${sessionScope.id}
	</c:if>
</div>
<div class = "tab">
	test	
</div>
<div class = "tab">
	test	
</div>
<div class = "tab">
	<c:if test = "${sessionScope.id == null}">
		<a href = "../member/join.do">회원가입</a>	
		<a href = "../member/login.do">로그인</a>
	</c:if>
	<c:if test = "${sessionScope.id != null}">
		<a href = "../member/logout.do">로그아웃</a>
	</c:if>
</div>

