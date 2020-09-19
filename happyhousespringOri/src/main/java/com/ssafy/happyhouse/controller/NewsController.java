package com.ssafy.happyhouse.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/news.do")
@Controller
public class NewsController {
	
	@GetMapping("newslist")
	public String newslist() {
		return "news/news";
	}
	
//	@GetMapping("qna")
//	public String qna() {
//		return "qna/index";
//	}
//	
}
