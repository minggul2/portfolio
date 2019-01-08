<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "form" uri = "http://www.springframework.org/tags/form"%>

<form:form modelAttribute = "boardDTO" method = "POST">
	<table>
		<tr>
			<th><h3>Board Write</h3></th>
		</tr>
		<tr>
			<td>제목</td>
			<td>
				<form:input path = "subject" type = "text" class = "form-control"/>
				<form:errors path = "subject" cssClass = "errorMessage"/>
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>	
				<form:textarea path = "contents" type = "text" class = "form-control" cols = "100" rows = "15"/>
				<div id = "name_div"><form:errors path = "contents" /></div>
			</td>
		</tr>
		<tr>
			<td colspan = "2"><input type = "button" value = "등록" id = "writeBtn" class = "btn btn-lg btn-primary btn-block"></td>
		</tr>
	</table>
</form:form>
<script>
	$(document).ready(function(){
		$('#writeBtn').click(function(){
			$('#boardDTO').submit();
		});
	});
</script>