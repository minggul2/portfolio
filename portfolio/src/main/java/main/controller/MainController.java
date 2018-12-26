package main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	
	@RequestMapping(value="portfolio/main.do", method=RequestMethod.POST)
	public String main() {
		System.out.println("메인 들림");
	System.out.println();
		ModelAndView mav = new ModelAndView();
		mav.
		
		return "";
	}
	
}
