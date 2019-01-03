package member.controller;


import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import member.bean.MemberDTO;
import member.bean.MemberRequestDTO;
import member.dao.MemberDAO;

@RequestMapping("/member/*")
@Controller
public class MemberController {
	@Autowired
	private MemberDAO memberDAO;
	
	@ModelAttribute("memberDTO")
	protected Object formBack() throws Exception {
		return new MemberDTO();
	}
	
	//가입 폼 접속
	@RequestMapping(value="join.do", method=RequestMethod.GET)
	public String joinForm(Model model) {
		//ModelAndView mav = new ModelAndView();
		//mav.addObject("memberDTO", new MemberRequestDTO());
		//mav.addObject("display", "/member/memberJoinForm.jsp");
		model.addAttribute("display", "/member/memberJoinForm.jsp");
		//mav.setViewName("/main/index");
		return "/main/index";
	}
	
	
	//회원가입 요청
	@RequestMapping(value="join.do", method=RequestMethod.POST)
	public String join(@ModelAttribute MemberDTO memberDTO, BindingResult bindingResult, Model model) {
		//dao 회원가입
		//memberDAO.memberJoin(map);
		
		new MemberValidator().validate(memberDTO, bindingResult);
		if(bindingResult.hasErrors()) {
			System.out.println("에러남 " + memberDTO);
			model.addAttribute("display", "/member/memberJoinForm.jsp");
			return "/main/index";
		}else {
			memberDAO.join(memberDTO);
			System.out.println("회원가입 성공");
			return "redirect:/main/index.do";
		}
	}
	
	//로그인 폼 접속
	@RequestMapping(value="login.do", method=RequestMethod.GET)
	public String loginForm(Model model) {
		model.addAttribute("display", "/member/memberLoginForm.jsp");
		return "/main/index";
	}
	
	//로그인 요청
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public String login(@ModelAttribute MemberDTO memberDTO, Model model, BindingResult bindingResult, HttpSession httpSession) {
		System.out.println("1" + memberDTO);
		System.out.println(checkId_Pwd(memberDTO));
		
		new MemberValidator().validate(memberDTO, bindingResult);
		if(bindingResult.hasFieldErrors("id") || bindingResult.hasFieldErrors("pwd")) {
			System.out.println("에러남 " + memberDTO);
			model.addAttribute("display", "/member/memberLoginForm.jsp");
			return "/main/index";
		}
		
		if(checkId_Pwd(memberDTO)) {
			System.out.println("로그인 성공");
			httpSession.setAttribute("id", memberDTO.getId());
			return "redirect:/main/index.do";
		}else {
			System.out.println("로그인 실패");
			return "redirect:/member/login.do";
		}
	}
	
	//아이디, 비밀번호로 DB확인
	protected boolean checkId_Pwd(MemberDTO memberDTO) {
		System.out.println("2" + memberDTO);
		return memberDAO.login(memberDTO);
	}
	
	@RequestMapping(value="logout.do", method=RequestMethod.GET)
	public String logout(HttpSession httpSession) {
		httpSession.invalidate();
		return "redirect:/main/index.do";
	}
	
	
		
		
}
