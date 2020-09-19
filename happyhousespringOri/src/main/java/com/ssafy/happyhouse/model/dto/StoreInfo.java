package com.ssafy.happyhouse.model.dto;

import java.io.Serializable;

public class StoreInfo implements Serializable{
	/**상가 업소 번호*/
	private int no;
	/**상호명 */
	private String shopname;
	/**상권업종대분류명 */
	private String codename1;
	/**상권업종중분류명 */
	private String codename2;
	/**상권업종소분류명 */
	private String codename3;
	private String codename4;
	private String citycode;
	private String city;
	private String gucode;
	private String gu;
	private String dongcode;
	private String dong;
	/**지번주소 */
	private String jibuaddress;
	/**도로명주소 */
	private String address;
	private String postcode;
	private String lng;
	private String lat;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getShopname() {
		return shopname;
	}
	public void setShopname(String shopname) {
		this.shopname = shopname;
	}
	public String getCodename1() {
		return codename1;
	}
	public void setCodename1(String codename1) {
		this.codename1 = codename1;
	}
	public String getCodename2() {
		return codename2;
	}
	public void setCodename2(String codename2) {
		this.codename2 = codename2;
	}
	public String getCodename3() {
		return codename3;
	}
	public void setCodename3(String codename3) {
		this.codename3 = codename3;
	}
	public String getCodename4() {
		return codename4;
	}
	public void setCodename4(String codename4) {
		this.codename4 = codename4;
	}
	public String getCitycode() {
		return citycode;
	}
	public void setCitycode(String citycode) {
		this.citycode = citycode;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getGucode() {
		return gucode;
	}
	public void setGucode(String gucode) {
		this.gucode = gucode;
	}
	public String getGu() {
		return gu;
	}
	public void setGu(String gu) {
		this.gu = gu;
	}
	public String getDongcode() {
		return dongcode;
	}
	public void setDongcode(String dongcode) {
		this.dongcode = dongcode;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getJibunaddress() {
		return jibuaddress;
	}
	public void setJibunaddress(String jibuaddress) {
		this.jibuaddress = jibuaddress;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
}
