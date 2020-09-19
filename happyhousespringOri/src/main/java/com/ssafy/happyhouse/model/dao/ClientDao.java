package com.ssafy.happyhouse.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.dto.Client;
@Mapper
public interface ClientDao {
	public List<Client> clientlist(String key, String word) throws SQLException;
	public Client search(String id) 	throws SQLException;
	public void remove(String id) 		throws SQLException;
	public void add(Client client) 		throws SQLException;
	public void update(Client client) 	throws SQLException;
}
