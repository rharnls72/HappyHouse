package com.ssafy.happyhouse.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.FavoriteDao;
import com.ssafy.happyhouse.model.dto.Favorite;
import com.ssafy.happyhouse.model.dto.HouseInfo;
import com.ssafy.happyhouse.model.dto.HouseSell;
import com.ssafy.happyhouse.model.dto.SidoCodeDTO;

@Service
public class FavoriteServiceImpl implements FavoriteService {
	@Autowired
	FavoriteDao dao;
	
	@Override
	public List<Favorite> search(String userid) throws Exception {
		return dao.search(userid);
	}
	public List<HouseSell> searchHouse(String userid) throws Exception {
		return dao.searchHouse(userid);
	}
	@Override
	public void remove(int no) throws Exception {
		dao.remove(no);
	}
	@Override
	public boolean add(Favorite favorite) throws Exception {
		return dao.add(favorite);
	}
	@Override
	public ArrayList<SidoCodeDTO> selectSido() throws Exception {
		ArrayList<SidoCodeDTO> list = dao.selectSido();
		return list;
	}

	@Override
	public ArrayList<SidoCodeDTO> selectGugun(String sido) throws Exception {
		ArrayList<SidoCodeDTO> list = dao.selectGugun(sido);
		return list;
	}
	@Override
	public ArrayList<SidoCodeDTO> selectDong(String gugun) throws Exception {
		ArrayList<SidoCodeDTO> list = dao.selectDong(gugun);
		return list;
	}
	public Favorite select(String code)throws Exception{
		return dao.select(code);
	}
	public int searchCode(String userid, String code)throws Exception{
		return dao.searchCode(userid, code);
	}
	public String getCode(String code, String dong)throws Exception{
		return dao.getCode(code, dong).getCode();
	}
}
