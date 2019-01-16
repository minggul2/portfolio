package typing.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/typing/*")
public class TypingController {
	
	@RequestMapping(value="kr.do", method=RequestMethod.GET)
	public String kr(Model model) {
		
		String q_sentence = "테스트 입니다.";
		int q_length = q_sentence.length();
		
		model.addAttribute("q_length", q_length);
		model.addAttribute("q_sentence", q_sentence);
		model.addAttribute("display", "/typing/sentence.jsp");
		return "/main/index";
	}
	
	//답안지 검사 요청
	@RequestMapping(value="answer.do", method=RequestMethod.POST)
	public @ResponseBody ModelAndView answer(@RequestParam String user_answer, @RequestParam String answer, @RequestParam double spd) {
		ModelAndView mav = new ModelAndView();
		System.out.println(user_answer);
		
		if(user_answer.equals(answer)) {
			System.out.println("정답");
		}else
			System.out.println("오답");
		System.out.println("속도 : " + spd);
		
		mav.addObject("q_sentence", "새로운 문제 테스트");
		mav.setViewName("jsonView");
		return mav;
	}
	
}
