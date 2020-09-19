package com.ssafy.happyhouse.util;

public class PageNavigation {

	private boolean startRange;// 현재 페이지가 초기범위
	private boolean endRange;//현재 페이지가 마지막 범위
	private int totalCount; //총글수
	private int newCount;
	private int totalPageCount; //총 페이지수
	private int currentPage; //현재 페이지수
	private int naviSize;//네비게이션 사이즈
	private int countPerPage;//페이지당 글갯수
	private String navigator;

	public boolean isStartRange() {
		return startRange;
	}

	public void setStartRange(boolean startRange) {
		this.startRange = startRange;
	}

	public boolean isEndRange() {
		return endRange;
	}

	public void setEndRange(boolean endRange) {
		this.endRange = endRange;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getNewCount() {
		return newCount;
	}

	public void setNewCount(int newCount) {
		this.newCount = newCount;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getNaviSize() {
		return naviSize;
	}

	public void setNaviSize(int naviSize) {
		this.naviSize = naviSize;
	}

	public String getNavigator() {
		return navigator;
	}

	public int getCountPerPage() {
		return countPerPage;
	}

	public void setCountPerPage(int countPerPage) {
		this.countPerPage = countPerPage;
	}

	public void makeNavigator() {
		int startPage = (currentPage-1)/naviSize * naviSize + 1; //21이 스타트페이지
		int endPage = startPage+naviSize-1; // 27이 마지막인데 현재페이지가 24면 30이됌
		if(totalPageCount < endPage) //27보다 30이 더크므로 27이 마지막
			endPage = totalPageCount;
		
		StringBuilder buffer = new StringBuilder();
		buffer.append("		<ul class=\"pagination\"> \n");
		buffer.append("			<li class=\"page-item\"> \n");
		buffer.append("				<a href=\"javascript:pageMove(1);\" class=\"page-link\">최신</a> \n");
		buffer.append("			</li> \n");
		buffer.append("			<li class=\"page-item\"> \n");
		buffer.append("				<a href=\"javascript:pageMove(" + (startRange ? 1: startPage-1) + ");\" class=\"page-link\">이전</a> \n");
		buffer.append("			</li> \n");
		for(int i=startPage;i<=endPage;i++) {
			buffer.append("			<li class=\"" + (currentPage == i ? "page-item active" : "page-item") + "\"><a href=\"javascript:pageMove(" + i + ");\" class=\"page-link\">" + i + "</a></li> \n");
		}
		buffer.append("			<li class=\"page-item\"> \n");
		buffer.append("				<a href=\"javascript:pageMove(" + (endRange ? endPage : endPage + 1) + ");\" class=\"page-link\">다음</a> \n");
		buffer.append("			</li> \n");
		buffer.append("			<li class=\"page-item\"> \n");
		buffer.append("				<a href=\"javascript:pageMove(" +  + totalPageCount + ");\" class=\"page-link\">마지막</a> \n");
		buffer.append("			</li> \n");
		buffer.append("		</ul> \n");
		this.navigator = buffer.toString();
	}

}
