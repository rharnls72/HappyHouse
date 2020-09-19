package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.dto.HousePageBean;
import com.ssafy.happyhouse.model.dto.HouseSell;
import com.ssafy.happyhouse.util.PageNavigation;
public interface HouseSellService {
	public List<HouseSell> searchAll(int currentPage, int sizePerPage, HousePageBean  bean) throws Exception ;
	public HouseSell search(int no) throws Exception ;
	public PageNavigation makePageNavigation(int currentPage, int sizePerPage, HousePageBean bean) throws Exception;
	public int addSell(int no, String id) throws Exception;
	public int deleteSell(int no, String id) throws Exception;
	public int check(int no, String id) throws Exception;
	public void houseSellReg(HouseSell houseSell) throws Exception;
	public List<HouseSell> seachMyHome (String seller) throws Exception;
	public int deletehouseSell(int no) throws Exception;
	public HouseSell getHouseSell(int no) throws Exception;
}
