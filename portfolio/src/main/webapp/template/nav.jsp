<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<style>
  .sidebar-nav{
  	padding-left : 0px;
  }
  .sidebar-nav li {
    text-indent: 1.5em;
    line-height: 2.8em;
  }
  
  
  .sidebar-nav li a {
    display: block;
    text-decoration: none;
    color: #999;
  }
  
  .sidebar-nav li a:hover {
    color: #fff;
    background: rgba(255, 255, 255, 0.2);
  }
  
  .sidebar-nav > .sidebar-brand {
    font-size: 1.3em;
    line-height: 3em;
  }
  
  .sidebar-brand{
  	overflow : hidden;
  }
</style>
	<div id="sidebar-wrapper">
		<ul class="sidebar-nav">
			<li class="sidebar-brand">
				<a href="../main/index.do">Home</a>
			</li>
			<c:if test = "${sessionScope.id != null}">
				<li><a href="#">마이페이지</a></li>
			</c:if>		
			<li><a href="#">출석체크</a></li>
			<li><a href="#">게시판</a></li>
			<li><a href="#">단어</a></li>
		</ul>
	</div>
