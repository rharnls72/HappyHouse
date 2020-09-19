package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.NoticeDao;
import com.ssafy.happyhouse.model.dto.NoticeDto;
import com.ssafy.happyhouse.model.dto.PageBean;
import com.ssafy.happyhouse.util.PageNavigation;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeDao noticeDao;
	

	@Override
	public void writeArticle(NoticeDto noticeDto) throws Exception {
		if(noticeDto.getSubject() == null || noticeDto.getContent() == null) {
			throw new Exception();
		}
		noticeDao.writeArticle(noticeDto);
	}

	@Override
	public List<NoticeDto> listArticle(PageBean pageBean) throws Exception {
		pageBean.setPg((pageBean.getPg()-1)*pageBean.getSpp());
		return noticeDao.listArticle(pageBean);
	}

	@Override
	public NoticeDto getArticle(int noticeno) throws Exception {
		return noticeDao.getArticle(noticeno);
	}

	@Override
	public void modifyArticle(NoticeDto noticeDto) throws Exception {
		noticeDao.modifyArticle(noticeDto);
	}

	@Override
	public void deleteArticle(int noticeno) throws Exception {
		noticeDao.deleteArticle(noticeno);
	}

	@Override
	public PageNavigation makePageNavigation(PageBean pageBean) throws Exception {
		PageNavigation pageNavigation = new PageNavigation();
		int naviSize = 10;
		pageNavigation.setCurrentPage(pageBean.getPg());
		pageNavigation.setNaviSize(naviSize);
		int totalCount = noticeDao.getTotalCount(pageBean.getKey(), pageBean.getWord()); //총 개시글 수
		pageNavigation.setTotalCount(totalCount);
		int totalPageCount = (totalCount-1)/pageBean.getSpp()+1; //전체 페이지수 계산하는 공식 만들어
		pageNavigation.setTotalPageCount(totalPageCount); //세팅
		boolean startRange = pageBean.getPg()<=naviSize; //startpage가 true 면 이전 뭇눌러 false면 이전 눌러
		pageNavigation.setStartRange(startRange);
		boolean endRange = (totalPageCount-1)/ naviSize * naviSize < pageBean.getPg(); //endrange가 트루면 다음 못눌러 false면 다음 눌러
		pageNavigation.setEndRange(endRange);
		pageNavigation.makeNavigator();
		return pageNavigation;
	}

}
