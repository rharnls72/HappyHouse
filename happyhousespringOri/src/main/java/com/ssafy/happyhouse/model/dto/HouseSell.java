package com.ssafy.happyhouse.model.dto;

import java.io.Serializable;

public class HouseSell implements Serializable, Comparable<HouseSell> {
	public static String  APT_DEAL="아파트 매매";
	public static String  APT_RENT="아파트 전월세";
	public static String  HOUSE_DEAL="연립,주택 매매";
	public static String  HOUSE_RENT="연립,주택 전월세";
	private String seller;
	private String phone;
	/**거래 정보를 식별할 번호*/
	private int    no;
	/**법정 동명 */
	private String dong;
	/**아파트 이름 */
	private String aptName;
	/**법정 동코드 */
	private int code;
	/**거래 금액 */
	private String dealAmount;
	/**건축 연도*/
	private int buildYear;
	/**거래 연도*/
	private int regYear;
	/**거래 월 */
	private int regMonth;
	/**거래 일 */
	private int regDay;
	/**전용면적 */
	private double area;
	/**층*/
	private int floor;
	/**지번*/
	private String jibun;
	/**type
	 * 1 : 아파트 매매
	 * 2 : 연립 다세세 매매
	 * 3 : 아파트 전월세
	 * 4 : 연립 다세세 전월세
	 * */
	private String type;
	private String rentMoney;
	private String lat;
	private String lng;
	private boolean favorite=false;
	/**이미지 경로*/
	protected String img;
	
	public boolean isFavorite() {
		return favorite;
	}
	public void setFavorite(boolean favorite) {
		this.favorite = favorite;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	
	public String getSeller() {
		return seller;
	}
	public void setSeller(String seller) {
		this.seller = seller;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public HouseSell() {	}
	public HouseSell(int no) {
		super();
		this.no = no;
	}
	
	public static String getAPT_DEAL() {
		return APT_DEAL;
	}
	public static void setAPT_DEAL(String aPT_DEAL) {
		APT_DEAL = aPT_DEAL;
	}
	public static String getAPT_RENT() {
		return APT_RENT;
	}
	public static void setAPT_RENT(String aPT_RENT) {
		APT_RENT = aPT_RENT;
	}
	public static String getHOUSE_DEAL() {
		return HOUSE_DEAL;
	}
	public static void setHOUSE_DEAL(String hOUSE_DEAL) {
		HOUSE_DEAL = hOUSE_DEAL;
	}
	public static String getHOUSE_RENT() {
		return HOUSE_RENT;
	}
	public static void setHOUSE_RENT(String hOUSE_RENT) {
		HOUSE_RENT = hOUSE_RENT;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getAptName() {
		return aptName;
	}
	public void setAptName(String aptName) {
		this.aptName = aptName;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getDealAmount() {
		return dealAmount;
	}
	public void setDealAmount(String dealAmount) {
		this.dealAmount = dealAmount;
	}
	public int getBuildYear() {
		return buildYear;
	}
	public void setBuildYear(int buildYear) {
		this.buildYear = buildYear;
	}
	public int getRegYear() {
		return regYear;
	}
	public void setRegYear(int regYear) {
		this.regYear = regYear;
	}
	public int getRegMonth() {
		return regMonth;
	}
	public void setRegMonth(int regMonth) {
		this.regMonth = regMonth;
	}
	public int getRegDay() {
		return regDay;
	}
	public void setRegDay(int regDay) {
		this.regDay = regDay;
	}
	public double getArea() {
		return area;
	}
	public void setArea(double area) {
		this.area = area;
	}
	public int getFloor() {
		return floor;
	}
	public void setFloor(int floor) {
		this.floor = floor;
	}
	public String getJibun() {
		return jibun;
	}
	public void setJibun(String jibun) {
		this.jibun = jibun;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRentMoney() {
		return rentMoney;
	}
	public void setRentMoney(String rentMoney) {
		this.rentMoney = rentMoney;
	}
	@Override
	public String toString() {
		return "{no:'" + no + "', dong:'" + dong + "', AptName:'" + aptName + "', code:'" + code + "', dealAmount:'"
				+ dealAmount + "', buildYear:'" + buildYear + "', regYear:'" + regYear + "', regMonth:'" + regMonth
				+ "', regDay:'" + regDay + "', area:'" + area + "', floor:'" + floor
				+ "', jibun:'" + jibun + "', type:'" + type + "', rentMoney:'" + rentMoney + "', lat:'" + lat +"', lng:'" + lng +"'}";
	}
	@Override
	public int compareTo(HouseSell o) {
		return this.no-o.getNo();
	}
	
}






