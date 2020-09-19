package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.ssafy.happyhouse.model.dto.Favorite;
import com.ssafy.happyhouse.model.dto.HouseInfo;
import com.ssafy.happyhouse.model.dto.HouseSell;
import com.ssafy.happyhouse.model.dto.SidoCodeDTO;

public interface FavoriteService {
	
	public List<Favorite> search(String userid) throws Exception ;
	public List<HouseSell> searchHouse(String userid) throws Exception ;
	public void remove(int no) throws Exception ;
	public boolean add(Favorite favorite) throws Exception ;
	ArrayList<SidoCodeDTO> selectSido() throws Exception;
	ArrayList<SidoCodeDTO> selectGugun(String sido) throws Exception;
	ArrayList<SidoCodeDTO> selectDong(String gugun) throws Exception;
	public Favorite select(String code)throws Exception;
	public int searchCode(String userid, String code)throws Exception;
	public String getCode(String code, String dong)throws Exception;
}
