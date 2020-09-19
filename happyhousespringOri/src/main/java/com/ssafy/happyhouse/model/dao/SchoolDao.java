package com.ssafy.happyhouse.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.dto.School;

@Mapper
public interface SchoolDao {
	List<School> searchSchool(String code);
	int countElementary(String code);
	int countMiddle(String code);
	int countHigh(String code);
}
