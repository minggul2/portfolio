<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src = "http://code.jquery.com/jquery-3.3.1.min.js"></script>    
<%@include file="../template/header.jsp" %>
    <!-- main -->
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--main content start-->
    <section id="main-content">
      <section class="wrapper">
		<jsp:include page = "${display}"/>      
      </section>
    </section>
    <!--main content end-->
    
<%@include file="../template/footer.jsp" %>
