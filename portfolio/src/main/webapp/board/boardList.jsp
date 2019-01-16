<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>    
<a href = "boardWrite.do">글쓰기</a>
  <title>BBS List</title>
  <!-- Bootstrap -->
  <style>
    #container {
      /* width: 70%; */
      margin: 0 auto;     /* 가로로 중앙에 배치 */
      /* padding-top: 3%; */   /* 테두리와 내용 사이의 패딩 여백 */
    }
     
    #list {
      text-align: center;
    }
   
    #write {
      text-align: right;
    }
     
    /* Bootstrap 수정 */
    .table > thead {
      background-color: #b3c6ff;
    }
    .table > thead > tr > th {
      text-align: center;
    }
    .table-hover > tbody > tr:hover {
      background-color: #e6ecff;
    }
    .table > tbody > tr > td {
      text-align: center;
    }
    .table > tbody > tr > #title {
      text-align: left;
    }
     
    div > #paging {
      text-align: center;
    }
     
    .hit {
      animation-name: blink;
      animation-duration: 2s;
      animation-timing-function: ease;
      animation-iteration-count: infinite;
      /* 위 속성들을 한 줄로 표기하기 */
      /* -webkit-animation: blink 1.5s ease infinite; */
    }
     
    /* 애니메이션 지점 설정하기 */
    /* 익스플로러 10 이상, 최신 모던 브라우저에서 지원 */
    @keyframes blink {
      from {color: white;}
      30% {color: yellow;}
      to {color: red; font-weight: bold;}
      /* 0% {color:white;}
      30% {color: yellow;}
      100% {color:red; font-weight: bold;} */
    }
  </style>
  <div id="container">
    <div align="right">
      
    </div>
    <div id="list">
      <b>게시판 (전체 글: ${totalSize})</b>
    </div>
     
    <div id="write">
      <a href="boardWrite.do">글쓰기</a>
    </div>
     
    <div>
      <table class="table table-striped table-bordered table-hover">
        <thead>
          <tr>
            <th width="10%">번호</th>
            <th width="50%">제목</th>
            <th width="10%">작성자</th>
            <th width="20%">작성일</th>
            <th width="10%">조회</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="boardDTO" items="${board_list}" varStatus="status">
            <tr>
              <td>${boardDTO.B_NO}</td>
              <td id="title">
                <c:if test="${boardDTO.B_LEV > 0}">
                	<c:forEach begin="1" end ="${boardDTO.B_LEV}">
                		&emsp;
                	</c:forEach>
                	<img src = "/resources/img/reply.gif">
                </c:if>
                <a href="boardView.do?b_no=${boardDTO.B_NO}&pg=${pg}">${boardDTO.B_SUBJECT}</a>
                <c:if test="${boardDTO.B_HIT >= 0}">
                  <span class="hit">hit!</span>
                </c:if>
              </td>
              <td>${boardDTO.B_ID}</td>
              <td>${boardDTO.B_LOGTIME}</td>
              <td>${boardDTO.B_HIT}</td>
            <tr>
          </c:forEach>
        </tbody>
      </table>
      <div id = "paging">
		<ul class="pagination" style = "text-align : center;">
			${paging}
		</ul>
	   </div>
	</div>
  </div>



