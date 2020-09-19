package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.HouseDeal;
import com.ssafy.happyhouse.model.dto.HousePageBean;
import com.ssafy.happyhouse.util.PageNavigation;
public interface HouseService {
	public List<HouseDeal> searchAll(int currentPage, int sizePerPage, HousePageBean  bean) throws Exception ;
	public HouseDeal search(int no) throws Exception ;
	public PageNavigation makePageNavigation(int currentPage, int sizePerPage, HousePageBean bean) throws Exception;
}
