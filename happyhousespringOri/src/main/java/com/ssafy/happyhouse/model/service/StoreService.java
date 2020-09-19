package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.PageBean;
import com.ssafy.happyhouse.model.dto.StoreInfo;
import com.ssafy.happyhouse.util.PageNavigation;
public interface StoreService {
	public List<StoreInfo> searchAll(PageBean pageBean, String code) throws Exception ;
	public PageNavigation makePageNavigation(PageBean pageBean, String code) throws Exception;
}
