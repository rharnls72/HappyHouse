package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.NoticeDto;
import com.ssafy.happyhouse.model.dto.PageBean;
import com.ssafy.happyhouse.util.PageNavigation;


public interface NoticeService {

	public void writeArticle(NoticeDto noticeno) throws Exception;
	public List<NoticeDto> listArticle(PageBean pageBean) throws Exception;
	public PageNavigation makePageNavigation(PageBean pageBean) throws Exception;

	public NoticeDto getArticle(int noticeno) throws Exception;
	public void modifyArticle(NoticeDto noticeDto) throws Exception;
	public void deleteArticle(int noticeno) throws Exception;
	
}
