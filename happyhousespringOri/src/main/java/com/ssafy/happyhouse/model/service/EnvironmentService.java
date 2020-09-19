package com.ssafy.happyhouse.model.service;


import com.ssafy.happyhouse.model.dto.Environment;
public interface EnvironmentService {
	public Environment searchEnvironment(String city, String gu) throws Exception ;
}
