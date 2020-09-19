package com.ssafy.happyhouse.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.model.dto.PageBean;
import com.ssafy.happyhouse.model.dto.StoreInfo;
@Mapper
public interface StoreDao {
   public int getTotalCount(@Param("code")String code, @Param("key")String key,@Param("word")String word) throws SQLException ;
   public List<StoreInfo> searchAll(@Param("pageBean")PageBean pageBean, @Param("code")String code) throws SQLException;
   public int cntMart(String code) throws SQLException;
   public int cntCafe(String code) throws SQLException;
}
