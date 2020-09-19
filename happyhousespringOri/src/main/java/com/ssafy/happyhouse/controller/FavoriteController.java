package com.ssafy.happyhouse.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.dto.Client;
import com.ssafy.happyhouse.model.dto.Environment;
import com.ssafy.happyhouse.model.dto.Favorite;
import com.ssafy.happyhouse.model.dto.HappyHouseException;
import com.ssafy.happyhouse.model.dto.HouseInfo;
import com.ssafy.happyhouse.model.dto.HouseSell;
import com.ssafy.happyhouse.model.dto.SidoCodeDTO;
import com.ssafy.happyhouse.model.dto.Subway;
import com.ssafy.happyhouse.model.service.FavoriteService;
import com.ssafy.happyhouse.model.service.HouseInfoService;
import com.ssafy.happyhouse.model.service.HouseSellService;
import com.ssafy.happyhouse.model.service.TourService;

@RequestMapping("favorite.do")
@Controller
public class FavoriteController {
	@Autowired
    FavoriteService favoriteService;
	@Autowired
	TourService tourService;
	@Autowired
	HouseSellService houseSellService;
	@Autowired
	HouseInfoService infoService;
	
	@ExceptionHandler
	public ModelAndView handler(HappyHouseException e) {
		ModelAndView mav = new ModelAndView("error/error");
		mav.addObject("msg", e.getMessage());
		return mav;
	}
	
	@GetMapping("/gugun")
	public @ResponseBody List<SidoCodeDTO> gugun(String citycode) {
		try {
			return favoriteService.selectGugun(citycode);
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("시도 코드가 올바르지 않습니다.");
		}
	}
	
	@GetMapping("/dong")
	public @ResponseBody List<SidoCodeDTO> dong(String gucode) {
		try {
			return favoriteService.selectDong(gucode);
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("구군 코드가 올바르지 않습니다.");
		}
	}
	@GetMapping("deletefavorite/{no}")
	private String deleteFavorite(@PathVariable int no) {
		try {
			favoriteService.remove(no);
			return "redirect:/favorite.do/list"; 
		}catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("관심 지역 삭제 중 문제가 발생했습니다.");
		}
	}
	@GetMapping("deleteJjim/{no}")
	private String deleteJjim(@PathVariable int no, HttpSession session) {
		try {
			Client client = (Client) session.getAttribute("userinfo");
			System.out.println(no);
			houseSellService.deleteSell(no, client.getId());
			return "redirect:/favorite.do/jjimlist";
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("찜 추가 중 에러가 발생했습니다.");
		}
	}
	@GetMapping("deletehouseSell/{no}")
	private String deletehouseSell(@PathVariable int no) {
		try {
			houseSellService.deletehouseSell(no);
			return "redirect:/favorite.do/sellList"; 
		}catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("관심 지역 삭제 중 문제가 발생했습니다.");
		}
	}
	@PostMapping("addfavorite")
	private String addFavorite(Favorite favorite, HttpSession session){
		try {
			Client client = (Client)session.getAttribute("userinfo");
			if(favoriteService.searchCode(client.getId(), favorite.getCode())>0)
				throw new HappyHouseException();
			favorite = favoriteService.select(favorite.getCode());
			favorite.setClientId(client.getId());
			System.out.println(favorite.toString());
			favoriteService.add(favorite);
			return "redirect:/tour.do";
		}catch(HappyHouseException e) {
			throw new HappyHouseException("이미 추가되었습니다.");
		}catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("관심 지역 추가 중 문제가 발생했습니다.");
		}
	}
	@GetMapping("list")
	private String searchFavoritelist(HttpSession session, Model model) {
		try {
			Client client = (Client)session.getAttribute("userinfo");
			model.addAttribute("favorites", favoriteService.search(client.getId()));
			return "favorite/favorite";
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("관심 지역 리스트 조회 중 문제가 발생했습니다.");
		}
	}
	@GetMapping("jjimlist")
	private String searchFavoritehouse(HttpSession session, Model model) {
		try {
			Client client = (Client)session.getAttribute("userinfo");
			model.addAttribute("jjims", favoriteService.searchHouse(client.getId()));
			return "favorite/favorite";
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("관심 지역 리스트 조회 중 문제가 발생했습니다.");
		}
	}
	@PostMapping("tour")
	public @ResponseBody Map<String, Object> searchStore(String code) throws Exception{
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cntStore", tourService.getTotalCount(code));
		resultMap.put("cntMart", tourService.cntMart(code));
		resultMap.put("cntCafe", tourService.cntCafe(code));
		resultMap.put("cntCctv", tourService.cntCCTV(code));
		resultMap.put("cntElementary", tourService.countElementary(code));
		resultMap.put("cntMiddle", tourService.countMiddle(code));
		resultMap.put("cntHigh", tourService.countHigh(code));
		List<Subway> subway = tourService.searchAllSubway(code);
		int size = subway.size();
		resultMap.put("cntStation", size);
		String line = "";
		if(size>0)	line = subway.get(0).getLine()+"호선";
		for (int i = 1; i < size; i++) {
			line += ", "+subway.get(i).getLine()+"호선";
		}
		resultMap.put("line", line);
		Environment env = tourService.searchEnvironment(code);
		int score=(100-Integer.parseInt(env.getPm10().trim())*2) + (100-Integer.parseInt(env.getPm25().trim())*3)+
				(int)Math.round(Double.parseDouble(env.getGye().trim())/10) + (int)Math.round(Double.parseDouble(env.getGaeso_1().trim())/10);
		resultMap.put("env", score);
		return resultMap;
	}
	@PostMapping("tour/apt")
	public @ResponseBody Map<String, Object> searchApt(String code, String aptName, String lat, String lng) throws Exception{
		boolean[] school = new boolean[3];
		int cnt = 0;
		double dis = 0.0;
		double scLat = 0.0;
		double scLng = 0.0;
		double originLat = Double.parseDouble(lat);
		double originLng = Double.parseDouble(lng);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cntStore", tourService.getTotalCount(code));
		resultMap.put("cntMart", tourService.cntMart(code));
		resultMap.put("cntCafe", tourService.cntCafe(code));
		resultMap.put("cntCctv", tourService.cntCCTV(code));
		String myURL = "https://maps.googleapis.com/maps/api/place/textsearch/xml?query="+aptName.trim()+"&type=school&key=AIzaSyDNOPhmVtpKMZGHR9n3qmHdF3kPNiWz7gw";
		try {
			Document doc = Jsoup.connect(myURL).get();
			Elements elem = doc.getElementsByTag("result");
			for (Element element : elem) {
				if(!school[0] && element.getElementsByTag("name").text().contains("초등학교")) {
					scLat = Double.parseDouble(element.getElementsByTag("lat").get(0).text());
					scLng = Double.parseDouble(element.getElementsByTag("lng").get(0).text());
					cnt++;
					double theta = originLng - scLng;
			        double dist = Math.sin(originLat * Math.PI / 180.0) * Math.sin(scLat * Math.PI / 180.0) + Math.cos(originLat * Math.PI / 180.0) * Math.cos(scLat * Math.PI / 180.0) * Math.cos(theta * Math.PI / 180.0);
					dist = (Math.acos(dist) * 180 / Math.PI) * 60 * 1.1515 * 1.609344;
			        dis += dist;
			        resultMap.put("elementary",element.getElementsByTag("name").text());
			        resultMap.put("elementaryDis",Math.round(dist*100)/100.0);
					school[0] = true;
				} else if(!school[1] && element.getElementsByTag("name").text().contains("중학교")) {
					scLat = Double.parseDouble(element.getElementsByTag("lat").get(0).text());
					scLng = Double.parseDouble(element.getElementsByTag("lng").get(0).text());
					cnt++;
					double theta = originLng - scLng;
			        double dist = Math.sin(originLat * Math.PI / 180.0) * Math.sin(scLat * Math.PI / 180.0) + Math.cos(originLat * Math.PI / 180.0) * Math.cos(scLat * Math.PI / 180.0) * Math.cos(theta * Math.PI / 180.0);
					dist = (Math.acos(dist) * 180 / Math.PI) * 60 * 1.1515 * 1.609344;
			        dis += dist;
			        resultMap.put("middle",element.getElementsByTag("name").text());
			        resultMap.put("middleDis",Math.round(dist*100)/100.0);
					school[1] = true;
				} else if(!school[2] && element.getElementsByTag("name").text().contains("고등학교")) {
					scLat = Double.parseDouble(element.getElementsByTag("lat").get(0).text());
					scLng = Double.parseDouble(element.getElementsByTag("lng").get(0).text());
					cnt++;
					double theta = originLng - scLng;
			        double dist = Math.sin(originLat * Math.PI / 180.0) * Math.sin(scLat * Math.PI / 180.0) + Math.cos(originLat * Math.PI / 180.0) * Math.cos(scLat * Math.PI / 180.0) * Math.cos(theta * Math.PI / 180.0);
					dist = (Math.acos(dist) * 180 / Math.PI) * 60 * 1.1515 * 1.609344;
			        dis += dist;
			        resultMap.put("high",element.getElementsByTag("name").text());
			        resultMap.put("highDis",Math.round(dist*100)/100.0);
					school[2] = true;
				}
			}
			if(cnt == 0) {
				resultMap.put("cntSchool", 0);
			} else {
				resultMap.put("cntSchool",Math.round(cnt*cnt/dis * 1000)/1000.0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		myURL = "https://maps.googleapis.com/maps/api/place/textsearch/xml?query="+aptName.trim()+"&type=subway_station&language=ko&key=AIzaSyDNOPhmVtpKMZGHR9n3qmHdF3kPNiWz7gw";
		try {
			Document doc = Jsoup.connect(myURL).get();
			Elements elem = doc.getElementsByTag("result");
			if(elem.size() == 0) resultMap.put("cntSubway",0);
			else {
			    scLat = Double.parseDouble(elem.get(0).getElementsByTag("lat").get(0).text());
    			scLng = Double.parseDouble(elem.get(0).getElementsByTag("lng").get(0).text());
    			double theta = originLng - scLng;
    			double dist = Math.sin(originLat * Math.PI / 180.0) * Math.sin(scLat * Math.PI / 180.0) + Math.cos(originLat * Math.PI / 180.0) * Math.cos(scLat * Math.PI / 180.0) * Math.cos(theta * Math.PI / 180.0);
    			dist = (Math.acos(dist) * 180 / Math.PI) * 60 * 1.1515 * 1.609344;
    			String name = elem.get(0).getElementsByTag("name").get(0).text();
    			List<Subway> subway = tourService.getSubway(name);
    			String line="";
    			for (int i = 0, size = subway.size(); i < size; i++) {
    				line += subway.get(i).getLine()+", ";
    			}
    			if(!line.equals(""))	resultMap.put("line", line.substring(0, line.length()-2));
    			resultMap.put("subwayName", name);
    			resultMap.put("subwayDis", Math.round(dist * 100)/100.0);
    			resultMap.put("cntSubway",Math.round(1000/dist)/1000.0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		Environment env = tourService.searchEnvironment(code);
		int score=(100-Integer.parseInt(env.getPm10().trim())*2) + (100-Integer.parseInt(env.getPm25().trim())*3)+
				(int)Math.round(Double.parseDouble(env.getGye().trim())/10) + (int)Math.round(Double.parseDouble(env.getGaeso_1().trim())/10);
		resultMap.put("env", score);
		return resultMap;
	}
	@GetMapping("jjim/{no}")
	public @ResponseBody Map<String, Object> searchHouseSell(@PathVariable int no) throws Exception{
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HouseSell house = houseSellService.getHouseSell(no);
		HouseInfo info;
		String[] str = new String[3];
		str[0] = house.getDong().trim();
		str[1] = house.getCode()+"";
		str[2] = house.getJibun().trim();
		info = infoService.searchHouseInfo(str);
		if(info != null) {
			house.setLat(info.getLat());
			house.setLng(info.getLng());
		}
		resultMap.put("house", house);
		resultMap.put("code", favoriteService.getCode(house.getCode()+"", house.getDong().trim()));
		return resultMap;
	}
	@GetMapping("/sellList")
	public String searchMySell(HttpSession session, Model model){
		try {
			Client client = (Client)session.getAttribute("userinfo");
			model.addAttribute("houseSells", houseSellService.seachMyHome(client.getId()));
			return "favorite/favorite";
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("우리집 매물 리스트 조회 중 문제가 발생했습니다.");
		}
	}
	@PostMapping("/sellReg")
	public String houseSellReg(HouseSell houseSell, String gugun) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		houseSell.setRegYear(Integer.parseInt(sdf.format(date).substring(0, 4)));
		houseSell.setRegMonth(Integer.parseInt(sdf.format(date).substring(5, 7)));
		houseSell.setRegDay(Integer.parseInt(sdf.format(date).substring(8, 10)));
		houseSell.setCode(Integer.parseInt(gugun));
		try {
			houseSellService.houseSellReg(houseSell);
			String[] str = new String[3];
			str[0] = houseSell.getDong().trim();
			str[1] = houseSell.getCode()+"";
			str[2] = houseSell.getJibun().trim();
			HouseInfo info = infoService.searchHouseInfo(str);
			if(info == null) {
				info = new HouseInfo();
				info.setDong(houseSell.getDong());
				info.setAptName(houseSell.getAptName());
				info.setCode(houseSell.getCode());
				info.setBuildYear(houseSell.getBuildYear());
				info.setJibun(houseSell.getJibun());
				String myURL = "https://maps.googleapis.com/maps/api/place/textsearch/xml?query="+info.getDong()+info.getAptName()+"&key=AIzaSyBU23uuC5gK4VtUxxsoUqHRmYQoFunRa0s";
				try {
					Document doc = Jsoup.connect(myURL).get();
					Elements elem = doc.getElementsByTag("lat");
					info.setLat(elem.get(0).text());
					elem = doc.getElementsByTag("lng");
					info.setLng(elem.get(0).text());
				} catch (Exception e) {
					e.printStackTrace();
				}
				infoService.addHouseInfo(info);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new HappyHouseException("매물 등록 중 문제가 발생했습니다.");
		}
		return "redirect:/favorite.do/sellList";
	}
}
