package com.ssafy.happyhouse.model.dto;

public class Subway {
	
	private int no; 
	private String name; 
	private int line; 
	private String gugun; 
	private String dong;
	private String guguncode; 
	private String dongcode; 
	private String code; 
	private String address;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getLine() {
		return line;
	}
	public void setLine(int line) {
		this.line = line;
	}
	public String getGugun() {
		return gugun;
	}
	public void setGugun(String gugun) {
		this.gugun = gugun;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getGuguncode() {
		return guguncode;
	}
	public void setGuguncode(String guguncode) {
		this.guguncode = guguncode;
	}
	public String getDongcode() {
		return dongcode;
	}
	public void setDongcode(String dongcode) {
		this.dongcode = dongcode;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Override
	public String toString() {
		return "Subway [no=" + no + ", name=" + name + ", line=" + line + ", gugun=" + gugun + ", dong=" + dong
				+ ", guguncode=" + guguncode + ", dongcode=" + dongcode + ", code=" + code + ", address=" + address
				+ "]";
	}
}
