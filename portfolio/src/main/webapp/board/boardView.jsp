<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<style>
	#container {
      width: 70%;
      margin: 0 auto;     /* 가로로 중앙에 배치 */
      padding-top: 3%;   /* 테두리와 내용 사이의 패딩 여백 */
    }
    
    th{
    	background-color: #b3c6ff;
    }
</style>

<div id = "container">
<form action="boardReplyForm.do" method="post">
    <div align="center">
        <input type="hidden" name="pg" value="${pg}">
        <input type = "hidden" id = "b_no" name = "b_no" value = "${boardDTO.b_no}">
         
      <table class = "table table-striped table-bordered" border="2" width="500">
        <tr>
          <th>글쓴이</th>
          <td>${boardDTO.b_id}</td>
          <th>조회수</th>
          <td>${boardDTO.b_hit}</td>
        </tr>
        <tr>
          <th>제목</th>
          <td id = "title" >${boardDTO.b_subject}</td>
          <th>날짜</th>
          <td>${boardDTO.b_logtime}</td>
        </tr>
       <%--  <tr>
          <th colspan="2">다운로드</th>
          <td colspan="2">
            <!-- 파일 다운로드 기능 -->
            <a href="">${article.fileName}</a>
            <a href="/bbs/download.bbs?fileName=${article.fileName}">${article.fileName}</a>
          </td>
        </tr> --%>
        <tr height="200" valign="top">
          <td colspan="4">${boardDTO.b_contents}</td>
        </tr>
        <%-- <tr>
          <th>첨부</th>
          <td colspan="3">
            <c:if test="${article.fileName == null}">없음</c:if>
            <c:if test="${article.fileName != null}">${article.fileName}</c:if>
          </td>
        </tr> --%>
        <tr>
          <td colspan="4" align="right">
            <!-- 로그인 검증 -->
            <%-- <c:if test="${id != null}">
              <input type="submit" value="답글달기">
              <c:if test="${id == article.id}">
                <input type="button" value="수정하기" onclick="document.location.href='/bbs/updateForm.bbs?articleNum=${article.articleNumber}&pageNum=${pageNum}'">
                <input type="button" value="삭제하기" onclick="document.location.href='/bbs/delete.bbs?articleNum=${article.articleNumber}&pageNum=${pageNum}'">
              </c:if>
              <c:if test="${id != article.id}">
                <input type="button" value="수정하기" disabled="disabled">
                <input type="button" value="삭제하기" disabled="disabled">
              </c:if>
            </c:if>
            <c:if test="${id == null}">
              <input type="submit" value="답글달기" disabled="disabled">
              <input type="button" value="수정하기" disabled="disabled">
              <input type="button" value="삭제하기" disabled="disabled">
            </c:if> --%>
            <input type="button" value="목록으로" onclick="document.location.href='/bbs/list.bbs?pageNum=${pageNum}'">
            <input type="submit" value = "답글작성">
          </td>
        </tr>
         
        <!-- Model 1 방식, 스트립트릿과 식을 이용한 방법 -->
        <!-- 상단부에 BBSDto import 필요 -->
        <%-- <%BBSDto article = (BBSDto)request.getAttribute("article"); %>
        <tr>
          <td>글쓴이 : </td>
          <td><%=article.getId() %></td>
        </tr>
        <tr>
          <td>제목 : </td>
          <td>
            <%=article.getTitle() %>
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <%=article.getContent() %>
          </td>
        </tr>
        <tr>
          <td>첨부 : </td>
          <td>
            <%if(article.getFileName() != null && !article.getFileName().equals("")) { %>
              <%=article.getFileName() %>
            <%} else { %>
              <span>없음</span>
            <%} %>
          </td>
        </tr> --%>
      </table>
    </div>
  </form>
  <div class="input-group" role="group" aria-label="..." style="margin-top: 10px; width: 100%;">
    <textarea class="form-control" rows="3" id="cmtContents" placeholder="댓글을 입력하세요." style="width: 100%;" ></textarea>
    <div class="btn-group btn-group-sm" role="group" aria-label="...">
        <c:if test="${id == null}">
            <input type="button" class="btn btn-default" value="댓글 쓰기" disabled="disabled">
        </c:if>
        <c:if test="${id != null}">
            <input type="button" class="btn btn-default" value="댓글 쓰기" id="commentWrite">
        </c:if>
        <input type="button" class="btn btn-default" value="댓글 읽기(${article.commentCount})" 
                onclick="getComment(1, event)" id="commentRead">
    </div>
</div>
 
<!-- Comment 태그 추가 -->
<div class="input-group" role="group" aria-label="..." style="margin-top: 10px; width: 100%;">
    <div id="showComment" style="text-align: center;"></div>
</div>
  </div>


<script>
	$(document).ready(function(){
		$.ajax({
			type : 'POST', url : 'cmtList.do', data : {'b_no' : $('#b_no').val()}, dataType : 'json',
			success : function(data){
				cmtMaker(data.cmtList);
			}
		});
		
		function cmtMaker(data){
			let html = "<table class='table table-striped table-bordered' style='margin-top: 10px;'><tbody>";
			$.each(data, function(index, item){
				html += "<tr>";
				html += "<td>"+ (index+1) +"</td>";
				html += "<td>"+ item.m_id +"</td>";
				html += "<td>"+ item.c_contents+"</td>";
				html += "<td>"+ item.c_logtime +"</td>";
				html += "</tr>";
			});
			html += "</tbody></table>";
			$("#showComment").html(html);
			$("#cmtContents").val("");
	        $("#cmtContents").focus();
		}
		
		$('#commentWrite').click(function(){
			$.ajax({
				type : 'POST',
				url : 'cmtWrite.do',
				data : {'c_contents' : $('#cmtContents').val(), 'b_no' : $('#b_no').val()},
				dataType : 'json',
				success : function(data){
					//댓글 작성 성공하면 코맨트 div에 추가해줘야함
					cmtMaker(data.cmtList);
				},
				error : function(){
					alert("실패");	
				}
			});
		});
	})
	
</script>




