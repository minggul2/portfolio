<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "form" uri = "http://www.springframework.org/tags/form"%>

<form:form modelAttribute = "memberDTO" method = "POST">
	<table>
		<tr>
			<th><h3>Sign in</h3></th>
		</tr>
		<tr>
			<td>아이디</td>
			<td>
				<form:input path = "id" type = "text" placeholder = "아이디" name = "id" id = "id" class = "form-control"/>
				<form:errors path = "id" cssClass = "errorMessage"/>
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>	
				<form:input path = "name" type = "text" placeholder = "이름" name = "name" id = "name" class = "form-control" />
				<div id = "name_div"><form:errors path = "name" /></div>
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
			<td colspan = "2"><input type = "button" value = "회원가입" id = "writeBtn" class = "btn btn-lg btn-primary btn-block"></td>
		</tr>
	</table>
</form:form>

<script>
	$(document).ready(function(){
		
		$('#writeBtn').click(function(){
			$('#id_div').empty();
			$('#name_div').empty();
			$('#pwd_div').empty();
			$($('#memberDTO').submit());
			/* 
			if($('#id').val()==''){
				$('#id_div').html('아이디를 입력하세요').css('color', 'red');
			}else if($('#name').val()==''){
				$('#name_div').html('이름을 입력하세요').css('color', 'red');
			}else if($('#pwd').val()==''){
				$('#pwd_div').html('비밀번호를 입력하세요').css('color', 'red');
			}else{
				alert("통과1");
				$($('#joinForm').submit());
			} */
		});
	});
</script>