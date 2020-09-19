package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.dto.CCTV;
import com.ssafy.happyhouse.model.dto.Environment;
import com.ssafy.happyhouse.model.dto.Favorite;
import com.ssafy.happyhouse.model.dto.PageBean;
import com.ssafy.happyhouse.model.dto.School;
import com.ssafy.happyhouse.model.dto.StoreInfo;
import com.ssafy.happyhouse.model.dto.Subway;
import com.ssafy.happyhouse.util.PageNavigation;

public interface TourService {
	
	//환경
	public Environment searchEnvironment(String code) throws Exception ;
	
	//상점 
	public List<StoreInfo> searchAllStore(PageBean pageBean, String code) throws Exception ;
	public PageNavigation makePageNavigation(PageBean pageBean, String code) throws Exception;
	public int getTotalCount(String code) throws Exception;
	public int cntMart(String code) throws Exception;
	public int cntCafe(String code) throws Exception;
	//cctv 
	public List<CCTV> searchAllCCTV(String code) throws Exception;
	public int cntCCTV(String code) throws Exception;
	
	//지하철
	public List<Subway> searchAllSubway(String code) throws Exception;
	public int getSubwayCount(String code) throws Exception ;
	public List<Subway> getSubway(String name) throws Exception;
	
	//학교
	public List<School> searchAllSchool(String code) throws Exception;
	public int countElementary(String code) throws Exception;
	public int countMiddle(String code) throws Exception;
	public int countHigh(String code) throws Exception;
	
}
