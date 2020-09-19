package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.dto.CCTV;
import com.ssafy.happyhouse.model.dto.Environment;
import com.ssafy.happyhouse.model.dto.PageBean;
import com.ssafy.happyhouse.model.dto.School;
import com.ssafy.happyhouse.model.dto.StoreInfo;
import com.ssafy.happyhouse.model.dto.Subway;
import com.ssafy.happyhouse.model.service.TourService;
import com.ssafy.happyhouse.util.PageNavigation;

@Controller
@RequestMapping("/tour.do")
public class TourController {
	
	@Autowired
	TourService tourService;
	
	@GetMapping("")
	public String move() {
		return "tour/tour";
	}
	
	@PostMapping("/store")
	public @ResponseBody Map<String, Object> searchStore(String code, String pg, String key, String word) throws Exception{
		System.out.println(code+", page: " + pg + ", key: " + key + ", word: " + word);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		PageBean pageBean = new PageBean();
		pageBean.setKey(key == null ? "" : key);
		pageBean.setWord(word == null ? "" : word);
		pageBean.setPg(Integer.parseInt(pg));
		PageNavigation pageNavigation = tourService.makePageNavigation(pageBean, code);
		List<StoreInfo> store = tourService.searchAllStore(pageBean, code);
		resultMap.put("stores", store);
		resultMap.put("navigation", pageNavigation);
		return resultMap;
	}
	
	@PostMapping("/cctv")
	public @ResponseBody List<CCTV> searchCctv(String code) throws Exception{
		return tourService.searchAllCCTV(code);
	}
	
	@PostMapping("/school")
	public @ResponseBody List<School> searchSchool(String code) throws Exception{
		return tourService.searchAllSchool(code);
	}
	
	@PostMapping("/subway")
	public @ResponseBody List<Subway> searchSubway(String code) throws Exception{
		return tourService.searchAllSubway(code);
	}
	
	@PostMapping("/environment")
	public @ResponseBody Environment searchEnvior(String code) throws Exception{
		return tourService.searchEnvironment(code);
	}
}
