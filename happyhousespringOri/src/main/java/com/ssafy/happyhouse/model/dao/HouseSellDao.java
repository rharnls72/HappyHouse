package com.ssafy.happyhouse.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.model.dto.HousePageBean;
import com.ssafy.happyhouse.model.dto.HouseSell;
@Mapper
public interface HouseSellDao {
	public int getTotalCount(HousePageBean  bean) throws SQLException ;
	/**
	 * 검색 조건(key) 검색 단어(word)에 해당하는 아파트 거래 정보(HouseInfo)를  검색해서 반환.  
	 * @param bean  검색 조건과 검색 단어가 있는 객체
	 * @return 조회한 식품 목록
	 */
	public List<HouseSell> searchAll(@Param("currentPage")int currentPage, @Param("sizePerPage")int sizePerPage, @Param("bean")HousePageBean  bean) throws SQLException;
	
	/**
	 * 아파트 식별 번호에 해당하는 아파트 거래 정보를 검색해서 반환. 
	 * @param no	검색할 아파트 식별 번호
	 * @return		아파트 식별 번호에 해당하는 아파트 거래 정보를 찾아서 리턴한다, 없으면 null이 리턴됨
	 */
	public List<HouseSell> search() throws SQLException;
	public int addSell(int no, String id) throws SQLException;
	public int deleteSell(int no, String id) throws SQLException;
	public int check(int no, String id) throws SQLException;
	public int houseSellReg(HouseSell houseSell) throws SQLException;
	public List<HouseSell> searchMyHome(String seller) throws SQLException;
	public int deletehouseSell(int no) throws SQLException;
	public HouseSell getHouseSell(int no) throws SQLException;
}

