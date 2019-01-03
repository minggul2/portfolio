package main.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import main.bean.SampleDTO;

@RequestMapping("/main/*")
@Controller
public class MainController {
	
	@RequestMapping(value="index.do", method=RequestMethod.GET)
	public ModelAndView main() {
		System.out.println("메인 들림");
		ModelAndView mav = new ModelAndView();
		mav.addObject("display", "/main/main.jsp");			
		mav.setViewName("/main/index");						//webapp/main/index.jsp 로 설정
		return mav;
	}
	
	@RequestMapping(value="/json_test.do", method=RequestMethod.GET)
	public @ResponseBody SampleDTO json_test() {
		SampleDTO sampleDTO = new SampleDTO();
		sampleDTO.setAge(10);
		sampleDTO.setName("홍길동");
		return sampleDTO;
	}
	
}
