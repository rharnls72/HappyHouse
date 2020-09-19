package com.ssafy.happyhouse.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.dto.CCTV;

@Mapper
public interface CCTVDao {
	public List<CCTV> searchAllCCTV(String code) throws SQLException;
	public int cntCCTV(String code) throws SQLException;
}
