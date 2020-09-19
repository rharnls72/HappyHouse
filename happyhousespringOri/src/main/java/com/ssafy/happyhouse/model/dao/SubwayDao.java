package com.ssafy.happyhouse.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.dto.Subway;

@Mapper
public interface SubwayDao {
	public int getTotalCount(String code) throws SQLException ;
	public List<Subway> search(String code) throws SQLException;
	public List<Subway> getSubway(String name) throws SQLException;
}
