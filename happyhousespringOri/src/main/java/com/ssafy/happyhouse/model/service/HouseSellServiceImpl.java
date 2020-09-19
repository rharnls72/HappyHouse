package com.ssafy.happyhouse.model.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.HouseSellDao;
import com.ssafy.happyhouse.model.dto.HappyHouseException;
import com.ssafy.happyhouse.model.dto.HouseInfo;
import com.ssafy.happyhouse.model.dto.HousePageBean;
import com.ssafy.happyhouse.model.dto.HouseSell;
import com.ssafy.happyhouse.util.PageNavigation;
@Service
public class HouseSellServiceImpl implements HouseSellService{
	@Autowired
   private HouseSellDao dao;
	@Autowired
   private HouseInfoService infoService;
   /**
    * 검색 조건(key) 검색 단어(word)에 해당하는 아파트 거래 정보(HouseInfo)를  검색해서 반환.  
    * @param bean  검색 조건과 검색 단어가 있는 객체
    * @return 조회한 식품 목록
    */
   public List<HouseSell> searchAll(int currentPage, int sizePerPage, HousePageBean  bean) throws Exception {
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
       List<HouseSell> list = dao.searchAll((currentPage - 1) * sizePerPage, sizePerPage, bean);
       String[] str = new String[3];
       HouseInfo info;
       for (HouseSell houseSell : list) {
		str[0] = houseSell.getDong().trim();
		str[1] = houseSell.getCode()+"";
		str[2] = houseSell.getJibun().trim();
		info = infoService.searchHouseInfo(str);
		if(info != null) {
			houseSell.setLat(info.getLat());
			houseSell.setLng(info.getLng());
		}
	}
       return list;
   }
   
   /**
    * 아파트 식별 번호에 해당하는 아파트 거래 정보를 검색해서 반환. 
    * @param no   검색할 아파트 식별 번호
    * @return      아파트 식별 번호에 해당하는 아파트 거래 정보를 찾아서 리턴한다, 없으면 null이 리턴됨
    */
   public HouseSell search(int no)  throws Exception {
	   List<HouseSell> list = dao.search();
	   HouseSell deal = new HouseSell();
	   deal.setNo(no);
	   int find = Collections.binarySearch(list, deal);
	   deal = list.get(find);
	   HouseInfo info = infoService.searchHouseInfo(new String[] {deal.getDong().trim(), deal.getCode()+"", deal.getJibun()+""});
	   if(info != null) {
		   deal.setLat(info.getLat());
		   deal.setLng(info.getLng());
	   }
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
	public int addSell(int no, String id) throws Exception{
		return dao.addSell(no, id);
	}
	public int deleteSell(int no, String id) throws Exception{
		return dao.deleteSell(no, id);
	}
	public int check(int no, String id) throws Exception{
		return dao.check(no, id);
	}

	@Override
	public void houseSellReg(HouseSell houseSell) throws Exception {
		int result = dao.houseSellReg(houseSell);
		if(result != 1) throw new HappyHouseException();
	}

	@Override
	public List<HouseSell> seachMyHome(String seller) throws Exception {
		return dao.searchMyHome(seller);
	}
	public int deletehouseSell(int no) throws Exception{
		return dao.deletehouseSell(no);
	}
	public HouseSell getHouseSell(int no) throws Exception{
		return dao.getHouseSell(no);
	}
}



