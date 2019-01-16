package board.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import board.bean.BoardDTO;
import board.bean.CommentDTO;
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
		int pageSize = 10;
		int endNum = pg * pageSize;  
		int startNum = endNum - (pageSize - 1);
		//System.out.println("pg = " + pg + " startNum = " + startNum + " endNum = " + endNum);
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		return map;
	}
	
	//페이징 처리 메소드
	protected String makePaging(int pg) {
		BoardPaging bp = new BoardPaging();
		bp.setPageSize(10);
		bp.setTotalSize(totalSize());
		bp.setPageBlock(3);
		bp.setCurrentPage(pg);
		bp.makePaging();
		return bp.getPaging().toString();
	}
	
	//게시글 전체 목록 리턴
	protected int totalSize() {
		return boardDAO.getBoardCount();
	}
	
	//게시판 목록
	@RequestMapping("boardList.do")
	public String boardList(@RequestParam(required=false, defaultValue="1") int pg, Model model) {
		
		
		List<Map<String, String>> board_list = null;
		board_list = boardDAO.getBoardList(boardListSize(pg));
		model.addAttribute("board_list", board_list);
		model.addAttribute("display", "/board/boardList.jsp");
		model.addAttribute("pg", pg);
		model.addAttribute("totalSize", totalSize());
		model.addAttribute("paging", makePaging(pg));
		return "/main/index";
	}
	
	//게시판 글쓰기
	@RequestMapping(value="boardWrite.do", method=RequestMethod.GET)
	public String boardWrite(Model model, HttpSession httpSession) {
		
		if(httpSession.getAttribute("id") == null) {
			return "redirect:/member/login.do";
		}else {
			model.addAttribute("display", "/board/boardWrite.jsp");
			return "/main/index";
		}
	}
	
	//게시판 글등록 요청
	@RequestMapping(value="boardWrite.do", method=RequestMethod.POST)
	public String boardWrite(@ModelAttribute BoardDTO boardDTO, BindingResult bindingResult, Model model, HttpSession httpSession) {
		//DB 접속필요
		
		boardDTO.setB_id((String)httpSession.getAttribute("id"));
		new BoardValidator().validate(boardDTO, bindingResult);
		if(bindingResult.hasErrors()) {
			System.out.println(bindingResult.getFieldErrors());
			System.out.println("에러남-");
			model.addAttribute("display", "/board/boardWrite.jsp");
			return "/main/index";
		}
		boardDAO.insertBoard(boardDTO);	
		return "redirect:/board/boardList.do";
	}
	
	//게시판 읽기
	@RequestMapping(value="boardView.do", method=RequestMethod.GET)
	public String boardView(@RequestParam int b_no, Model model, @RequestParam int pg) {
		
		//게시글 내용
		BoardDTO boardDTO = boardDAO.getBoardOne(b_no);
		
		model.addAttribute("pg", pg);
		model.addAttribute("boardDTO", boardDTO);
		model.addAttribute("display", "/board/boardView.jsp");
		return "/main/index";
	}
	
	//답글 폼요청
	@RequestMapping(value="boardReplyForm.do", method=RequestMethod.POST)
	public String boardReplyForm(Model model, @RequestParam int b_no) {
		model.addAttribute("b_no", b_no);
		model.addAttribute("display", "/board/boardReply.jsp");
		return "/main/index";
	}
	
	//답글 등록요청
	@RequestMapping(value="boardReply.do", method=RequestMethod.POST)
	public String boardReply(@ModelAttribute BoardDTO boardDTO, Model model, HttpSession httpSession, @RequestParam(defaultValue="1", required=false) int pg,
								@RequestParam int b_no) {
		System.out.println("답글등록 들림");
		//변수 목록
		// b_no : 부모 B_NO, pg : 리스트에서 사용한 pg 값 리스트로 돌아갈 때 사용함 
		
		/*
		 *  1. pDTO 꺼내옴 select
		 *  2. B_REF, B_STEP 기준으로 B_STEP update
		 *  3. setter 초기화해서 집어넣음
		 */
		
		//1. pbDTO select
		BoardDTO pbDTO = boardDAO.getBoardOne(b_no);
		
		//2. B_STEP update
		boardDAO.updateStep(pbDTO);
		
		//3. boardDTO insert
		boardDTO.setB_id((String)httpSession.getAttribute("id"));
		boardDTO.setB_ref(pbDTO.getB_ref());
		boardDTO.setB_pno(pbDTO.getB_no());
		boardDTO.setB_lev(pbDTO.getB_lev());
		boardDTO.setB_step(pbDTO.getB_step());
		boardDAO.insertReply(boardDTO);
		
		return "redirect:boardList.do?pg="+pg;
	}
	
	//ajax 댓글 등록 요청
	@RequestMapping(value="cmtWrite.do", method=RequestMethod.POST)
	public ModelAndView cmtWrite(@ModelAttribute CommentDTO commentDTO, HttpSession httpSession) {
		System.out.println("댓글 비동기 받음");
		
		//1. 작성자 세팅
		commentDTO.setM_id((String)httpSession.getAttribute("id"));
		
		//2. 데이터 입력
		boardDAO.insertCmt(commentDTO);
		
		//3. 리스트 불러오기
		List<CommentDTO> cmtList = new ArrayList<>();
		cmtList = boardDAO.getCmtList(commentDTO.getB_no());
		
		//4. jsonView 설정
		ModelAndView mav = new ModelAndView();
		mav.addObject("cmtList", cmtList);
		mav.setViewName("jsonView");
		
		System.out.println(cmtList);
		
		//5. 리턴
		return mav;
	}
	
	//댓글 리스트 요청
	@RequestMapping(value = "cmtList.do", method=RequestMethod.POST)
	public ModelAndView cmtList(@RequestParam int b_no) {
		//댓글 목록
		List<CommentDTO> cmtList = boardDAO.getCmtList(b_no);
		return new ModelAndView("jsonView", "cmtList", cmtList);
	}
}
