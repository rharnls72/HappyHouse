package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.dto.Client;
import com.ssafy.happyhouse.model.dto.HappyHouseException;
import com.ssafy.happyhouse.model.dto.NoticeDto;
import com.ssafy.happyhouse.model.dto.PageBean;
import com.ssafy.happyhouse.model.service.NoticeService;
import com.ssafy.happyhouse.util.PageNavigation;


@Controller
@RequestMapping("/notice.do")
public class NoticeController{
	@Autowired
	private NoticeService noticeService;
	
	@ExceptionHandler
	public ModelAndView handler(HappyHouseException e) {
		ModelAndView mav = new ModelAndView("error/error");
		mav.addObject("msg", e.getMessage());
		return mav;
	}
	
	@RequestMapping("/detail")
	private @ResponseBody NoticeDto detailNotice(@RequestParam int no){
		try{
			return noticeService.getArticle(no);
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("공지사항 조회 중 에러가 발생했습니다.");
		}
	}

	@RequestMapping("/delete")
	private String deleteArticle(@RequestParam int no){
		try {
			noticeService.deleteArticle(no);
			return "redirect:list?pg=1&key=&word=";
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("공지사항 삭제 중 에러가 발생했습니다.");
		}
	}

	@RequestMapping("/noticemodify")
	private String modifyArticle(NoticeDto notice){
		try {
			noticeService.modifyArticle(notice);
			return "redirect:list?pg=1&key=&word=";
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("공지사항 수정 중 에러가 발생했습니다.");
		}
		
	}
	@RequestMapping("/mvmodify")
	private String moveModifyArticle(@RequestParam int no, Model model){
		try {
			model.addAttribute("notice", noticeService.getArticle(no));
			return "Notice/modify";
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("공지사항 수정 중 에러가 발생했습니다.");
		}
	}
	
	@RequestMapping("/mvwrite")
	private String moveWriteNotice(){
		return "Notice/write";
	}

	@RequestMapping("/list")
	private String listArticle(PageBean pageBean, Model model){
		try {
			model.addAttribute("navigation", noticeService.makePageNavigation(pageBean));
			model.addAttribute("articles", noticeService.listArticle(pageBean));
			return "Notice/list";
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("공지사항 조회 중 에러가 발생했습니다.");
		}
	}

	@RequestMapping("/write")
	private String writeArticle(HttpSession session, NoticeDto notice){
		try {
			Client client = (Client) session.getAttribute("userinfo");
			notice.setId(client.getId());
			noticeService.writeArticle(notice);
			return "redirect:/notice.do/list?pg=1&key=&word=";
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("공지사항 작성 중 에러가 발생했습니다.");
		}
	}
}
