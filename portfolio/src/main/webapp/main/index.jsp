<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포트폴리오</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style>
.container {
	position:relative;
}

nav {
	position: absolute;
	left: 0px;
	width: 10%;
	height : 700px;
	background-color : black;
}

section {
	/* position is static by default */
	width : 90%;
	/* margin-left: 200px; */
	margin-left : 10%;
	/* background-color : blue; */
	height : 700px;
}

/* footer 의 위치는 section에 의해 결정됨 */
footer {
	/* position : relative; */		
	position : static;
	bottom: 0;
	left: 0;
	height: 70px;
	width : 100%;
	background-color : yellow;
}

body {
	margin-bottom: 120px;
}
header{
	height : 75px;
	background-color : green;
}
</style>
<!-- <link rel = "stylesheet" href = "../bootstrap/css/bootstrap.min.css"/> -->



</head>
<body >
<script src = "http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<header><jsp:include page = "../template/header.jsp"/></header>
		<nav>
			<jsp:include page = "../template/nav.jsp"/>
		</nav>
		<section>
			<jsp:include page = "${display}"/>
		</section>
		<footer>
			footer
		</footer>
<!-- <script src = "../bootstrap/js/bootstrap.min.js"></script> -->
<script>
	$(document).ready(function(){
		/* $.get("json_test.do", function(data){
		}, 'json').done(function(data){
			console.log("응답 성공");
			console.log(data);
		}); */
	});
</script>
</body>

</html>





