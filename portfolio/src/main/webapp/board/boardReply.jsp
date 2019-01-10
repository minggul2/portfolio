<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "form" uri = "http://www.springframework.org/tags/form"%>

<style>
#container {
      width: 70%;
      margin: 0 auto;     /* 가로로 중앙에 배치 */
      padding-top: 10%;   /* 테두리와 내용 사이의 패딩 여백 */
    }
</style>

<div id = "container">
<form:form modelAttribute = "boardDTO" action = "boardReply.do" method = "POST">
	<input type = "hidden" name = "b_no" value = "${b_no}">
	<table>
		<tr>
			<th colspan = "2" style = "text-align : center;"><h3>Board Write</h3></th>
		</tr>
		<tr>
			<td width = "100">제목</td>
			<td>
				<form:input path = "b_subject" type = "text" class = "form-control"/>
				<form:errors path = "b_subject" cssClass = "errorMessage"/>
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>	
				<form:textarea path = "b_contents" type = "text" class = "form-control" cols = "100" rows = "15"/>
				<div id = "name_div"><form:errors path = "b_contents" /></div>
			</td>
		</tr>
		<tr>
			<td colspan = "2"><input type = "button" value = "등록" id = "writeBtn" class = "btn btn-lg btn-primary btn-block"></td>
		</tr>
	</table>
</form:form>
</div>
<script>
	$(document).ready(function(){
		$('#writeBtn').click(function(){
			$('#boardDTO').submit();
		});
	});
</script>