package com.ssafy.happyhouse.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.dto.Client;
import com.ssafy.happyhouse.model.dto.HappyHouseException;
import com.ssafy.happyhouse.model.dto.HousePageBean;
import com.ssafy.happyhouse.model.dto.HouseSell;
import com.ssafy.happyhouse.model.dto.SidoCodeDTO;
import com.ssafy.happyhouse.model.service.FavoriteService;
import com.ssafy.happyhouse.model.service.HouseSellService;
import com.ssafy.happyhouse.util.PageNavigation;

import springfox.documentation.service.ResponseMessage;

@Controller
@RequestMapping("/sell.do")
public class SellController {
	@Autowired
	HouseSellService houseSellService;
	@Autowired
	FavoriteService favoriteService;
	
	@ExceptionHandler
	public ModelAndView handler(HappyHouseException e) {
		ModelAndView mav = new ModelAndView("error/error");
		mav.addObject("msg", e.getMessage());
		return mav;
	}
	
	@GetMapping("/list")
	public String list() {
		return "sell/sellmain";
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
	public @ResponseBody HouseSell showDetails(HttpServletRequest request, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		int sellNo = Integer.parseInt(request.getParameter("no"));
		HouseSell sell = null;
		try {
			sell = houseSellService.search(sellNo);
			File[] fileList = new File(request.getServletContext().getRealPath("/img")).listFiles();
			if(fileList != null) {
				for (File file : fileList) {
					String[] fileName = file.getName().split("\\.");
					if(sell.getAptName().contains(fileName[0])) {
						sell.setImg("/img/"+fileName[0]+"."+fileName[1]);
						break;
					}
				}
			}
			if(sell.getImg()==null) sell.setImg("/img/다세대주택.jpg");
			return sell;
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("거래 내역 세부 사항 조회 중 에러가 발생했습니다.");
		}
	}
	
	@RequestMapping("/sellsearch")
	public String searchSelllist(HttpServletRequest request, HttpSession session) {
		String path = "/sell/sellmain";
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
			List<HouseSell> list = houseSellService.searchAll(currentPage, sizePerPage, bean);
			Client client = (Client) session.getAttribute("userinfo");
			for (int i = 0, len = list.size(); i < len; i++) {
				if(houseSellService.check(list.get(i).getNo(), client.getId())>0) {
					list.get(i).setFavorite(true);
				}
			}
			request.setAttribute("sells", list);
			request.setAttribute("word", word);
			PageNavigation pageNavigation = houseSellService.makePageNavigation(currentPage, sizePerPage, bean);
			request.setAttribute("navigation", pageNavigation);
		}catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("거래 내역 조회 중 에러가 발생했습니다.");
		}
		return path;
	}
	@GetMapping("addSell/{no}")
	public @ResponseBody HouseSell addSell(@PathVariable int no, HttpSession session) {
		HouseSell sell = new HouseSell();
		try {
			Client client = (Client) session.getAttribute("userinfo");
			if(houseSellService.check(no, client.getId())>0) {
				sell.setFavorite(false);
			}else {
				houseSellService.addSell(no, client.getId());
				sell.setFavorite(true);
			}
			return sell;
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("찜 추가 중 에러가 발생했습니다.");
		}
	}
	@GetMapping("deleteSell/{no}")
	public @ResponseBody HouseSell deleteSell(@PathVariable int no, HttpSession session) {
		HouseSell sell = new HouseSell();
		try {
			Client client = (Client) session.getAttribute("userinfo");
			if(houseSellService.deleteSell(no, client.getId())>0) {
				sell.setFavorite(true);
			}else {
				sell.setFavorite(false);
			}
			return sell;
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("찜 추가 중 에러가 발생했습니다.");
		}
	}
}
