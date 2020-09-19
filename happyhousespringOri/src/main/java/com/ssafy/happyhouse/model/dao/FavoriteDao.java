package com.ssafy.happyhouse.model.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.dto.Favorite;
import com.ssafy.happyhouse.model.dto.HouseInfo;
import com.ssafy.happyhouse.model.dto.HouseSell;
import com.ssafy.happyhouse.model.dto.SidoCodeDTO;
@Mapper
public interface FavoriteDao {
		public List<Favorite> search(String userid) 	throws SQLException;
		public List<HouseSell> searchHouse(String userid) throws SQLException ;
		public void remove(int no) 		throws SQLException;
		public boolean add(Favorite favorite) 		throws SQLException;
		ArrayList<SidoCodeDTO> selectSido() 		throws SQLException;
		ArrayList<SidoCodeDTO> selectGugun(String sido) 		throws SQLException;
		ArrayList<SidoCodeDTO> selectDong(String gugun)	throws SQLException;
		public Favorite select(String code)	throws SQLException;
		public int searchCode(String userid, String code)throws SQLException;
		public Favorite getCode(String code, String dong)throws SQLException;
}
