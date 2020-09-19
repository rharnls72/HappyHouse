package com.ssafy.happyhouse.model.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.HouseDao;
import com.ssafy.happyhouse.model.dto.HouseDeal;
import com.ssafy.happyhouse.model.dto.HouseInfo;
import com.ssafy.happyhouse.model.dto.HousePageBean;
import com.ssafy.happyhouse.util.PageNavigation;
@Service
public class HouseServiceImpl implements HouseService{
	@Autowired
   private HouseDao dao;
	@Autowired
   private HouseInfoService infoService;
   /**
    * 검색 조건(key) 검색 단어(word)에 해당하는 아파트 거래 정보(HouseInfo)를  검색해서 반환.  
    * @param bean  검색 조건과 검색 단어가 있는 객체
    * @return 조회한 식품 목록
    */
   public List<HouseDeal> searchAll(int currentPage, int sizePerPage, HousePageBean  bean) throws Exception {
	   boolean[] types = bean.getSearchType();
       int cnt=0;
       for(boolean t : types) {
          if(t) {
             cnt++;
          }
       }
       if(cnt==0) {
          throw new Exception();
       }
       List<HouseDeal> list = dao.searchAll((currentPage - 1) * sizePerPage, sizePerPage, bean);
       String[] str = new String[3];
       HouseInfo info;
       for (HouseDeal houseDeal : list) {
		str[0] = houseDeal.getDong().trim();
		str[1] = houseDeal.getCode()+"";
		str[2] = houseDeal.getJibun().trim();
		info = infoService.searchHouseInfo(str);
		houseDeal.setLat(info.getLat());
		houseDeal.setLng(info.getLng());
	}
       return list;
   }
   
   /**
    * 아파트 식별 번호에 해당하는 아파트 거래 정보를 검색해서 반환. 
    * @param no   검색할 아파트 식별 번호
    * @return      아파트 식별 번호에 해당하는 아파트 거래 정보를 찾아서 리턴한다, 없으면 null이 리턴됨
    */
   public HouseDeal search(int no)  throws Exception {
	   List<HouseDeal> list = dao.search();
	   HouseDeal deal = new HouseDeal();
	   deal.setNo(no);
	   int find = Collections.binarySearch(list, deal);
	   deal = list.get(find);
	   HouseInfo info = infoService.searchHouseInfo(new String[] {deal.getDong().trim(), deal.getCode()+"", deal.getJibun()+""});
	   deal.setLat(info.getLat());
	   deal.setLng(info.getLng());
	   return deal;
   }

	@Override
	public PageNavigation makePageNavigation(int currentPage, int sizePerPage, HousePageBean bean) throws Exception {
		PageNavigation pageNavigation = new PageNavigation();
		int naviSize = 10;
		pageNavigation.setCurrentPage(currentPage);
		pageNavigation.setNaviSize(naviSize);
		int totalCount = dao.getTotalCount(bean);
		pageNavigation.setTotalCount(totalCount);
		int totalPageCount = (totalCount-1)/sizePerPage +1;
		pageNavigation.setTotalPageCount(totalPageCount);
		boolean startRange = currentPage <= naviSize;
		pageNavigation.setStartRange(startRange);
		boolean endRange = (totalCount-1)/naviSize *naviSize<currentPage;
		pageNavigation.setEndRange(endRange);
		pageNavigation.makeNavigator();
		return pageNavigation;
	}
}



