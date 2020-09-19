package com.ssafy.happyhouse.model.dto;

import java.io.Serializable;

public class PageBean implements Serializable {
	private int pg;
	private int spp=5;
	private String key;
	private String word;
	private String no;
	public int getPg() {
		return pg;
	}
	public void setPg(int pg) {
		this.pg = pg;
	}
	public int getSpp() {
		return spp;
	}
	public void setSpp(int spp) {
		this.spp = spp;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getWord() {
		return word;
	}
	public void setWord(String word) {
		this.word = word;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	
}
