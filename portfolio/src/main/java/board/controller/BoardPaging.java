package board.controller;

import lombok.Data;

@Data
public class BoardPaging {
	private int totalSize;
	private int pageBlock;
	private int pageSize;
	private int currentPage;
	private StringBuffer paging;
	
	public void makePaging() {
		paging = new StringBuffer();
		int totalBlock = (totalSize + pageSize - 1) / pageSize;
		
		//1. 시작 페이지
		int startPage = (currentPage-1)/3 * 3 + 1; 
		System.out.println("startPage = " + startPage);
		//2. 끝 페이지
		int endPage = startPage + 3 - 1;
		
		//3. 끝 페이지 처리
		if(endPage > totalBlock) {
			endPage = totalBlock;
		}
		
		
		System.out.println("endPage = " + endPage);
		
		if(startPage < pageBlock) {
			//이전
			paging.append("<li class = 'disabled'><a href = '#' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>");
		}else {
			paging.append("<li class = ''><a href = 'boardList.do?pg="+(startPage-1)+"' aria-label = 'Previous'><span aria-hidden='true'>&laquo;</span></a></li>");
		}
		
		//[1][2][3]
		for(int i = startPage; i <= endPage; i++) {
			
			if(i == currentPage) {
				paging.append("<li class = 'active'><a href = 'boardList.do?pg="+i+"'>"+i+"<span class = 'sr-only'>"+i+"</span></a></li>");
			}
			if(i != currentPage) {
				paging.append("<li class=''><a href = 'boardList.do?pg="+i+"'>"+i+"<span class = 'sr-only'>"+i+"</span></a></li>");
			}	
		}
		
		if(endPage < totalBlock) {
			paging.append("<li class = ''><a href = 'boardList.do?pg="+(endPage+1)+"' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>");
		}else {
			paging.append("<li class = 'disabled'><a href = '#' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>");
		}
		
	}
	
}
