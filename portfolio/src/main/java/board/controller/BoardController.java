package board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import board.bean.BoardDTO;
import board.dao.BoardDAO;

@RequestMapping("/board/*")
@Controller
public class BoardController {
	
	@Autowired
	private BoardDAO boardDAO;
	
	@ModelAttribute("boardDTO")
	public Object fromBack() throws Exception {
		return new BoardDTO();
	}
	
	//리스트 생성 메소드
	protected Map<String, Integer> boardListSize(int pg) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		int pageSize = 5;
		int endNum = pg * pageSize;  
		int startNum = endNum - (pageSize - 1);
		System.out.println("pg = " + pg + " startNum = " + startNum + " endNum = " + endNum);
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		return map;
	}
	
	//페이징 처리 메소드
	protected String makePaging(int pg) {
		BoardPaging bp = new BoardPaging();
		bp.setPageSize(5);
		bp.setTotalSize(totalSize());
		bp.setPageBlock(3);
		bp.setCurrentPage(pg);
		bp.makePaging();
		System.out.println(bp.getPaging());
		return bp.getPaging().toString();
	}
	
	//게시글 전체 목록 리턴
	protected int totalSize() {
		return boardDAO.getboardCount();
	}
	
	//게시판 목록
	@RequestMapping("boardList.do")
	public String boardList(@RequestParam(required=false, defaultValue="1") int pg, Model model) {
		
		System.out.println(boardListSize(pg));
		
		List<Map<String, String>> board_list = null;
		board_list = boardDAO.getBoardList(boardListSize(pg));
		System.out.println(board_list);
		model.addAttribute("board_list", board_list);
		model.addAttribute("display", "/board/boardList.jsp");
		model.addAttribute("pg", pg);
		model.addAttribute("totalSize", totalSize());
		model.addAttribute("paging", makePaging(pg));
		return "/main/index";
	}
	
	//게시판 글쓰기
	@RequestMapping(value="boardWrite.do", method=RequestMethod.GET)
	public String boardWrite(Model model) {
		
		model.addAttribute("display", "/board/boardWrite.jsp");
		return "/main/index";
	}
	
	//게시판 글등록 요청
	@RequestMapping(value="boardWrite.do", method=RequestMethod.POST)
	public String boardWrite(@ModelAttribute BoardDTO boardDTO, BindingResult bindingResult, Model model, HttpSession httpSession) {
		//DB 접속필요
		System.out.println(boardDTO);
		
		boardDTO.setB_id((String)httpSession.getAttribute("id"));
		new BoardValidator().validate(boardDTO, bindingResult);
		if(bindingResult.hasErrors()) {
			System.out.println("에러남-");
			model.addAttribute("display", "/board/boardWrite.jsp");
			return "/main/index";
		}
		boardDAO.board_insert(boardDTO);	
		return "redirect:/board/boardList.do";
	}
	
	//게시판 읽기
	@RequestMapping(value="boardView.do", method=RequestMethod.GET)
	public String boardView(@RequestParam int b_no, Model model) {
		
		BoardDTO boardDTO = boardDAO.getBoardOne(b_no);
		
		model.addAttribute("boardDTO", boardDTO);
		model.addAttribute("display", "/board/boardView.jsp");
		return "/main/index";
	}
	
}
