package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.HouseDeal;
import com.ssafy.happyhouse.model.dto.HouseInfo;
import com.ssafy.happyhouse.model.dto.HousePageBean;
public interface HouseInfoService {
	
	public List<HouseInfo> searchAllHouseInfo() throws Exception ;

	public void addHouseInfo(HouseInfo h) throws Exception ;

	public void updateHouseInfo(HouseInfo h) throws Exception ;

	public void deleteHouseInfo(int n) throws Exception ;

	public HouseInfo searchHouseInfo(String[] list) throws Exception ;
}
