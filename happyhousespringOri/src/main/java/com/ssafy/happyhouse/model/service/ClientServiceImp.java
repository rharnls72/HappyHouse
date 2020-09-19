package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.ClientDao;
import com.ssafy.happyhouse.model.dto.Client;


@Service
public class ClientServiceImp implements ClientService {
	@Autowired
	ClientDao dao;
	
	/** 아디에 해당하는 회원 정보를 추출하는 기능*/
	@Override
	public Client search(String id)  throws Exception {
		return dao.search(id);
	}

	@Override
	public List<Client> clientlist(String key, String word) throws Exception {
		key = key == null ? "" : key;
		word = word == null ? "" : word;
		return dao.clientlist(key, word);
	}

	@Override
	public void add(Client client) throws Exception {
		dao.add(client);
	}

	@Override
	public void update(Client client) throws Exception {
		dao.update(client);
	}

	@Override
	public void remove(String id) throws Exception {
		dao.remove(id);
	}
}
