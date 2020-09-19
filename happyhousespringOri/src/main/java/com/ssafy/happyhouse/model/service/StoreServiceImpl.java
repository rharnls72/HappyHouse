package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.StoreDao;
import com.ssafy.happyhouse.model.dto.PageBean;
import com.ssafy.happyhouse.model.dto.StoreInfo;
import com.ssafy.happyhouse.util.PageNavigation;
@Service
public class StoreServiceImpl implements StoreService{
   @Autowired
   private StoreDao dao;
   
   public List<StoreInfo> searchAll(PageBean pageBean, String code) throws Exception {
	   pageBean.setPg((pageBean.getPg()-1)*pageBean.getSpp());
      return dao.searchAll(pageBean, code);
   }
   @Override
   public PageNavigation makePageNavigation(PageBean pageBean, String code) throws Exception {
      PageNavigation pageNavigation = new PageNavigation();
      int naviSize = 10;
      pageNavigation.setCurrentPage(pageBean.getPg());
      pageNavigation.setNaviSize(naviSize);
      int totalCount = dao.getTotalCount(code, pageBean.getKey(), pageBean.getWord());
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
}
