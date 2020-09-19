package com.ssafy.happyhouse.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.dto.HappyHouseException;
import com.ssafy.happyhouse.model.dto.HouseDeal;
import com.ssafy.happyhouse.model.dto.HouseInfo;
import com.ssafy.happyhouse.model.dto.HousePageBean;
import com.ssafy.happyhouse.model.dto.SidoCodeDTO;
import com.ssafy.happyhouse.model.service.FavoriteService;
import com.ssafy.happyhouse.model.service.HouseService;
import com.ssafy.happyhouse.util.PageNavigation;

@Controller
@RequestMapping("/main.do")
public class DealController {
	@Autowired
	HouseService houseServiece;
	@Autowired
	FavoriteService favoriteService;
	
	@ExceptionHandler
	public ModelAndView handler(HappyHouseException e) {
		ModelAndView mav = new ModelAndView("error/error");
		mav.addObject("msg", e.getMessage());
		return mav;
	}
	
	@GetMapping("/deal")
	public String deal() {
		return "deal/dealmain";
	}
	@GetMapping("/gugun")
	public @ResponseBody List<SidoCodeDTO> gugun(String sido) {
		try {
			return favoriteService.selectGugun(sido);
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("시도 코드가 올바르지 않습니다.");
		}
	}
	
	@GetMapping("/dong")
	public @ResponseBody List<SidoCodeDTO> dong(String gugun) {
		try {
			return favoriteService.selectDong(gugun);
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("구군 코드가 올바르지 않습니다.");
		}
	}
	
	@GetMapping("/detail")
	public @ResponseBody HouseDeal showDetails(HttpServletRequest request, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
//		System.out.println(request.getParameter("no"));
		int dealno = Integer.parseInt(request.getParameter("no"));
		HouseDeal deal = null;
		try {
			deal = houseServiece.search(dealno);
			File[] fileList = new File(request.getServletContext().getRealPath("/img")).listFiles();
			if(fileList != null) {
				for (File file : fileList) {
					String[] fileName = file.getName().split("\\.");
					if(deal.getAptName().contains(fileName[0])) {
						deal.setImg("/img/"+fileName[0]+"."+fileName[1]);
						break;
					}
				}
			}
			if(deal.getImg()==null) deal.setImg("/img/다세대주택.jpg");
			return deal;
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("거래 내역 세부 사항 조회 중 에러가 발생했습니다.");
		}
	}
	
	@RequestMapping("/dealsearch")
	public String searchDeallist(HttpServletRequest request) {
		String path = "/deal/dealmain";
		int currentPage = Integer.parseInt(request.getParameter("pg"));
		String spp = request.getParameter("spp");
		int sizePerPage = spp == null ? 5 : Integer.parseInt(spp);//sizePerPage
		try {
			String[] types = request.getParameterValues("type");
			HousePageBean bean = new HousePageBean();
			boolean[] type = new boolean[4];
			for (int i = 0, len=types.length; i < len; i++) {
				switch (types[i]) {
				case "APT_DEAL":	type[0]=true;	break;
				case "APT_RENT":	type[1]=true;	break;
				case "HOUSE_DEAL":	type[2]=true;	break;
				case "HOUSE_RENT":	type[3]=true;	break;
				}
			}
			bean.setSearchType(type);
			String word = request.getParameter("word");
			if(!word.isEmpty()) {
				bean.setAptname(word);
			}
			String dong = request.getParameter("dong").trim();
			if(!dong.equals("0")) {
				bean.setDong(dong);
				bean.setDongcode(request.getParameter("gugun").trim());
				request.setAttribute("dong", dong);
				request.setAttribute("sido", request.getParameter("sido"));
				request.setAttribute("gugun", request.getParameter("guname"));
				request.setAttribute("gucode", request.getParameter("gugun"));
			}
			List<HouseDeal> list = houseServiece.searchAll(currentPage, sizePerPage, bean);
			request.setAttribute("deals", list);
			request.setAttribute("word", word);
			PageNavigation pageNavigation = houseServiece.makePageNavigation(currentPage, sizePerPage, bean);
			request.setAttribute("navigation", pageNavigation);
		}catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("거래 내역 조회 중 에러가 발생했습니다.");
		}
		return path;
	}
}
