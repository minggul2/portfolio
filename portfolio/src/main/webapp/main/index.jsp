<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포트폴리오</title>
<style>
.container {
	position:relative;
}

nav {
	position: absolute;
	left: 0px;
	width: 200px;
	height : 500px;
	background-color : red;
}

section {
	/* position is static by default */
	margin-left: 200px;
	background-color : blue;
	height : 700px;
}

/* footer 의 위치는 section에 의해 결정됨 */
footer {
	/* position : relative; */		
	position : static;
	bottom: 0;
	left: 0;
	height: 70px;
	width: 100%;
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
</head>

<body >
<header>{NAME}'s HOME</header>
	<div class = "container">
		<nav>nav</nav>
		<section>
			<jsp:include page = "main.jsp"/>
		</section>
		<footer>
			fooetr
		</footer>
	</div>

</body>

</html>