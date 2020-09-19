package com.ssafy.happyhouse.model.dto;

public class CCTV {
	private int no; 
	private String city; 
	private String gugun; 
	private String dong; 
	private String guguncode; 
	private String dongcode; 
	private String code; 
	private String let; 
	private String lng;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
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
	public String getLet() {
		return let;
	}
	public void setLet(String let) {
		this.let = let;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	@Override
	public String toString() {
		return "CCTV [no=" + no + ", city=" + city + ", gugun=" + gugun + ", dong=" + dong + ", guguncode=" + guguncode
				+ ", dongcode=" + dongcode + ", code=" + code + ", let=" + let + ", lng=" + lng + "]";
	}

}
