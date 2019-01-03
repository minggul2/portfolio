<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "form" uri = "http://www.springframework.org/tags/form"%>

<form:form modelAttribute = "memberDTO" method = "POST">
	<table>
		<tr>
			<th><h3>Please sign in</h3></th>
		</tr>
		<tr>
			<td>아이디</td>
			<td>
				<form:input path = "id" type = "text" placeholder = "아이디" name = "id" id = "id" class = "form-control"/>
				<form:errors path = "id" cssClass = "errorMessage"/>
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<form:input path = "pwd" type = "password" placeholder = "비밀번호" name = "pwd" id = "pwd" class = "form-control" />
				<div id = "pwd_div"><form:errors path = "pwd" /></div>
			</td>
		</tr>
		<tr>
			<td></td>
			<td><input type = "button" value = "로그인" id = "loginBtn" class = "btn btn-lg btn-primary btn-block"></td>
		</tr>
	</table>
</form:form>

<script>
	$(document).ready(function(){
		$('#loginBtn').click(function(){
			$('#memberDTO').submit();
		});
	});
</script>
