package com.ssafy.happyhouse.model.dto;

import java.io.Serializable;

public class Client implements Serializable ,Comparable<Client> {
	private int no;
	private String id 		;
	private String password	;
	private String name		;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public int compareTo(Client o) {
		if(this.getNo() > o.getNo())
			return 1;
		else if(this.getNo() < o.getNo())
			return -1;
		return 0;
	}
	
}
