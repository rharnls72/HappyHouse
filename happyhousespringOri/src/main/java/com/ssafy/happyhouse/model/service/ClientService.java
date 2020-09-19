package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.Client;


public interface ClientService {
	/* 아디에 해당하는 회원 정보를 추출하는 기능*/
	public Client search(String id) throws Exception ;
	public List<Client> clientlist(String key, String word) throws Exception;
	
	/*회원 등록하는 기능*/
	public void add(Client client) throws Exception;
	public void update(Client client) throws Exception;
	public void remove(String id) throws Exception;
}
