package com.ssafy.happyhouse.model.dao;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.model.dto.Environment;
@Mapper
public interface EnvironmentDao {
	public Environment searchEnvironment(String city, String gu) throws SQLException;
	public String searchCity (String code) throws SQLException;
	public String searchGugun (String code) throws SQLException;
}

