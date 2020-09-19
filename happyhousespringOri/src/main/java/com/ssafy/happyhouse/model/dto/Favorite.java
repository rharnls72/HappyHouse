package com.ssafy.happyhouse.model.dto;

public class Favorite {
	private int no;
	private String clientId;
	private String city;
	private String gugun;
	private String dong;
	private String code;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
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
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	@Override
	public String toString() {
		return "Favorite [no=" + no + ", clientId=" + clientId + ", city=" + city + ", gugun=" + gugun + ", dong="
				+ dong + ", code=" + code + "]";
	}
	
	
}
