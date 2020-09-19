package com.ssafy.happyhouse.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.EnvironmentDao;
import com.ssafy.happyhouse.model.dto.Environment;
@Service
public class EnvironmentServiceImpl implements EnvironmentService{
	@Autowired
	private EnvironmentDao dao;
	
	public Environment searchEnvironment(String city, String gu) throws Exception {
		return dao.searchEnvironment(city, gu);
	}
}

