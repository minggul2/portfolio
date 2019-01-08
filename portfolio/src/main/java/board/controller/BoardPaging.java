package board.controller;

import lombok.Data;

@Data
public class BoardPaging {
	private int totalSize;
	private int endNum;
	private int startNum;
	private int currentPage;
	private int pg;
	
	public void makePaging() {
		int totalBlock = totalSize / 5;
		
		//1. 페이지 총 길이 구하기

		//2.
		
	}
	
}
