package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.CCTVDao;
import com.ssafy.happyhouse.model.dao.EnvironmentDao;
import com.ssafy.happyhouse.model.dao.SchoolDao;
import com.ssafy.happyhouse.model.dao.StoreDao;
import com.ssafy.happyhouse.model.dao.SubwayDao;
import com.ssafy.happyhouse.model.dto.CCTV;
import com.ssafy.happyhouse.model.dto.Environment;
import com.ssafy.happyhouse.model.dto.PageBean;
import com.ssafy.happyhouse.model.dto.School;
import com.ssafy.happyhouse.model.dto.StoreInfo;
import com.ssafy.happyhouse.model.dto.Subway;
import com.ssafy.happyhouse.util.PageNavigation;

@Service
public class TourServiceImpl implements TourService {

	@Autowired
	private StoreDao storedao;
	@Autowired
	private CCTVDao cctvdao;
	@Autowired
	private SchoolDao schooldao;
	@Autowired
	private SubwayDao subwaydao;
	@Autowired
	private EnvironmentDao environmentdao;
	
	@Override
	public List<StoreInfo> searchAllStore(PageBean pageBean, String code) throws Exception {
		pageBean.setPg((pageBean.getPg()-1)*pageBean.getSpp());
	    return storedao.searchAll(pageBean, code);
	}

	@Override
	public PageNavigation makePageNavigation(PageBean pageBean, String code) throws Exception {
		PageNavigation pageNavigation = new PageNavigation();
	    int naviSize = 10;
	    pageNavigation.setCurrentPage(pageBean.getPg());
	    pageNavigation.setNaviSize(naviSize);
	    int totalCount = storedao.getTotalCount(code, pageBean.getKey(), pageBean.getWord());
	    pageNavigation.setTotalCount(totalCount);
	    int totalPageCount = (totalCount-1)/pageBean.getSpp() +1;
	    pageNavigation.setTotalPageCount(totalPageCount);
	    boolean startRange = pageBean.getPg() <= naviSize;
	    pageNavigation.setStartRange(startRange);
	    boolean endRange = (totalCount-1)/naviSize *naviSize<pageBean.getPg();
	    pageNavigation.setEndRange(endRange);
	    pageNavigation.makeNavigator();
	    return pageNavigation;
	}
	public int getTotalCount(String code) throws Exception{
		return storedao.getTotalCount(code, null, null);
	}
	public int cntMart(String code) throws Exception{
		return storedao.cntMart(code);
	}
	public int cntCafe(String code) throws Exception{
		return storedao.cntCafe(code);
	}
	
	@Override
	public List<CCTV> searchAllCCTV(String code) throws Exception {
		return cctvdao.searchAllCCTV(code);
	}
	public int cntCCTV(String code) throws Exception{
		return cctvdao.cntCCTV(code);
	}
	@Override
	public List<Subway> searchAllSubway(String code) throws Exception {
		return subwaydao.search(code);
	}
	public int getSubwayCount(String code) throws Exception {
		return subwaydao.getTotalCount(code);
	}
	public List<Subway> getSubway(String name) throws Exception{
		return subwaydao.getSubway(name);
	}
	@Override
	public List<School> searchAllSchool(String code) throws Exception {
		return schooldao.searchSchool(code);
	}

	@Override
	public int countElementary(String code) throws Exception {
		return schooldao.countElementary(code);
	}

	@Override
	public int countMiddle(String code) throws Exception {
		return schooldao.countMiddle(code);
	}

	@Override
	public int countHigh(String code) throws Exception {
		return schooldao.countHigh(code);
	}

	@Override
	public Environment searchEnvironment(String code) throws Exception {
		String city = environmentdao.searchCity(code);
		String gu = environmentdao.searchGugun(code);
		return environmentdao.searchEnvironment(city, gu);
	}

}
